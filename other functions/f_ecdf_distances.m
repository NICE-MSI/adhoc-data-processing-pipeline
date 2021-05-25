function f_ecdf_distances( filesToProcess, main_mask_list, dataset_name, groups, norm_list )

% This function computes the Wasserstein distance between 2 groups of
% pixels, and for every mass channel in the data cube. The groups of pixels
% used (small masks) are specified in the input "groups".
% 
% Inputs:
% filesToProcess - Matlab struct created by matlab function dir,
% containing the list of files to process and their locations / paths
% main_mask_list - array with names of the main masks i.e. those used to
% generate the representative spectrum
% dataset_name - the name of the combined dataset
% norm_list - list of strings specifying the normalisations of interest
%
% Outputs:
% - a txt file and a mat file that contain the Wasserstein distance for every mass
% channel in the datacube and between every pair of groups of pixels in
% "groups".

disp(' ')
disp('! Please make sure that every small mask has a unique name.')
disp(' ')
disp('This script works by searching for each individual small mask, within the rois folder of each individual imzml.')
disp('Masks with the same name (even if for different imzmls) will be combined.')
disp(' ')

filesToProcess = f_unique_extensive_filesToProcess(filesToProcess); % This function collects all files that need to have a common axis.

csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];

[ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);

spectra_details_path = [ char(outputs_path) '\spectra details\' ];
peak_assignments_path = [ char(outputs_path) '\peak assignments\' ];
rois_path = [ char(outputs_path) '\rois\' ];
results_path = [ char(outputs_path) '\similarity analysis\' char(dataset_name) filesep ]; if ~exist(results_path, 'dir'); mkdir(results_path); end

for main_mask = main_mask_list
    
    for norm_type = norm_list
        
        col_mean = string([]);
        col_median = string([]);
        small_mask_1 = 0;
        data4stats = [];
        pixels_per_model = [];
        
        for file_index = 1:length(filesToProcess)
            
            % Loading data
            
            disp(['! Loading ' filesToProcess(file_index).name(1,1:end-6) ' data...'])
            
            load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\' char(norm_type) '\data.mat' ])
            
            if file_index == 1
                load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\datacubeonly_peakDetails.mat' ])
            end
            
            % Masks compilation
            
            all_folders = dir([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep '*']);
            all_folders_names = string([]); for fi = 3:size(all_folders,1); all_folders_names(fi-2) = all_folders(fi).name; end
            
            pixels_per_model0 = zeros(size(data,1),length(groups.masks));
            
            for groupi = 1:length(groups.masks)
                
                [ common1, all_folders_names_i1, ~ ] = intersect(all_folders_names, groups.masks{groupi});
                
                if ~isempty(common1)
                    
                    for aux_i = all_folders_names_i1'
                        small_mask_1 = small_mask_1 + 1;
                        disp([' . ' char(all_folders_names(aux_i)) ])
                        
                        col_mean(1,small_mask_1) = string([ char(all_folders_names(aux_i)), ' mean']);
                        col_median(1,small_mask_1) = string([ char(all_folders_names(aux_i)), ' median']);
                        
                        load([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep char(all_folders_names(aux_i)) filesep 'roi' ])
                        
                        model_mask = reshape(roi.pixelSelection',[],1);
                        pixels_per_model0(:,groupi) = pixels_per_model0(:,groupi) + small_mask_1*model_mask.*~pixels_per_model0(:,groupi);
                    end
                    
                end
                
            end
            
            % Data compilation
            
            rows = logical(sum(pixels_per_model0,2)>0);
            data4stats = [ data4stats; data(rows,:) ];
            pixels_per_model = [ pixels_per_model; pixels_per_model0(rows,:) ];
            
            disp(join(['# pixels (per group): ' num2str(sum(pixels_per_model0>0))]))
            
        end
        
        disp(join(['! total # pixels (per group): ' num2str(sum(pixels_per_model>0))]))
        
        load([ peak_assignments_path filesToProcess(1).name(1,1:end-6) '\' char(main_mask) '\hmdb_sample_info' ])
        load([ peak_assignments_path filesToProcess(1).name(1,1:end-6) '\' char(main_mask) '\relevant_lists_sample_info' ])
        
        extended_hmdb_sample_info = [
            hmdb_sample_info
            [ relevant_lists_sample_info, repmat("",size( relevant_lists_sample_info,1),size(hmdb_sample_info,2)-size(relevant_lists_sample_info,2))]
            ];
        
        % Curating the HMDB assigments information
        
        new_hmdb_sample_info = f_saving_curated_hmdb_info( extended_hmdb_sample_info, relevant_lists_sample_info );
        
        % ECDF-based Distance Measure Estimation
        
        disp('! Estimating ECDF-based distance measure...')
        
        table_row1 = string([]);
        table_moving_row = string([]);
        
        for groupi = 1:length(groups.pairs) % iterating through rge pairs of groups os pixels (i.e. ROIs)
            
            XX = data4stats(pixels_per_model(:,groups.pairs{groupi}(1))>0,:);
            YY = data4stats(pixels_per_model(:,groups.pairs{groupi}(2))>0,:);
            
            WS_Dist = Wasserstein_Dist(XX,YY);
            WS_Dist_Xaviers = Wasserstein_Dist_Xaviers(XX,YY);
            
            % Bulding the table with the distances
            
            table_row1 = [ table_row1, ...
                ['WS dist (' char(groups.names{groups.pairs{groupi}(2)}) ' vs ' char(groups.names{groups.pairs{groupi}(1)}) ')'],...
                ['WS dist Xaviers (' char(groups.names{groups.pairs{groupi}(2)}) ' vs ' char(groups.names{groups.pairs{groupi}(1)}) ')'],...
                ];
            table_moving_row = [ table_moving_row, string(WS_Dist), string(WS_Dist_Xaviers) ];
            
        end
        
        table = [ table_row1; table_moving_row ];
        
        % Saving table
        
        disp('! Saving ECDF-based distance measure estimatives table...')
        
        mkdir([ results_path char(main_mask) '\' char(norm_type) ])
        cd([ results_path char(main_mask) '\' char(norm_type) ])
        
        save(strjoin([ groups.name, '.mat' ],''),'table' )
        
        table(ismissing(table)) = "NaN";
        
        txt_row = strcat(repmat('%s\t',1,size(table,2)-1),'%s\n');
        
        fileID = fopen([ char(groups.name), '.txt' ], 'w');
        fprintf(fileID,txt_row, table');
        fclose(fileID);
        
        disp('! Finished.')
        
    end
    
end
