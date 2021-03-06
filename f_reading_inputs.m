function [ ...
    modality, ...
    polarity, ...
    adducts_list, ...
    mva_list, ...
    amplratio4mva_array, ...
    numPeaks4mva_array, ...
    perc4mva_array, ...
    numComponents_array, ...
    numLoadings_array, ...
    mva_molecules_lists_csv_list, ...
    mva_molecules_lists_label_list, ...
    mva_max_ppm, ...
    pa_molecules_lists_csv_list, ...
    pa_molecules_lists_label_list, ...
    pa_max_ppm, ...
    fig_ppm, ...
    outputs_path ...
    ] = f_reading_inputs(csv_inputs)

% Reads the "inputs_file.xlsx" and outputs a group of variables that are 
% used across the entire ad hoc data processing pipeline.
%
% Inputs: 
% csv_inputs (string) - complete path to "inputs_file.xlsx"
%
% Outputs:
% modality - e.g. MALSI, DESI
% polarity - e.g. positive, negative (key to define the adducts)
% adducts_list - list of adducts to use for assigments
% mva_list - list of MVAs to run
% numPeaks4mva_array - list of the top numbers of peaks to keep
% numComponents_array - list of the number os components (e.g. cluster
% number, PCs number, factor number)
% numLoadings_array - list of the number so loading to save outputs for
% mva_molecules_lists_csv_list - list of the complete paths to the file
% that contain each list of molecules of interest
% mva_molecules_lists_label_list - list of the names of the lists of 
% molecules of interest
% mva_max_ppm - maximum ppm for the assigments
% pa_molecules_lists_csv_list - list of the complete paths to the file
% that contain each list of molecules of interest
% pa_molecules_lists_label_list - list of the names of the lists of 
% molecules of interest
% pa_max_ppm - maximum ppm for the assigments
% fig_ppm - ppm error  that is highlighted by 2 vertical lines in the
% picture
% outputs_path - complete path to where all the outputs will be saved


[ ~, ~, inputs_info ] = xlsread(csv_inputs);

inputs_info_reshaped = string(reshape(inputs_info',[],1));
inputs_info_reshaped(ismissing(inputs_info_reshaped)) = [];

gen_info = 0;
mva_info = 0;

peak_assign_info = 0;
adducts_info = 0;

adducts_list = {};
adducts_i = 0;

mva_list = string([]);
amplratio4mva_array = [];
numPeaks4mva_array = [];
perc4mva_array = [];

numComponents_array = [];
numLoadings_array = [];

mva_molecules_lists_csv_list    = string([]);
mva_molecules_lists_label_list  = string([]);
mva_max_ppm = [];

pa_molecules_lists_csv_list   	= string([]);
pa_molecules_lists_label_list   = string([]);
pa_max_ppm = [];
fig_ppm = [];

% Path to the folder where the lists of molecules of interest are saved

metabolite_lists_path = "\\datasvr1\MALDI_AMBIENT_DATA\2020_Scripts for Data Processing\Git Repository (March 2020)\molecules-lists\";
logical_list_path = 0;

pa_molecules_lists_csv_list(1,1)    = strcat(metabolite_lists_path,"4_Reference_List.xlsx");
pa_molecules_lists_label_list(1,1)  = "reference";

% Goes through the inputs file to collect all the information

for i = 1:length(inputs_info_reshaped)
    
    if peak_assign_info
        if strcmpi(inputs_info_reshaped(i),"positive") || strcmpi(inputs_info_reshaped(i),"pos")
            pos_aux_2 = 1;
        elseif strcmpi(inputs_info_reshaped(i),"negative") || strcmpi(inputs_info_reshaped(i),"neg")
            pos_aux_2 = 0;
        end
    end
    
    if adducts_info
        if strcmpi(inputs_info_reshaped(i),"yes") || strcmpi(inputs_info_reshaped(i),"y")
            if pos_aux && pos_aux_2
                adducts_i = adducts_i + 1;
                adducts_list{1,adducts_i} = char(inputs_info_reshaped(i-1));
            elseif ~pos_aux && ~pos_aux_2
                adducts_i = adducts_i + 1;
                adducts_list{1,adducts_i} = char(inputs_info_reshaped(i-1));
            else
                disp('! Your polarity and requested adduct forms do not match. Please update the inputs file and run peak assigments routines again.')
            end
        end
    end
    
    % depending on which input info we are currently looking at
    switch inputs_info_reshaped(i)
        % if it is general information
        case "General Information"
            gen_info = 1;
        case "Multivariate Analyses"
            mva_info = 1;
            adducts_info = 0;
        case "Peak Assignments"
            peak_assign_info = 1;
            logical_list_path = 1;
        case "Adducts"
            logical_list_path = 0;
            adducts_info = 1;
        case "Modality"
            if peak_assign_info == 0
                modality = inputs_info_reshaped(i+1);
            end
        case "Polarity"
            if peak_assign_info == 0
                if strcmpi(inputs_info_reshaped(i+1),"positive") || strcmpi(inputs_info_reshaped(i+1),"pos")
                    polarity = "positive";
                    pos_aux = 1;
                elseif strcmpi(inputs_info_reshaped(i+1),"negative") || strcmpi(inputs_info_reshaped(i+1),"neg")
                    polarity = "negative";
                    pos_aux = 0;
                else
                    disp("Unknow polarity!")
                    break
                end
            end
        case "Outputs path"
            outputs_path = char(inputs_info_reshaped(i+1));
        case "Highest Intensity"
            if strcmpi(inputs_info_reshaped(i+2),"yes")
                aux_vector = str2num(char(inputs_info_reshaped(i+4))); % Number
                numPeaks4mva_array = [ numPeaks4mva_array, aux_vector ];
                aux_vector = str2num(char(inputs_info_reshaped(i+6))); % Percentile
                perc4mva_array = [ perc4mva_array, aux_vector ];
                if isempty(numPeaks4mva_array) && isempty(perc4mva_array); disp("Undefined number and percentile of highest intensity peaks!"); end
            end            
        case "CRUK metabolites"
            list_path = strcat( metabolite_lists_path, "114_Metabolite_List.xlsx" );
        case "Beatson lipids"
            list_path = strcat( metabolite_lists_path, "816_Lipid_List.xlsx" );
        case "AZ Glycolysis"
            list_path = strcat( metabolite_lists_path, "AZ_Glycolysis.xlsx" );
        case "AZ TCA"
            list_path = strcat( metabolite_lists_path, "AZ_TCA.xlsx" );
        case "Glycolysis"
            list_path = strcat( metabolite_lists_path, "17_Glycolysis.xlsx" );
        case "Glutaminolysis"
            list_path = strcat( metabolite_lists_path, "33_Glutaminolysis.xlsx" );
        case "Pentose phosphate pathway"
            list_path = strcat( metabolite_lists_path, "22_Pentose Phosphate Pathway.xlsx" );
        case "Citric acid cycle"
            list_path = strcat( metabolite_lists_path, "25_Citric Acid Cycle.xlsx" );
        case "Pyruvate metabolism"
            list_path = strcat( metabolite_lists_path, "27_Pyruvate Metabolism.xlsx" );
        case "Fatty acid metabolism"
            list_path = strcat( metabolite_lists_path, "39_Fatty acid Metabolism.xlsx" );
        case "Steroid biosynthesis"
            list_path = strcat( metabolite_lists_path, "40_Steroid Biosynthesis.xlsx" );
        case "Mevalonic aciduria"
            list_path = strcat( metabolite_lists_path, "43_Mevalonic aciduria.xlsx" );
        case "8 Sphingolipids"
            list_path = strcat( metabolite_lists_path, "8_Sphingolipids.xlsx" );
        case "previous AZ KRAS study"
            list_path = strcat( metabolite_lists_path, "27_previous_AZ_KRAS_study.xlsx" );
        case "Gd-dota"
            list_path = strcat( metabolite_lists_path, "1_GdDota.xlsx" );
        case "Beatson LCMS"
            list_path = strcat( metabolite_lists_path, "81_Beatson_LCMS.xlsx" );
        case "U13C-glutamine infusion"
            list_path = strcat( metabolite_lists_path, "22_U13C-glutamine infusion.xlsx" );
        case "U13C-glutamine infusion all"
            list_path = strcat( metabolite_lists_path, "64_U13C-glutamine infusion all.xlsx" );
        case "Beatson metabolomics & CRUK list"
            list_path = strcat( metabolite_lists_path, "131_Beatson metabolomics & CRUK list.xlsx" );
        case "Shorter Beatson metabolomics & CRUK list"
            list_path = strcat( metabolite_lists_path, "125_Shorter Beatson metabolomics & CRUK list.xlsx" );
        case "Sig Compounds"
            list_path = strcat( metabolite_lists_path, "sig_compoundids_ms.xlsx" );
        case "HMDB Lipids and lipid-like molecules"
            list_path = strcat( metabolite_lists_path, "90360_hmdb_Lipids_and_lipid_like_molecules.xlsx" );
        case "SLC7a5 list"
            list_path = strcat( metabolite_lists_path, "34_Slc7a5_list.xlsx" );
        case "Nucleotide pathways"
            list_path = strcat( metabolite_lists_path, "22_nucleotide_pathways.xlsx" );
        case "slc7a5 ROC hydroxybutyrate"
            list_path = strcat( metabolite_lists_path, "slc7a5_ROC_hydroxybutyrate.xlsx" );
        case "Immunometabolites"
            list_path = strcat( metabolite_lists_path, "90_Immunometabolites.xlsx" );
        case "PDAC drugs"
            list_path = strcat( metabolite_lists_path, "4_pdac_drugs.xlsx" );
        case "U13C Glutamine"
            list_path = strcat( metabolite_lists_path, "U13C_Glutamine.xlsx" );
        case "Structural Lipids"
            list_path = strcat( metabolite_lists_path, "lipids_first_pass.xlsx" );
        case "Coenzymes"
            list_path = strcat( metabolite_lists_path, "8_Coenzymes.xlsx" );
        case "Small intestine DESI neg APC-KRAS vs WT"
            list_path = strcat( metabolite_lists_path, "Small intestine DESI neg APC-KRAS vs WT.xlsx" ); 
        case "dossed-cassette-dugs-incomplete"
            list_path = strcat( metabolite_lists_path, "dossed-cassette-dugs-incomplete.xlsx" ); 
        case "Marcels Lipid List"
            list_path = strcat( metabolite_lists_path, "Marcel_new_Lipid_List.xlsx" );
        case "Amino Acids"
            list_path = strcat( metabolite_lists_path, "amino_acids.xlsx" );
        case "Proteinogenic Amino Acids"
            list_path = strcat( metabolite_lists_path, "proteinogenic_aminoacids.xlsx" );
        case "U13C-glutamine SLC7a5"
            list_path = strcat( metabolite_lists_path, "U13C-glutamine_slc7a5.xlsx" );
        case "PI3K Drug List"
            list_path = strcat( metabolite_lists_path, "Beatson PI3K Drug List.xlsx" );
        case "Beatson_new_LC-MS"
            list_path = strcat( metabolite_lists_path, "Intracolonics_new_LC-MS_MN_20200407.xlsx" );
        case "Beatson_only_new_LC-MS"
            list_path = strcat( metabolite_lists_path, "Intracolonics_new_LC-MS_only_new.xlsx" );
        case "Beatson_U13C Leucine"
            list_path = strcat( metabolite_lists_path, "Beatson_U13C Leucine.xlsx" );
        case "Lysine Carnitine Intermediates"
            list_path = strcat( metabolite_lists_path, "lysine_carnitine_intermediates.xlsx" );
            
        case "2-alkyl-4-quinolones"
            list_path = strcat( metabolite_lists_path, "2-alkyl-4-quinolones.xlsx" );
        case "3-alkyl-23-dihydroxy-4-quinolones"
            list_path = strcat( metabolite_lists_path, "3-alkyl-23-dihydroxy-4-quinolones.xlsx" );
        case "rhamnolipids"
            list_path = strcat( metabolite_lists_path, "Rhamnolipids.xlsx" );
        case "N-acyl-homoserine lactone"
            list_path = strcat( metabolite_lists_path, "N-acyl-homoserine lactone.xlsx" );
        case "nucleobases"   
            list_path = strcat( metabolite_lists_path, "Nucleobases.xlsx" );
        case "amino acids (bacteria)"
            list_path = strcat( metabolite_lists_path, "Amino Acids (bacteria).xlsx" );
        case "lipids (bacteria)"
            list_path = strcat( metabolite_lists_path, "Lipids (bacteria).xlsx" );
        case "miscellaneous compounds (bacteria)"
            list_path = strcat( metabolite_lists_path, "miscellaneous compounds (bacteria).xlsx" );
            
        case "maximum ppm error"
            if peak_assign_info == 0
                mva_max_ppm = double(inputs_info_reshaped(i+1));
                if isnan(mva_max_ppm) && ~isempty(mva_molecules_lists_csv_list)
                    disp("Undefined mz tolerance for MVA analysis!")
                end
            else
                pa_max_ppm = double(inputs_info_reshaped(i+1));
                if isnan(pa_max_ppm)
                    disp("Undefined mz tolerance for Peak Assignment analysis!")
                end
                if ~isempty(mva_max_ppm)
                    pa_max_ppm = max(pa_max_ppm,mva_max_ppm);
                end
            end
        case "plotting ppm error"
            fig_ppm = double(inputs_info_reshaped(i+1));
        case "PCA"
            if strcmpi(inputs_info_reshaped(i+2),"yes")
                aux_vector = str2num(char(inputs_info_reshaped(i+4)));
                mva_list = [ mva_list, "pca" ];
                numComponents_array = [ numComponents_array, aux_vector ];
                numLoadings_array = [ numLoadings_array, repmat(10,1,size(aux_vector,2)) ];
                if isnan(aux_vector)
                    disp("Undefined number of componenets to save for PCA!")
                    break
                end
            end
        case "Reconstruction Independent Component Analysis (RICA)"
             if strcmpi(inputs_info_reshaped(i+2),"yes")
                aux_vector = str2num(char(inputs_info_reshaped(i+4)));
                mva_list = [ mva_list, repmat("rica",1,size(aux_vector,2)) ];
                numComponents_array = [ numComponents_array, aux_vector ];
                numLoadings_array = [ numLoadings_array, repmat(10,1,size(aux_vector,2)) ];
                if isnan(aux_vector)
                    disp("Undefined number of componenets to save for RICA!")
                    break
                end
            end
        case "NNMF"
            if strcmpi(inputs_info_reshaped(i+2),"yes")
                aux_vector = str2num(char(inputs_info_reshaped(i+4)));
                mva_list = [ mva_list, repmat("nnmf",1,size(aux_vector,2)) ];
                numComponents_array = [ numComponents_array, aux_vector ];
                numLoadings_array = [ numLoadings_array, repmat(10,1,size(aux_vector,2)) ];
                if isnan(aux_vector)
                    disp("Undefined number of componenets for NNMF!")
                    break
                end
            end
        case "k-means"
            if strcmpi(inputs_info_reshaped(i+2),"yes")
                aux_vector = [ str2num(char(inputs_info_reshaped(i+4))) ];
                mva_list = [ mva_list, repmat("kmeans",1,size(aux_vector,2)) ];
                numComponents_array = [ numComponents_array, aux_vector ];
                numLoadings_array = [ numLoadings_array, repmat(10,1,size(aux_vector,2)) ]; % change 10 to change the number of loadings saved
                if isnan(str2num(char(inputs_info_reshaped(i+4))))
                    disp("Undefined number of componenets for k-means!")
                    break
                end
            end
        case "Hierarchical Clustering"
            if strcmpi(inputs_info_reshaped(i+2),"yes")
                aux_vector = [ str2num(char(inputs_info_reshaped(i+4))) ];
                mva_list = [ mva_list, repmat("hierarclustering",1,size(aux_vector,2)) ];
                numComponents_array = [ numComponents_array, aux_vector ];
                numLoadings_array = [ numLoadings_array, repmat(10,1,size(aux_vector,2)) ];
                if isnan(str2num(char(inputs_info_reshaped(i+4))))
                    disp("Undefined number of nodes for Hierarchical Clustering!")
                    break
                end
            end
        case "NN t-sne"
            if strcmpi(inputs_info_reshaped(i+2),"yes")
                aux_vector = [ str2num(char(inputs_info_reshaped(i+4))) ];
                mva_list = [ mva_list, repmat("nntsne",1,size(aux_vector,2)) ];
                numComponents_array = [ numComponents_array, aux_vector ];
                numLoadings_array = [ numLoadings_array, repmat(10,1,size(aux_vector,2)) ];
            end
        case "t-sne"
            if strcmpi(inputs_info_reshaped(i+2),"yes")
                aux_vector = [ str2num(char(inputs_info_reshaped(i+4))) ];
                mva_list = [ mva_list, repmat("tsne",1,size(aux_vector,2)) ];
                numComponents_array = [ numComponents_array, aux_vector ];
                numLoadings_array = [ numLoadings_array, repmat(10,1,size(aux_vector,2)) ];
            end
        case "fdc"
            if strcmpi(inputs_info_reshaped(i+2),"yes")
                string_split = split(inputs_info_reshaped(i+4),',');
                aux_vector = [];
                for option=string_split'
                    if strcmpi("manual",option) || strcmpi(" manual",option) || strcmpi("manual ",option) || strcmpi(" manual ",option)
                        aux_vector = [ aux_vector, -1 ];
                    else
                        aux_vector = [ aux_vector, str2num(char(option)) ];
                    end
                end
                mva_list = [ mva_list, repmat("fdc",1,size(aux_vector,2)) ];
                numComponents_array = [ numComponents_array, aux_vector ];
                numLoadings_array = [ numLoadings_array, repmat(10,1,size(aux_vector,2)) ];
            end
            
    end
    
    if logical_list_path && strcmpi(inputs_info_reshaped(i+2),"yes")
        if peak_assign_info == 0 
            mva_molecules_lists_csv_list    = [ mva_molecules_lists_csv_list, list_path ];
            mva_molecules_lists_label_list  = [ mva_molecules_lists_label_list, inputs_info_reshaped(i) ];
        elseif peak_assign_info == 1
            pa_molecules_lists_csv_list    = [ pa_molecules_lists_csv_list, list_path ];
            pa_molecules_lists_label_list  = [ pa_molecules_lists_label_list, inputs_info_reshaped(i) ];
        end
    end
    
end
