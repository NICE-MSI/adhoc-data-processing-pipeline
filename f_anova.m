function f_anova( filesToProcess, main_mask_list, dataset_name, norm_list, anova )

% This function runs an ANOVA for every mass channel in the data cube, 
% using the effects and groups of pixels (small masks) specified in 
% the input "anova". In particular, it tests if there is a statistical 
% relationship between the mean (and median) counts of every small mask 
% and each one of the effects of interest.
%
% Inputs:
% filesToProcess - Matlab struct created by matlab function dir,
% containing the list of files to process and their locations / paths
% main_mask_list - array with names of the main masks i.e. those used to
% generate the representative spectrum
% dataset_name - the name of the combined dataset
% norm_list - list of strings specifying the normalisations of interest
% anova - Matlab struct which contains information about the groups of 
% pixels (small masks), labels (groups of small masks), and effects to be 
% used to run the ANOVA
%
% Output:
% - a txt file where each row is related to a mass channel, which shows 
% the p- and F- values for every effect of interest, some information 
% regarding potential peak assigments, and the mean (and median) counts 
% for each one of the groups of pixels i.e. small masks.

disp(' ')
disp('! Please make sure that every small mask (group of pixels) has a unique name.')
disp(' ')
disp('This script works by searching for each individual small mask, within the rois folder of each individual imzml.')
disp('Masks with the same name (even if for different imzmls) will be combined.')
disp(' ')

filesToProcess = f_unique_extensive_filesToProcess(filesToProcess); % collecting all files that need to have a common axis

csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];

% Reading information regarding the location of all the pipeline outputs

[ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);

% Defining the paths that will be required

spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
peak_assignments_path   = [ char(outputs_path) '\peak assignments\' ];
anova_path              = [ char(outputs_path) '\anova\' filesep char(dataset_name) filesep ]; if ~exist(anova_path, 'dir'); mkdir(anova_path); end
rois_path               = [ char(outputs_path) '\rois\' ];

for main_mask = main_mask_list % iterating through main masks

    for norm_type = norm_list  % iterating through normalisations
        
        col_mean = string([]); % initiating the names of the columns under which the mean counts will be saved
        col_median = string([]); % initiating the names of the columns under which the median counts will be saved
        
        data4anova = []; % initiating matrix that will have the data to be tested
        pixels_per_model = [];
        
        for file_index = 1:length(filesToProcess) % iterating through imzmls
            
            % Loading data
            
            disp(['! Loading ' filesToProcess(file_index).name(1,1:end-6) ' data...'])
            
            load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\' char(norm_type) '\data.mat' ])
            
            % Loading peak details
            
            if file_index == 1
                load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\datacubeonly_peakDetails.mat' ])
            end
            
            % Gathering masks for mean and median computation
            
            all_folders = dir([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep '*']);
            all_folders_names = string([]); for fi = 3:size(all_folders,1); all_folders_names(fi-2) = all_folders(fi).name; end
            
            pixels_per_model0 = zeros(size(data,1),1);
            
            for anovamaski = 1:length(anova.masks) % iterating through small masks
                
                [ common, all_folders_names_i, ~ ] = intersect( all_folders_names, anova.masks(anovamaski) ); % check if the small mask belongs to the imzml
                
                if ~isempty(common)
                    
                    for aux_i = all_folders_names_i' % iterating through all the small masks that belong to the imzml
                        disp([' . ' char(all_folders_names(aux_i)) ])
                        
                        col_mean(1,anovamaski) = string([ char(all_folders_names(aux_i)), ' mean']); % defining the column names
                        col_median(1,anovamaski) = string([ char(all_folders_names(aux_i)), ' median']); % defining the column names
                        
                        load([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep char(all_folders_names(aux_i)) filesep 'roi' ]) % loading the small mask
                        
                        model_mask = reshape(roi.pixelSelection',[],1);
                        pixels_per_model0(:,1) = pixels_per_model0(:,1) + model_mask.*anovamaski.*~pixels_per_model0(:,1); % storing the small masks (each small mask has a unique id within the imzml they belong to)
                        disp(join(['# pixels (per mask): ' num2str(sum(pixels_per_model0(:,1)==anovamaski,1))]))
                    end
                    
                end
                
            end
            
            % Data compilation
            
            rows = logical(sum(pixels_per_model0,2)>0);
            data4anova = [ data4anova; data(rows,:) ]; % grabing the data (ion counts for all masses) that will be averaged (ranked) for the anova
            pixels_per_model = [ pixels_per_model; pixels_per_model0(rows,:) ]; % grabing the ids of the small masks that will will be used to average (rank) the data
            
        end
        
        % Loading peak matching information (which will also be present in
        % the output table)
        
        load([ peak_assignments_path filesToProcess(1).name(1,1:end-6) '\' char(main_mask) '\hmdb_sample_info' ])
        load([ peak_assignments_path filesToProcess(1).name(1,1:end-6) '\' char(main_mask) '\relevant_lists_sample_info' ])
        
        extended_hmdb_sample_info = [
            hmdb_sample_info
            [ relevant_lists_sample_info, repmat("",size( relevant_lists_sample_info,1),size(hmdb_sample_info,2)-size(relevant_lists_sample_info,2))]
            ];
        
        % Curating peak matching information
        
        new_hmdb_sample_info = f_saving_curated_hmdb_info( extended_hmdb_sample_info, relevant_lists_sample_info );
        
        %%% ANOVA
        
        % Defining the columns of the output table
        
        mean_col_names = [];
        median_col_names = [];
        for wayi = 1:length(anova.labels)
            mean_col_names = [ mean_col_names, string([ 'p value for ' anova.labels{wayi} ' effect (mean)' ]), string([ 'F value for ' anova.labels{wayi} ' effect (mean)' ]) ];
            median_col_names = [ median_col_names, string([ 'p value for ' anova.labels{wayi} ' effect (median)' ]), string([ 'F value for ' anova.labels{wayi} ' effect (median)' ]) ];
        end
        
        anova_analysis_table = [ ...
            mean_col_names, col_mean, ...
            median_col_names, col_median, ...
            "meas mz", "molecule", "mono mz", "adduct", "ppm", "database (by mono mz)", "kingdom", "super class", "class", "subclass"
            ];
        
        for mzi = 1:size(data4anova,2) % iterating through masses
            
            mean_d = zeros(1,length(anova.masks));
            median_d = zeros(1,length(anova.masks));
            
            % Computing mean (and median) counts for each group of pixels i.e. small mask
            
            for anovamaski = unique(pixels_per_model)'
                mean_d(1,anovamaski) = mean(data4anova(pixels_per_model(:,1)==anovamaski,mzi),'omitnan');
                median_d(1,anovamaski) = median(data4anova(pixels_per_model(:,1)==anovamaski,mzi),'omitnan');
            end
            
            % Running an ANOVA on the mean (and median) values
            
            if sum(~isnan(mean_d))>0
                
                [ mean_p, mean_tbl, ~, ~ ] = anovan(mean_d, anova.effects, 'display','off');
                [ median_p, median_tbl, ~, ~ ] = anovan(median_d, anova.effects, 'display','off');
                
                mean_F = NaN*mean_p; for tbli = 2:(size(mean_tbl,1)-2); mean_F(tbli-1,1) = mean_tbl{tbli,6}; end
                median_F = NaN*median_p; for tbli = 2:(size(median_tbl,1)-2); median_F(tbli-1,1) = median_tbl{tbli,6}; end
                
                % Grabing the peak assigment details for the current mass
                
                indexes2add = (abs(datacubeonly_peakDetails(mzi,2)-double(new_hmdb_sample_info(:,3))) < 1e-10);
                
                % Updating the output table
                
                if sum(indexes2add) >= 1 % where there is at least one assignment for this mass
                    
                    mean_aux = reshape([ mean_p mean_F ]',[],1)';
                    median_aux = reshape([ median_p median_F ]',[],1)';
                    
                    aux_row = string(repmat([ mean_aux, mean_d, median_aux, median_d ], sum(indexes2add), 1));
                    aux_row(ismissing(aux_row)) = "NaN";
                                        
                    anova_analysis_table = [
                        anova_analysis_table
                        [ aux_row, new_hmdb_sample_info(indexes2add,[3 1:2 4:end]) ]
                        ];
                    
                else % when there are no assignments for this mass
                    
                    aux_row = string(repmat([ mean_aux, mean_d, median_aux, median_d, datacubeonly_peakDetails(mzi,2)], 1, 1));
                    aux_row(ismissing(aux_row)) = "NaN";
                    
                    anova_analysis_table = [
                        anova_analysis_table
                        [ aux_row, repmat("not assigned", 1, size(new_hmdb_sample_info(indexes2add,[1:2 4:end]),2)) ]
                        ];
                    
                end
                
            end
            
        end
        
        % Creating a new folder to save the output table
        
        mkdir([ anova_path char(main_mask) '\' char(norm_type) ])
        cd([ anova_path char(main_mask) '\' char(norm_type) ])
        
        % Defining the name of the output table file
        
        file_name = 'anova';
        for wayi = 1:length(anova.labels)
            file_name = [file_name, [' ', anova.labels{wayi}]];
        end
        
        % Saving the .mat and .txt with the output table
        
        save([ file_name '.mat' ], 'anova_analysis_table' )
        
        txt_row = strcat(repmat('%s\t',1,size(anova_analysis_table,2)-1),'%s\n');
        
        fileID = fopen([ file_name '.txt' ],'w');
        fprintf(fileID,txt_row, anova_analysis_table');
        fclose(fileID);
        
    end
    
end
