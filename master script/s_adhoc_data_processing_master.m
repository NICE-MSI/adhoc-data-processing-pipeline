% Script originally written and currently maintained by Teresa Murta.

% This script contains a modular mass spectrometry data analysis pipeline, and it can be used to perform the following steps:
% 1	DESI, MALSI, SIMS or REIMS data pre-processing (using SpectralAnalysis functions)
% 2	Peak detection on a representative spectrum (using SpectralAnalysis functions)
% 3	Matching of the peaks detected in the representative spectrum against HMDB and/or a group of lists of molecules of interest defined by the user
% 4	Creating and saving a datacube (SpectralAnalysis DataRepresentation structure) for each imzml of interest (using SpectralAnalysis functions)
% 5	Creating and saving a data matrix for each normalisation algorithm of interest
% 6	Working with a new �dataset� which is defined as the combination the original imzmls files. This step involves the specification of the groups of original imzmls files that need to be combined, of which masks (defined in 10) are to be used to reduce each original imzml file to a smaller group of pixels of interest, the geometric position of each small group of pixels of interest in the new �dataset� (its position in a 2D grid that will contain all the groups of pixels of interest from all the imzmls combined)
% 7	Saving single ion images for:
% 7.1	One or more lists of molecules of interest defined by the user
% 7.2	One or more superclass, class, or subclass of molecules (as defined by HMDB)
% 7.3	A lists of m/z values
% 8	Running PCA, NMF, k-means, t-SNE, NN-SNE using:
% 8.1	N most intense peaks detected in the representative spectrum
% 8.2	Percentile P of all peaks detected in the representative spectrum
% 8.3	One or more lists of molecules of interest defined by the user
% 8.4	One or more superclass, class, or subclass of molecules (as defined by HMDB)
% 8.5	A lists of m/z values
% 9	Saving pictures (matlab figures and pngs) with the main outputs of PCA, NMF, k-means, t-SNE, NN-SNE (e.g.: principal components, representative spectra, single ion images of top drivers, cluster maps)
% 10	Saving user defined masks for regions of interest (SpectralAnalysis RegionsOfInterest structure), by combining the results of k-means (intersected or united) with regions of the image manually defined by the user (using Matlab).
% 11	Running the univariate analyses: t-test, ranksum test, and ROC analysis, which relate the (mean) ion intensities of user defined groups of regions of interest (defined in 10)
% 12	Running ANOVAs to define groups of ions that relate to particular �conditions� such as acquisition date, glass slide number, sample ID, tissue type, etc. Each �condition� has to be defined as a combination of regions of interest (defined in 10)
% 13	Discarding groups of ions defined using the ANOVA results (12) before running any of the multivariate analyses describe in 8.
% 14	Saving the k-means, t-SNE or NN-t-SNE clustering maps as regions of interest (SpectralAnalysis RegionsOfInterest structure). These regions of interest can be used in any subsequent analyses together with or in place of those defined in 10.
% 15	Saving the data from an original imzml or a new �dataset� (defined in 6) in a csv file, which contains the intensity of all pixels of interest, the �main mask� and �small mask� of each pixel, etc.
% 
% The requirements to run this script successfully are:
% - The most recent version of SpectralAnalysis available at https://github.com/AlanRace/SpectralAnalysis added to the Matlab path.
% - The most recent version of �adhoc-data-processing-pipeline� available at https://github.com/NICE-MSI/adhoc-data-processing-pipeline added to the Matlab path.
% - The location of (i.e. the path to) the SpectralAnalysis pre-processing file (extension �.sap�) to be used. An example can be found in �required-files� within the git repository �adhoc-data-processing-pipeline� specified above. The parameters of the pre-processing need to be adequate to the data. The pre-processing file can be edited in Matlab.
% - The location of (i.e. the path to) the imzML and ibd data files, which have to be saved in modality and polarity specific folders.
% - An excel file named �inputs_file� saved in the folder that contains the imzml and ibd data files. An example can be found in �required-files� within the git repository �adhoc-data-processing-pipeline� specified above. The inputs file needs to be adjusted to the particular requirements of the analysis, dataset, study goal, etc.

%% Saving master script in a location of your choice

% Please save a copy of this file in a location of your choice.

% I recomment you to save a master script for each study. You will be 
% able to call different modalites and polarities, but the bulk of the 
% analysis is likely to be consitent across these data and specific to 
% the study.

%% Adding the most recent version of SpectralAnalysis and the repository "adhoc-data-processing-pipeline" to the Matlab path

% SpectralAnalysis git repository can be dowloaded / cloned from https://github.com/AlanRace/SpectralAnalysis
% adhoc-data-processing-pipeline git repository can be dowloaded / cloned from https://github.com/NICE-MSI/adhoc-data-processing-pipeline"
sa_path = '...'; % path to SpectralAnalysis folder
sdpp_path = '...'; % path to adhoc-data-processing-pipeline

addpath(genpath(sa_path)) 
addpath(genpath(sdpp_path))

%% Specifying the imzmls and ibds (data) location

% Please list the paths to all folders containing data.

data_folders = { ...
    'X:\Beatson\pos DESI AZ data\',%...
    %'...',...
    };

% Please list the strings that matches the names of the files to be analised. Each row should match each folder specified above. If all files need to be analised, please use '*'.

dataset_name_portion = { 
    '20210119_Capi_study1_pos_60um',%...
    %'...',...
    };

% ! Please don't modify the code from here till end of this cell.

filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} filesep dataset_name_portion{i} '.imzML']) ]; end % Files and adducts information gathering

%% Creating a new inputs_file.xlsx

% Copy the file "inputs_file.xlsx" available in the folder �required-files�
% within the git repository �adhoc-data-processing-pipeline� to the folder
% where your data has been saved (which was specified in the previous cell).

% Update the file "inputs_file.xlsx" saved in the  folder with the data 
% according to the requirements of the study. The first step of any study 
% tends to be pre-processing, peak matching, and k-means clustering with
% the aim of defing the "tissue only" mask.

%% Specifying SpectralAnalysis pre-processing file location

% Please specify the path to the SpectralAnalysis pre-processing file. 
% An example can be found in �required-files� within the git repository
% �adhoc-data-processing-pipeline�. You can copy this example file and save
% it in a location of your choice. This file can be edited in Matlab. Make
% sure the parameters specified make sense for your particular dataset.
% Alternatively, you can use the SpectralAnalysis GUI to create this file
% (and use the before and after plots to make sure that the pre-processing 
% is working as intended).

preprocessing_file = 'X:\Beatson\pos DESI AZ data\preprocessingWorkflow4AZpeakPickedData.sap';

%% Data Pre-Processing (for each imzML individually)

% Please specify the name of the mask that should be used to run all the
% processing. This is also called the "main mask".

mask = "no mask"; % if mask = "no mask", all pixels will be processed

% Please specify which normalisation will be required. Use "no norm" to 
% avoid normalisation.

norm_list = "no norm";

% ! Please don't modify the code from here till end of this cell.

% Pre-processing data and saving total spectra

f_saving_spectra_details( filesToProcess, preprocessing_file, mask )

% Peak picking and saving peak details

f_saving_peaks_details( filesToProcess, mask )

% Peak assignments (HMDB & lists of relevant molecules)

f_saving_hmdb_assignments( filesToProcess, mask )

f_saving_relevant_lists_assignments( filesToProcess, mask )

% Save peaks that have to be included in each datacube

f_saving_datacube_peaks_details( filesToProcess, mask )

% Create and save datacubes

f_saving_datacube( filesToProcess, mask )

% Normalise data and save normalised data matrices

f_saving_normalised_data( filesToProcess, mask, norm_list )

%% Multivariate Analysis (for each imzML individually) (MVAs)

% Please make sure you specify which multivariate analysis to run in 
% "inputs_file.xlsx".

% ! Please don't modify the code from here till end of this cell.

f_running_mva( filesToProcess, mask, norm_list ) % running MVAs with the top N peaks (N is specified in "inputs_file.xlsx")

f_saving_mva_outputs( filesToProcess, mask, 0, norm_list ); % saving outputs of MVAs ran with top N peaks (N is specified in "inputs_file.xlsx")

%% Saving single ion images (SIIs)

mask_on = 0; % 1 or 0 depending on either the sii are to be masked with the main mask or not.
sii_peak_list = "all"; % "all" (to save all lists); an array of lists; an array of hmdb classes or subclasses; an array of m/z values (less then 1e-10 apart from those saved in the datacube).
norm_list = "no norm";

f_saving_sii( filesToProcess, "no mask", mask_on, norm_list, sii_peak_list );

%% Manual Mask Creation (e.g.: tissue only, sample A)

% Step 1 - Please update the variable "file_index" to match the file you need to work from.

file_index = 1; disp(filesToProcess(file_index).name);

% Step 2 - Please define the name of the new mask.

output_mask = "tissue only"; % Name for the new mask.

% Step 3 - Please update all variables bellow to match the MVA results you want to use to define the new masks.

mva_reference   = "500 highest peaks";
input_mask      = "no mask";
numComponents   = 2;
mva_type        = "kmeans";
norm_type       = "no norm";
vector_set      = [ 2 ]; % Please list here the ids of the clusters that you want to "add" to create the new mask. For example, for "tissue only", list all clusters that overlap with the tissue.

% Step 4 - Please update the number of times you would like to have to define particular regions/areas to keep, and/or to fill.

regionsNum2keep = 0; % to keep
regionsNum2fill = 0; % to fill

f_mask_creation( filesToProcess(file_index), input_mask, [], mva_type, mva_reference, numComponents, norm_type, vector_set, regionsNum2keep, regionsNum2fill, output_mask ) % new mask creation

%% Grouping datasets to be processed together (using a common m/z axis)

% Have you used this script to analyse data from the study you are working on?
% 
% If no:
% - copy and paste the file f_Beatson_samples_scheme_info.m into the same
% folder (adhoc-data-processing-pipeline);
% - change the name of the copy to f_{StudyName}_samples_scheme_info;
% - update the content of the file just saved by replacing the 
% relevant paths and folder names (these will be specific to your study);
% 
% If yes:
% - check if the file f_{StudyName}_samples_scheme_info has the particular 
% case / compiled dataset you wish to work on;
% -- if yes, just change the variable dataset_name below to match the case;
% -- if no, create a new case;

% Specify the name of the dataset you want to work on (this will be a
% spefific combination of the data that is defined in f_{StudyName}_samples_scheme_info).

dataset_name = "icl neg desi 1458 and 1282 pdx only";

% Would you like to keep the background in? (this will use the "no mask" as
% the main mask for the study) 

background = 0; % 0 for no, 1 for yes

% Would you like to check if all the required datacubes are in the same m/z axis?

check_datacubes_size = 1; % 0 for no, 1 for yes

% ! Please don't modify the code from here till end of this cell.

[ extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs ] = ...
    f_icr_samples_scheme_info( dataset_name, background, check_datacubes_size ); 

filesToProcess = f_unique_extensive_filesToProcess(extensive_filesToProcess); % collects all files that need to have a common m/z axis

%% Data Pre-Processing (all datasets in filesToProcess are processed together)

mask = "tissue only"; % can be "no mask" to start with (making the whole process quicker because both assigments steps are run only once), "tissue only" to follow

% Pre-processing data and saving total spectra

f_saving_spectra_details( filesToProcess, preprocessing_file, mask )

% Peak picking and saving peak details

f_saving_peaks_details_ca( filesToProcess, mask )

% Peak Assignments (lists of relevant molecules & HMDB)

f_saving_relevant_lists_assignments_ca( filesToProcess, mask )

f_saving_hmdb_assignments_ca( filesToProcess, mask )

% Saving mz values that have to be included in each datacube

f_saving_datacube_peaks_details_ca( filesToProcess, mask )

% Data cube (creation and saving)

f_saving_datacube( filesToProcess, mask )

% Data normalisation (saving a normalised version of the data which is required to later plot normalised SIIs or run MVAs with normalised data)

f_saving_normalised_data( filesToProcess, mask, norm_list )

%% Use MVA results to create new masks (each clustered will be saved as a mask i.e. SA roi struct)

% Important note!!! This function needs to be updated because the MVA results are now a short array of
% pixels (small masks only pixels). 07 Aug 2020 Teresa

% Please specify the details of the MVAs you want to save the clustering maps for.

mva_list = "tsne"; % kmeans or tsne
numComponents_list = NaN; % a particular number or NaN (if you want to use the elbow method result)
norm_list = "pqn median"; % normalisation used

% Please list all the lists you would like to save the clustering maps for, or "all" if you would like to them for all lists considered.    

mva_specifics_list = [ "Fatty Acyls", "Glycerolipids", "Glycerophospholipids" ];

for mva_specifics = mva_specifics_list 
    f_saving_mva_rois_ca( extensive_filesToProcess, main_mask_list, dataset_name, mva_list, numComponents_list, norm_list, mva_specifics ) % saving masks / rois   
end

%% Single Ion Images (all datasets are processed together)

norm_list = [ "no norm", "pqn median" ]; % Please list the normalisations. For a list of those available, check the function called "f_norm_datacube".

sii_peak_list = "Shorter Beatson metabolomics & CRUK list"; % Please list all the lists you would like to save the sii for, or simply "all" if you would like to the sii for all lists considered.

f_saving_sii_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs, dataset_name, norm_list, sii_peak_list ) % New function - it can accept hmdb classes, relevant molecules lists names or a vector of meas masses.

%% Multivariate Analysis (all datasets are processed together)

norm_list = [ "no norm", "pqn median" ]; % Please list the normalisations. For a list of those available, check the function called "f_norm_datacube".

mva_classes_list = string([]);

% Using specific lists of peaks (listed below in the variable "mva_molecules_list").

mva_molecules_list = [ "CRUK metabolites", "Immunometabolites", "Structural Lipids", "Fatty acid metabolism" ];

f_running_mva_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, dataset_name, norm_list, mva_molecules_list, mva_classes_list ) % Running MVAs

f_saving_mva_outputs_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs, dataset_name, norm_list, mva_molecules_list, mva_classes_list ) % Saving MVAs outputs

% Using the top peaks specific in the "inputs_file".

mva_molecules_list = string([]);

f_running_mva_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, dataset_name, norm_list, mva_molecules_list, mva_classes_list ) % Running MVAs

f_saving_mva_outputs_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs, dataset_name, norm_list, mva_molecules_list, mva_classes_list ) % Saving MVAs outputs

%% Saving ion intensities per small mask table

norm_list = [ "no norm", "RMS" ];

f_ion_intensities_table( filesToProcess, main_mask_list, smaller_masks_list, norm_list )

%% Univariate analyses (ROC, t-test)

norm_list = [ "no norm", "RMS" ];

% Groups of pixels  (arrays of small masks names)

vehicle =           [ "b1s24_vehicle","b2s22_vehicle","b3s24_vehicle","b1s19_vehicle","b2s21_vehicle","b3s25_vehicle","b4s24_vehicle","b4s23_vehicle","b3s26_vehicle" ];
AZD2014 =           [ "b1s24_2014","b2s22_2014","b3s24_2014","b1s19_2014","b2s21_2014","b3s25_2014","b4s23_2014","b3s26_2014" ];
AZD8186 =           [ "b1s24_8186","b2s22_8186","b3s24_8186","b4s20_8186","b1s19_8186","b2s21_8186","b3s25_8186","b4s24_8186","b4s23_8186","b3s26_8186" ];
AZD6244 =           [ "b1s24_6244","b2s22_6244","b3s24_6244","b4s20_6244","b1s19_6244","b2s21_6244","b3s25_6244","b4s24_6244","b4s23_6244","b3s26_6244" ];
AZD6244_AZD8186 =   [ "b1s24_6244_8186","b2s22_6244_8186","b3s24_6244_8186","b1s19_6244_8186","b2s21_6244_8186","b3s25_6244_8186","b4s23_6244_8186","b3s26_6244_8186" ];
AZD6244_AZD2014 =   [ "b1s24_6244_2014","b2s22_6244_2014","b3s24_6244_2014","b1s19_6244_2014","b2s21_6244_2014","b3s25_6244_2014","b3s26_6244_2014" ];
AZD2014_AZD8186 =   [ "b1s24_2014_8186","b3s24_2014_8186","b1s19_2014_8186","b3s25_2014_8186","b4s23_2014_8186","b3s26_2014_8186" ];

% Pairs of groups of pixels to compare with the univariate analysis

groups.name = "all vs veh and sing vs combi";

groups.masks = { vehicle, AZD2014, AZD8186, AZD6244, AZD6244_AZD8186, AZD6244_AZD2014, AZD2014_AZD8186 };
groups.names = { "vehicle", "AZD2014", "AZD8186", "AZD6244", "AZD6244_AZD8186", "AZD6244_AZD2014", "AZD2014_AZD8186" };
groups.pairs = { [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7], [2, 6], [2, 7], [3, 5], [3, 7], [4, 5], [4, 6] }; % [1, 2] will combine vehicle (1st position in the lists above) with AZD2014 (2nd position in the lists above)

% Univariate analysis to perform

univtests.roc = 1;
univtests.ttest = 1;

% Save single ion images?

sii.plot = 1; % 1 or 0 depending on wether siis are to be plotted or not.
sii.mask = 1; % 1 or 0 depending on wether siis are to be masked with the main mask or not.
sii.roc_th = 0.3; % Peacks with AUC below roc_th2plotsii and above 1-roc_th2plotsii will be plotted. e.g.: use 0.3 to plot AUC<0.3 and AUC>0.7
sii.ttest_th = 0.05; % Peaks with p values below ttest_th2plotsii will be plotted. e.g.: use 0.05 to plot p<0.05

sii.dataset_name = dataset_name; % Name of the dataset, which is the name given to the particular combination of small masks to plot.
sii.extensive_filesToProcess = extensive_filesToProcess; % Extensive lists of files.
sii.smaller_masks_list = smaller_masks_list; % Extensive list of small masks.
sii.outputs_xy_pairs = outputs_xy_pairs; % Extensive lists of coordenates (one pair for each small mask).

f_univariate_analyses( filesToProcess, main_mask_list, groups, norm_list, univtests, sii )

%% ANOVA (N-way)

norm_list = [ "no norm", "RMS" ];

% Effects

% same b, different s = tecni repl
% diff b, different s = biol repl

anova.masks = [ 
    "b1s19_vehicle",    "b1s24_vehicle", 	"b2s21_vehicle",    "b2s22_vehicle",    "b3s24_vehicle",  	"b3s25_vehicle",    "b3s26_vehicle",                    "b4s23_vehicle",    "b4s24_vehicle", ...
    "b1s19_2014",       "b1s24_2014",       "b2s21_2014",       "b2s22_2014",       "b3s24_2014",      	"b3s25_2014",       "b3s26_2014",                       "b4s23_2014", ...
    "b1s19_8186",       "b1s24_8186",       "b2s21_8186",       "b2s22_8186",       "b3s24_8186",       "b3s25_8186",       "b3s26_8186",       "b4s20_8186",   "b4s23_8186",       "b4s24_8186", ...
    "b1s19_6244",       "b1s24_6244",       "b2s21_6244",       "b2s22_6244",       "b3s24_6244",       "b3s25_6244",       "b3s26_6244",       "b4s20_6244",   "b4s23_6244",       "b4s24_6244", ...
    "b1s19_6244_8186",  "b1s24_6244_8186",  "b2s21_6244_8186",  "b2s22_6244_8186",  "b3s24_6244_8186",  "b3s25_6244_8186",  "b3s26_6244_8186",                  "b4s23_6244_8186", ...
    "b1s19_6244_2014",  "b1s24_6244_2014",  "b2s21_6244_2014",  "b2s22_6244_2014",  "b3s24_6244_2014",  "b3s25_6244_2014",  "b3s26_6244_2014", ...
    "b1s19_2014_8186",  "b1s24_2014_8186",                                          "b3s24_2014_8186",  "b3s25_2014_8186",  "b3s26_2014_8186",                  "b4s23_2014_8186"
    ];

eday = { 
    '5';    '1';    '5';    '1';  	'3';  	'8'; 	'11';           '10';       '8'; ...
    '5';    '1';    '5';    '1';	'3';  	'8'; 	'11';         	'10'; ...
    '5';    '1';    '5';    '1'; 	'3';  	'8';   	'11';	'3';    '10';       '8'; ...
    '5';    '1';    '5';    '1'; 	'3';  	'8';  	'11';	'3';    '10';       '8'; ...
    '5';    '1';    '5';    '1';	'3';    '8';    '11';         	'10'; ...
    '5';    '1';    '5';    '1';    '3';    '8';    '11'; ...
    '5';    '1';                    '3';    '8';    '11';           '10'
    };

eblock = { 
    '1';    '1';    '2';    '2';  	'3';  	'3'; 	'3';            '4';       '4'; ...
    '1';    '1';    '2';    '2';	'3';  	'3'; 	'3';         	'4'; ...
    '1';    '1';    '2';    '2'; 	'3';  	'3';   	'3';	'4';    '4';       '4'; ...
    '1';    '1';    '2';    '2'; 	'3';  	'3';  	'3';	'4';    '4';       '4'; ...
    '1';    '1';    '2';    '2';	'3';    '3';    '3';         	'4'; ...
    '1';    '1';    '2';    '2';    '3';    '3';    '3'; ...
    '1';    '1';                    '3';    '3';    '3';            '4'
    };

evehicle = { 
    '1';    '1';    '1';    '1';  	'1';  	'1'; 	'1';            '1';       '1'; ...
    '0';    '0';    '0';    '0';	'0';  	'0'; 	'0';            '0'; ...
    '0';    '0';    '0';    '0'; 	'0';  	'0';	'0';	'0';    '0';       '0'; ...
    '0';    '0';    '0';    '0'; 	'0';  	'0';  	'0';	'0';    '0';       '0'; ...
    '0';    '0';    '0';    '0';	'0';    '0';    '0';         	'0'; ...
    '0';    '0';    '0';    '0';    '0';    '0';    '0'; ...
    '0';    '0';                    '0';    '0';    '0';            '0'
    };

e2014 = { 
    '0';    '0';    '0';    '0';  	'0';  	'0'; 	'0';            '0';       '0'; ...
    '1';    '1';    '1';    '1';	'1';  	'1'; 	'1';            '1'; ...
    '0';    '0';    '0';    '0'; 	'0';  	'0';	'0';	'0';    '0';       '0'; ...
    '0';    '0';    '0';    '0'; 	'0';  	'0';  	'0';	'0';    '0';       '0'; ...
    '0';    '0';    '0';    '0';	'0';    '0';    '0';         	'0'; ...
    '1';    '1';    '1';    '1';    '1';    '1';    '1'; ...
    '1';    '1';                    '1';    '1';    '1';            '1'
    };

e8186 = { 
    '0';    '0';    '0';    '0';  	'0';  	'0'; 	'0';            '0';       '1'; ...
    '0';    '0';    '0';    '0';	'0';  	'0'; 	'0';            '0'; ...
    '1';    '1';    '1';    '1'; 	'1';  	'1';	'1';	'1';    '1';       '1'; ...
    '0';    '0';    '0';    '0'; 	'0';  	'0';  	'0';	'0';    '0';       '0'; ...
    '1';    '1';    '1';    '1';	'1';    '1';    '1';         	'1'; ...
    '0';    '0';    '0';    '0';    '0';    '0';    '0'; ...
    '1';    '1';                    '1';    '1';    '1';            '1'
    };

e6244 = { 
    '0';    '0';    '0';    '0';  	'0';  	'0'; 	'0';            '0';       '1'; ...
    '0';    '0';    '0';    '0';	'0';  	'0'; 	'0';            '0'; ...
    '0';    '0';    '0';    '0'; 	'0';  	'0';	'0';	'0';    '0';       '0'; ...
    '1';    '1';    '1';    '1'; 	'1';  	'1';  	'1';	'1';    '1';       '1'; ...
    '1';    '1';    '1';    '1';	'1';    '1';    '1';         	'1'; ...
    '1';    '1';    '1';    '1';    '1';    '1';    '1'; ...
    '0';    '0';                    '0';    '0';    '0';            '0'
    };

anova.labels = {'day', 'block', 'vehicle', '2014', '8186', '6244'};
anova.effects = { eday, eblock, evehicle, e2014, e8186, e6244 };

f_anova( filesToProcess, main_mask_list, norm_list, anova ) % saving the anova results table

%% Create a new set of meas m/zs to discard by filtering the ANOVA results

norm_list = [ "RMS", "no norm" ];

for norm = norm_list
    
    for th = [ 0.01, 0.05 ]
        
        criteria.file = "anova day block vehicle 2014 8186 6244";
        criteria.column = { "p value for day effect (mean)" }; % select from the anova results file
        criteria.ths_type = { "equal_below" }; % "equal_below", "below", "equal_above", "above"
        criteria.ths_value = { th };  % between 0 and 1
        criteria.combination = "or"; % "and", "or"
        
        mzvalues2discard = f_anova_based_unwanted_mzs( filesToProcess, main_mask_list, norm, criteria); % Values to discard are norm specific
        
        %%% Run MVAs after discarding the m/zs selected above
        
        disp(['# peaks discarded: ', num2str(size(mzvalues2discard,1))])
        
        % MVAs
        
        % mva_peak_list = "Amino Acids";
        %
        % f_running_mva_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, dataset_name, norm_list, mva_peak_list, string([]), mzvalues2discard ) % Running MVAs
        %
        % f_saving_mva_outputs_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs, dataset_name, norm_list, mva_peak_list, string([]), mzvalues2discard ) % Saving MVAs outputs
        
        mva_peak_list = string([]); % Top peaks
        
        f_running_mva_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, dataset_name, norm, mva_peak_list, string([]), mzvalues2discard ) % Running MVAs
        
        f_saving_mva_outputs_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs, dataset_name, norm, mva_peak_list, string([]), mzvalues2discard ) % Saving MVAs outputs
        
    end
    
end

%% Plot 2D and 3D PCs plots

% Important note!!! This function needs to be updated because the MVA results are now a short array of
% pixels (small masks only pixels). 07 Aug 2020 Teresa

norm_list = [ "no norm", "pqn median", "zscore" ];

mva_list = "pca"; % only running for pca at the moment
numComponents_array = 16; % needs to match the size of mva_list
% component_x = ;
% component_y = ;
% component_z = ;

% RGB codes for the colours of the masks defined in smaller_masks_list

% small intestine neg desi

smaller_masks_colours = [
    0 0 0 % black - WT
    1 .8 0 % yellow - KRAS
    1 0.3 0.3 % red - APC
    .2 .2 .8 % blue - APC-KRAS
    0 0 0 % black - WT
    1 .8 0 % yellow - KRAS
    1 0.3 0.3 % red - APC
    .2 .2 .8 % blue - APC-KRAS
    0 0 0 % black - WT
    1 .8 0 % yellow - KRAS
    1 0.3 0.3 % red - APC
    .2 .2 .8 % blue - APC-KRAS
    0 0 0 % black - WT
    1 .8 0 % yellow - KRAS
    1 0.3 0.3 % red - APC
    .2 .2 .8 % blue - APC-KRAS
    ];

f_saving_pca_nmf_scatter_plots_ca( extensive_filesToProcess, mva_list, numComponents_array, component_x, component_y, component_z, main_mask_list, smaller_masks_list, smaller_masks_colours, dataset_name, norm_list, string([]), string([]) )

%% Saving data for supervised classification in Python

% project_id = "icr"; f_data_4_sup_class_ca( filesToProcess, main_mask_list, smaller_masks_list, project_id, dataset_name, "txt" ) % old

f_data_4_cnn_ca( filesToProcess, main_mask_list, smaller_masks_list, dataset_name, 'txt' )