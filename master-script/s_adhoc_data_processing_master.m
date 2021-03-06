%{

This script contains a modular mass spectrometry imaging (MSI) data analysis pipeline.

Please refer to the "read me" file in the main folder of the "adhoc-data-processing-pipeline" git repository (see next cell), 
and to the documents available in the folder "documentation" of the same git repository, for further information regarding 
the overall structure and steps of this pipeline, as well as the requirements to be able to run it.

By Teresa Murta, June 2021

How to start using this script:
	Please read the comments in each one of the cells below (in a sequential order) and execute them as required. 

Help:
	You can execute a selected cell (i.e. a cell you have the cursor in) by clicking "shift" followed by "enter".
	You can execute a group of selected code lines (i.e. a group of code lines highlighted by you) by clicking "F9".

People that can help you:
	Ariadna and Chelsea - pipeline structure and how to use it
	Alex - Spectral Analysis related issues

%}
%% Add the "adhoc-data-processing-pipeline" repository from git to the Matlab path
%{

Info:
The "adhoc-data-processing-pipeline" git repository can be downloaded or cloned from https://github.com/NICE-MSI/adhoc-data-processing-pipeline"
This repository contains functions and files that you will need to process the data.

Actions:
	Download or close the repository, and save it in a location of your choice. 
I recommend saving a copy in your personal folder (in the T or X drive for instance).
	Specify below the complete path to the chosen location  (replace ... between the '').
	Execute this cell.

%}

sdpp_path = '...'; % complete path to adhoc-data-processing-pipeline
addpath(genpath(sdpp_path))

%% Add "SpectralAnalysis" from git to the Matlab path
%{

Info:
This script works with SpectralAnalysis v1.4.0 (released in Aug 2020)
"SpectralAnalysis" can be dowloaded or cloned from https://github.com/AlanRace/SpectralAnalysis/releases/.

Actions:
	Download the source code of SpectralAnalysis v1.4.0 and save it in a location of your choice. 
I recommend saving it in your personal folder (in the T or X drive for instance).
	Specify below the complete path to the chosen location  (replace ... between the '').
	Execute this cell.

%}

sa_path = '...'; % complete path to SpectralAnalysis folder
addpath(genpath(sa_path))

%% Save a master script in a location of your choice
%{
 
Action:
	Save a copy of this script (.m file) in a location of your choice.

Help:
I recommend saving a unique master script for each study. You will be able to analyse different modalities and polarities using the same master script.

%}
%% Save an inputs_file.xlsx in the folder that contains the data (ibd and imzml files)
%{

Actions:
	Copy the file "inputs_file.xlsx" in the folder required-files and paste it in the folder where your data (ibd and imzml files) are located.
	Update the just now saved "inputs_file.xlsx" according to the requirements of the study.

Notes:
Make sure the polarity is correct, and the adducts make sense for that polarity.
Make sure you update the complete path to the folder where the outputs of the processing will be saved.
Most studies start with pre-processing, peak matching, and running k-means clustering with the aim of defining the "tissue only" mask (a mask for the tissue pixels only).

%}
%% Specify the SpectralAnalysis pre-processing file location (sap file)
%{

Actions:
First:
	Copy the file "preprocessingWorkflow.sap" in the folder required-files and save it in a location of your choice.
	Edit this file based on what you know about the data.
OR
	Use the SpectralAnalysis GUI to create a new SpectralAnalysis pre-processing file (.sap) and save it in a location of your choice.
Then:
	Specify below the complete path to the SpectralAnalysis pre-processing file (.sap) (replace ... between the '')
	Execute this cell.

%}

preprocessing_file = '...';

%% Specify the data (ibd and imzml files) location
%{

Actions:
	Specify below the complete path to the folder where the data is stored (replace ... between the '').
	Specify below part of the name of the files you want to process, between ** (replace ... between the '').
If you would like to process all files within the folder, use "*".
	Execute this cell.

Help:
An example file can be found in required-files. You can save a copy of it in a location of your choice, and edit it in Matlab. 
Make sure the parameters specified make sense for your particular dataset.
Alternatively, you can use the SpectralAnalysis GUI to create this file. 
Make sure you use the "before" and "after" plots available in the GUI to check that the pre-processing works as intended.

%}

data_folders = { '...' }; % list of the complete paths to the folders where the data is stored
dataset_name_portion = { '*' }; % list of the strings that match the names of the files to be analised


% ! Do not modify the code from here till end of this cell.

% Creating the matlab struct that contains the paths and names of the files to be analysed

filesToProcess = []; 
for i = 1:length(data_folders) 
    filesToProcess = [ filesToProcess; dir([data_folders{i} filesep dataset_name_portion{i} '.imzML']) ];
end

%% Data pre-processing of each imzML individually
%{

Info:
This cell processes each imzml individually. This needs to be done at the start of most studies.  

Actions:
	Specify below the name of the mask (most studies will imply setting mask to "no mask", which means analysing all pixels).
	Specify below the list of normalisations.
	Execute this cell.

The options for normalisation are:
- "no norm" (no normalisation)
- "tic" (uses total ion count per pixel)
- "sims tic" (uses total ion count of the entire dataset) 
- "RMS" (root mean square) 
- "pqn mean"
- "pqn median"
- "zscore" (z-scoring each pixel)

%}

mask = "no mask"; % if mask = "no mask", all pixels are used
norm_list = [ "no norm", "tic", "sims tic", "RMS", "pqn mean", "pqn median", "zscore" ];


% ! Do not modify the code from here till end of this cell.

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

%% Multivariate Analysis (MVAs) of each imzML individually
%{

Info:
If you do not need to run MVAs, please skip this cell.

Actions:
	Specify in "inputs_file.xlsx" the top N peaks to use when running the MVAs.
	Specify in "inputs_file.xlsx" which MVAs to run.
	Execute this cell.

Notes:
- The "inputs_file.xlsx" can be editted at any point in the process.
However, the number of top peaks to be used here (to run the MVAs) needs to 
be equal or smaller than the number of top peaks you had in the 
"inputs_file.xlsx" when the datacube and normalised data were saved (i.e. 
when the previous cell was executed).
- You can also change the group of peaks to be used in the MVAs by changing 
the input of the 2 functions below. Read the help of these functions for 
further information.

%}


% ! Do not modify the code from here till end of this cell.

f_running_mva( filesToProcess, mask, norm_list ) % running MVAs with the top N peaks (N is specified in "inputs_file.xlsx")

f_saving_mva_outputs( filesToProcess, mask, 0, norm_list ); % saving outputs of MVAs ran with top N peaks (N is specified in "inputs_file.xlsx")

%% Saving single ion images (SIIs) for each imzML individually
%{

Info:
If you do not need to save single ion images, please skip this cell.

Actions:
	Specify below if you would like to mask the SIIs with the "main" mask.
	Specify below which lists of peaks you want to save SIIs for.
	Execute this cell.

The options for masking are:
- 0 to avoid the masking
- 1 to mask

The options for peak lists are:
- "all" to save SIIs for all lists specified in the "inputs_file.xlsx"
- a list of strings (e.g. [ "List A", "List B" ]) to save a particular group of peak lists
- an array of doubles (numbers) representing m/z values (these need to be less than 1e-10 apart from those saved in the datacube (mass channels) or peakDetails (columns 2) variables).

Notes:
The "main" mask is defined in the pre-processing cell.
You can only save SIIs for lists of peaks that were originally specified in the "inputs_file.xlsx". 
If they were not there when the data was saved (at the end of the pre-processing cell), you need to:
1) edit the "inputs_file.xlsx"
2) re-run the folowing functions: 
- f_saving_relevant_lists_assignments
- f_saving_datacube_peaks_details
- f_saving_datacube
- f_saving_normalised_data

%}

mask_on = 0; % 1 or 0 depending on either the sii are to be masked with the main mask or not
sii_peak_list = "all"; % [ "List A", "List B" ] or [mass1, mass2]


% ! Do not modify the code from here till end of this cell.

f_saving_sii( filesToProcess, mask, mask_on, norm_list, sii_peak_list );

%% Creating masks for each imzML individually
%{

Info:
These masks are created using the results of one of the spatial segmentation techniques.
You can use this cell to create the main mask "tissue only", as well as any other mask. 
If you do not need to create new masks, please skip this cell.

Actions:
	Specify below the index of the imzml you want to work with. 
	Specify below the name of the mask you want to create, between " " (the new mask).
	Specify below the name of the folder that has the spatial segmentation results you want to use to create the new mask.
	Specify below the mask used to run the spatial segmentation.
	Specify below the number of clusters used to run the spatial segmentation.
	Specify below the name of the mva technique used to run the spatial segmentation.
	Specify below the normalisation used to run the spatial segmentation.
	Specify below the numbers of the clusters to keep (their union will be the new mask).
	Specify below how many areas you would like to cut (and multiply by the clusters based mask).
	Specify below how many areas you would like to fill (and add to the clusters based mask).
	Execute this cell.

Help:
- Example 1
To create the "tissue only" mask, list all clusters that overlap with all tissue samples. 
Use the histological image as a reference.
- Example 2
To create the "tissue X" mask, list all clusters that overlap with all tissue samples, and set regionsNum2keep to 1. 
This will allow you to isolate the "tissue X" area, and create a more restrictive mask.

Notes:
While the "tissue only" mask is referred to as a "main" mask, the "tissue X" mask is referred to as a "small" mask.
While the "main" mask is mostly used to generate the tissue representative spectrum, the small masks are used to combine multiple imzmls.

%}

file_index      = 1; % index of the imzml - check filesToProcess 
output_mask     = "tissue only"; % name for the new mask
mva_reference   = "mva 100 highest peaks"; % name of the mvas folder to be used
input_mask      = "no mask"; % name of the mask used to run the mvas
mva_type        = "tsne"; % name of the segmentation technique used
numComponents   = 6; % number of clusters used
norm_type       = "no norm"; % normalisation used
vector_set      = [ 2 4 6 ]; % list the numbers (ids) of the clusters to keep
regionsNum2keep = 0; % number of areas you would like to cut and keep (these areas will be multiplied by the clusters - intersection of areas)
regionsNum2fill = 0; % number of areas you would like to fill and keep (these areas will be added to the clusters - union of areas)


% ! Do not modify the code from here till end of this cell.

file_name = filesToProcess(file_index).name; disp(file_name)

f_mask_creation( filesToProcess(file_index), input_mask, [], mva_type, mva_reference, numComponents, norm_type, vector_set, regionsNum2keep, regionsNum2fill, output_mask ) % new mask creation

%% Combining imzmls
%{

Info:
This cell is used to define which datasets are to be analized together.

Actions:
	Make sure you have the required "small" masks saved in the "rois" folder. If not, go back to the previous cell and create them.
	Create a new function like f_{study name}_samples_scheme_info for your study, using "f_testStudy_samples_scheme_info" as a starting point. I recommend having one function per study.
	Save the new function in a location of your choice, making sure it is in the Matlab path. 
	Specify below the name of the "new" (combined) dataset. This needs to match exactly what is written in the body of the function (the case name).
	Specify below the name of the function you just created, in place of "f_icr_samples_scheme_info". This needs to match exactly what is written in the body of the function (the case name).
	If this is the first time you are combining these imzmls, please set check_datacubes_size to 0. 
"check_datacubes_size" can be set to 1, to check if the datacubes saved have consistent mass axis.
However, this can only be done once all datacubes have been saved (which will only be true after executing the next cell).
	Execute this cell.

%}

dataset_name = "...";
check_datacubes_size = 0; % 0 for no, 1 for yes

% !!! Update the name of the function called below !!!

[ extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs ] = ...
    f_testStudy_samples_scheme_info( dataset_name );


% ! Do not modify the code from here till end of this cell.

f_check_datacubes_mass_axis(extensive_filesToProcess, check_datacubes_size, main_mask_list)

filesToProcess = f_unique_extensive_filesToProcess(extensive_filesToProcess); % reduces the extensive list of files to a list of unique files

%% Data pre-processing of combined imzmls
%{

Info:
This cell processes all imzmls listed in filesToProcess as one.

Actions:
	Specify below the name of the mask (most common is "tissue only").
	Specify below the list of normalisations.
	Execute this cell.

The options for normalisation are:
- "no norm" (no normalisation)
- "tic" (uses total ion count per pixel)
- "sims tic" (uses total ion count of the entire dataset) 
- "RMS" (root mean square) 
- "pqn mean"
- "pqn median"
- "zscore" (z-scoring each pixel)

Note:
The functions below whose names end with "_ca" are key - they combine the datasets.

%}

mask = "tissue only"; % if mask = "no mask", all pixels are used
norm_list = [ "no norm", "RMS" ];


% ! Do not modify the code from here till end of this cell.

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

%% Multivariate Analysis (MVAs) of combined imzmls
%{

Info:
If you do not need to run MVAs, please skip this cell.

Actions:
	Specify below which peaks are to be used when running the MVA, using the variable "mva_peaks". 
	Specify below which lists of peaks are to be used, using the variable "mva_lists".
	Execute this cell.

The options for peaks are:
- "top" to use the top N peaks specified in "inputs_file.xlsx"
- "lists" to use one or more of lists of molecules of interest specified in "inputs_file.xlsx"

Help:
You can run either options by setting mva_peaks = "top" or mva_peaks = "lists", or both by setting mva_peaks = [ "top", "lists" ];

Notes:
When using the top peaks, make sure you specify N in "inputs_file.xlsx".
When using peak lists, make sure you name them below.
You can only use lists that were originally specified in the "inputs_file.xlsx". 
If they were not there when the data was saved (at the end of the pre-processing cell), you need to:
1) edit the "inputs_file.xlsx"
2) re-run the folowing functions: 
- f_saving_relevant_lists_assignments_ca
- f_saving_datacube_peaks_details_ca
- f_saving_datacube
- f_saving_normalised_data 
You can change the group of peaks to be used in the MVAs by changing the input of the 2 functions below. 
Read the help of these functions for further information.

%}

mva_peaks = [ "top", "lists" ]; 
mva_lists = [ "CRUK metabolites", "Marcels Lipid List", "Glycolysis" ];


% ! Do not modify the code from here till end of this cell.

for task = mva_peaks
    if isequal(task,"top"); mva_lists = string([]); end % Using the top peaks specified in the "inputs_file"
    
    f_running_mva_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, dataset_name, norm_list, mva_lists ) % Running MVAs
    
    f_saving_mva_outputs_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs, dataset_name, norm_list, mva_lists ) % Saving MVAs outputs
end

%% Saving single ion images (SIIs) of combined imzmls
%{

Info:
If you do not need to save single ion images, please skip this cell.

Actions:
	Specify below which lists of peaks you want to save SIIs for.
	Execute this cell.

The options for peak lists are:
- "all" to save SIIs for all lists specified in the "inputs_file.xlsx"
- a list of strings (e.g. [ "List A", "List B" ]) to save a particular group of peak lists
- an array of doubles (numbers) representing m/z values (these need to be less than 1e-10 apart from those saved in the datacube (mass channels) or peakDetails (columns 2) variables).

Notes:
The "main" mask is defined in the pre-processing cell.
You can only save SIIs for lists of peaks that were originally specified in the "inputs_file.xlsx". 
If they were not there when the data was saved (at the end of the pre-processing cell), you need to:
1) edit the "inputs_file.xlsx"
2) re-run the folowing functions: 
- f_saving_relevant_lists_assignments
- f_saving_datacube_peaks_details
- f_saving_datacube
- f_saving_normalised_data

%}

sii_peak_list = [ 756.405999995922 ]; % "all"; % [ "CRUK metabolites", "Marcels Lipid List", "Glycolysis" ]


% ! Do not modify the code from here till end of this cell.

f_saving_sii_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs, dataset_name, norm_list, sii_peak_list ) % New function - it can accept hmdb classes, relevant molecules lists names or a vector of meas masses.

%% Using MVA results to create new masks
%{

Info:
Each cluster is saved as a SpectralAnalysis roi struct in the "rois" folder.

Actions:
	Specify below the name of the folder that has the spatial segmentation results you want to use to create the new masks.
	Specify below the name of the mva technique used to run the spatial segmentation.
	Specify below the number of clusters used to run the spatial segmentation.
	Specify below the normalisation used to run the spatial segmentation.
	Execute this cell.

%}

mva_reference   = "mva 100 highest peaks"; % name of the mvas folder to be used
mva_type        = "tsne"; % name of the segmentation technique used
numComponents   = 6; % number of clusters used
norm_type       = "no norm"; % normalisation used


% ! Do not modify the code from here till end of this cell.

f_saving_mva_rois_ca( extensive_filesToProcess, main_mask_list, dataset_name, mva_type, numComponents, norm_type, mva_reference ) % saving masks / rois   

%% Saving ion intensity for each small mask
%{

Info:
This cell saves a txt file with the mean and median intensities of each
small mask specified in "smaller_masks_list".

Actions:
	Execute this cell.

%}


% ! Do not modify the code from here till end of this cell.

f_ion_intensities_table( filesToProcess, main_mask_list, smaller_masks_list, dataset_name, norm_list )

%% Running univariate analyses (ROC, t-test)
%{

Actions:
	Specify below the groups of rois ought to be compared. Each group is a list of strings (e.g. group_1 = ["roi-1-A","roi-1-B"]).
	Specify below the name of the results file, using the variable "groups.name".
	Specify below the variables that represent the groups of rois ought to be compared, using the variable "groups.masks".
	Specify below the names of the groups of rois ought to be compared, using the variable "groups.names".
	Specify below the pairs of groups of rois ought to be compared, using the variable "groups.pairs".
	Specify below the univariate analysis to run.
	Specify below wether to save SIIs or not, as well as which thresholds to use for the AUC and/or p-value.

Help:
The options for univariate analyses are:
- ROC analysis (see the help of the Matlab function "perfcurve" for more information)
Set univtests.roc to 1 to run the ROC analysis, or to 0 otherwise.
- t-test (see the help of the Matlab function "ttest" for more information)
Set univtests.test to 1 to run the t-test, or to 0 otherwise.

The formats of the inputs are:
groups.name - string
groups.masks - a cell of variables (, separated)
groups.names - a cell of strings (, separated)
groups.pairs - a cell of list with 2 elements only (',' separated)
univtests.roc - 1 or 0
univtests.ttest - 1 or 0
sii.plot - 1 or 0
sii.mask - 1 or 0
sii.roc_th - a double between 0 and 0.5, often 0.3
sii.ttest_th - a double between 0 and 1, often 0.05

%}

% Defining the groups of rois / pixels to compare (lists of small masks names)

tissue =        [ "top-tissue", "botom-tissue" ];
background =    [ "top-background", "botom-background" ];
top =           [ "top-tissue", "top-background" ];
botom =         [ "botom-tissue", "botom-background" ];

groups.name = "tissue vs background and top vs botom"; % a string with the name of the results file

groups.masks = { tissue, background, top, botom };
groups.names = { "tissue", "background", "top", "botom" };
groups.pairs = { [1, 2], [3, 4] }; % [1, 2] compares 1st position in the lists above with 2nd position in the lists above

% What univariate analyses?

univtests.roc = 1;
univtests.ttest = 1;

% Save single ion images?

sii.plot = 1; % 1 or 0 depending on wether siis are to be plotted or not.
sii.mask = 1; % 1 or 0 depending on wether siis are to be masked with the main mask or not.
sii.roc_th = 0.3; % peacks with AUC below sii.roc_th and above 1-sii.roc_th will be plotted. e.g.: use 0.3 to plot AUC<0.3 and AUC>0.7
sii.ttest_th = 0.05; % peaks with p values below sii.ttest_th will be plotted. e.g.: use 0.05 to plot p<0.05


% ! Do not modify the code from here till end of this cell.

sii.dataset_name = dataset_name; % Name of the dataset, which is the name given to the particular combination of small masks to plot.
sii.extensive_filesToProcess = extensive_filesToProcess; % Extensive lists of files.
sii.smaller_masks_list = smaller_masks_list; % Extensive list of small masks.
sii.outputs_xy_pairs = outputs_xy_pairs; % Extensive lists of coordenates (one pair for each small mask).

f_univariate_analyses( filesToProcess, main_mask_list, groups, norm_list, univtests, sii )

%% Running an analysis of variance (N-way ANOVA)
%{

Actions:
	Specify below the groups of pixels (i.e. masks or rois) ought to be considered, using the variable "anova.masks". 
	Specify below the effects ought to be modelled. Each effect is a cell of chars (words or number between ' '), separated by ;.
	Specify below the names of the effects, using the variable "anova.labels".
	Specify below the univariate analysis to run.
	Specify below wether to save SIIs or not, as well as which thresholds to use for the AUC and/or p-value.

The formats of the inputs are:
anova.masks - list of strings separated by ,
effectX variable - a cell of chars separated by ;
anova.labels - a cell of chars separated by ,
anova.effects - a cell of variables separated by ,

Help:
The options for univariate analyses are:
- ROC analysis (see the help of the Matlab function "perfcurve" for more information)
Set univtests.roc to 1 to run the ROC analysis, or to 0 otherwise.
- t-test (see the help of the Matlab function "ttest" for more information)
Set univtests.test to 1 to run the t-test, or to 0 otherwise.

%}

% Groups of pixels

anova.masks = [ "top-tissue", "top-background", "botom-tissue",  "botom-background" ];

% Effects

elocation = { 'top'; 'top'; 'botom'; 'botom' };
esample = { 'tissue'; 'background'; 'tissue'; 'background' };

anova.labels = { 'location', 'sample' };
anova.effects = { elocation, esample };


% ! Do not modify the code from here till end of this cell.

f_anova( filesToProcess, main_mask_list, dataset_name, norm_list, anova ) % saving the anova results table

%% Running multivariate analyses after discardig peaks by filtering the ANOVA results
%{

Actions:
	Specify below the name of the file with the ANOVA results to be used for peak filtering, using the variable "criteria.file".
	Specify below the name of the column(s) to be used for peak filtering, using the variable "criteria.column".
	Specify below the filtering rule for each column, using the variable "criteria.ths_type".
	Specify below a list of filtering threshold(s) for each column, using the variable th_list.
	Specify below th rule for columns combination. If using 1 column only, this will be ignored.
	Specify below which peaks are to be used when running the MVA, using the variable "mva_peaks". 
	Specify below which lists of peaks are to be used, using the variable "mva_lists".
	Execute this cell.

The options for filtering rules are:
- "equal_below"
- "below"
- "equal_above"
- "above"

The options for peaks are:
- "top" to use the top N peaks specified in "inputs_file.xlsx"
- "lists" to use one or more of lists of molecules of interest specified in "inputs_file.xlsx"

Help:
You can run either options by setting mva_peaks = "top" or mva_peaks = "lists", or both by setting mva_peaks = [ "top", "lists" ];

%}  

% Peak filtering details

criteria.file = "anova location sample"; % string with the name of the file with the ANOVA results
criteria.column = { "p value for sample effect (mean)" }; % cell of strings which match the names of the columns of the ANOVA results to be used for filtering
criteria.ths_type = { "equal_below" }; % cell of strings with the rules for filtering (options: "equal_below", "below", "equal_above", "above")
th_list = [ 0.01, 0.05 ]; % list of doubles between 0 and 1, usually 0.01 or 0.05
criteria.combination = "or"; % string defining the rule to combine the multiple filtering criteria (options: "and", "or")

% Multivariate analyses details

mva_peaks = [ "top", "lists" ]; % 
mva_lists = [ "CRUK metabolites", "Immunometabolites", "Structural Lipids", "Fatty acid metabolism" ];


% ! Do not modify the code from here till end of this cell.

for norm = norm_list
    for th = th_list
        
        criteria.ths_value = { th };
        
        mzvalues2discard = f_anova_based_unwanted_mzs( filesToProcess, main_mask_list, dataset_name, norm, criteria); % peaks to discard are normalisation specific
                
        disp(['# peaks discarded: ', num2str(size(mzvalues2discard,1))])
        
        for task = mva_peaks
            if isequal(task,"top"); mva_lists = string([]); end % Using the top peaks specified in the "inputs_file"
            
            f_running_mva_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, dataset_name, norm, mva_lists, string([]), mzvalues2discard ) % Running MVAs
            
            f_saving_mva_outputs_ca( extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs, dataset_name, norm, mva_lists, string([]), mzvalues2discard) % Saving MVAs outputs
        end
    end
end

%% Saving data in a txt file with labels for each pixel based on the small masks

f_saving_labelled_data_ca( filesToProcess, main_mask_list, smaller_masks_list, dataset_name, 'txt' )

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

