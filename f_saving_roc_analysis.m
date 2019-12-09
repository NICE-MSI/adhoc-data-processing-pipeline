function f_saving_roc_analysis( extensive_filesToProcess, main_mask_list, mask_on, group0, group0_name, group1, group1_name, norm_list, dataset_name, smaller_masks_list, outputs_xy_pairs )

filesToProcess = f_unique_extensive_filesToProcess(extensive_filesToProcess); % This function collects all files that need to have a common axis.

csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];

[ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);

spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
peak_assignments_path   = [ char(outputs_path) '\peak assignments\' ];
roc_path                = [ char(outputs_path) '\roc\' ]; if ~exist(roc_path, 'dir'); mkdir(roc_path); end
rois_path               = [ char(outputs_path) '\rois\' ];

for main_mask = main_mask_list
    
    for norm_type = norm_list
        
        data4roc = [];
        pixels_per_model = [];
        
        for file_index = 1:length(filesToProcess)
            
            % Datacube loading
            
            load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\datacube' ])
            load([ rois_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\roi'])
            
            if file_index
                load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\totalSpectrum_mzvalues' ])
            end
                       
            % Data normalisation
            
            norm_data = f_norm_datacube( datacube, norm_type );
            
            % Data compilation
            
            data4roc = [ data4roc; norm_data ];
            
            % Masks
            
            pixels_per_model0 = zeros(size(norm_data,1),2);
            
            %
            
            all_folders = dir([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep '*']);
            all_folders_names = string([]); for fi = 3:size(all_folders,1); all_folders_names(fi-2) = all_folders(fi).name; end
            
            [ common1, all_folders_names_i1, ~ ] = intersect(all_folders_names,group0);
            
            if ~isempty(common1)
                
                disp(filesToProcess(file_index).name(1,1:end-6))
                
                for aux_i = all_folders_names_i1'
                    
                    disp(all_folders_names(aux_i))
                    
                    load([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep char(all_folders_names(aux_i)) filesep 'roi' ])
                    
                    model_mask = reshape(roi.pixelSelection',[],1);
                    pixels_per_model0(:,1) = pixels_per_model0(:,1) + model_mask;
                    
                end
                
            end
            
            [ common2, all_folders_names_i2, ~ ] = intersect(all_folders_names,group1);
            
            if ~isempty(common2)
                
                disp(filesToProcess(file_index).name(1,1:end-6))
                
                for aux_i = all_folders_names_i2'
                    
                    disp(all_folders_names(aux_i))
                    
                    load([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep char(all_folders_names(aux_i)) filesep 'roi' ])
                    
                    model_mask = reshape(roi.pixelSelection',[],1);
                    pixels_per_model0(:,2) = pixels_per_model0(:,2) + model_mask;
                    
                end
                
            end
            
            pixels_per_model = [ pixels_per_model; pixels_per_model0 ];
            
            disp(sum(pixels_per_model,1))
                        
        end
                
        load([ peak_assignments_path filesToProcess(1).name(1,1:end-6) '\' char(main_mask) '\hmdb_sample_info' ])
        load([ peak_assignments_path filesToProcess(1).name(1,1:end-6) '\' char(main_mask) '\relevant_lists_sample_info' ])
        
        extended_hmdb_sample_info = [ 
            hmdb_sample_info
            [ relevant_lists_sample_info, repmat("",size( relevant_lists_sample_info,1),size(hmdb_sample_info,2)-size(relevant_lists_sample_info,2))] 
            ];
        
        new_hmdb_sample_info = f_saving_curated_hmdb_info( extended_hmdb_sample_info, relevant_lists_sample_info );
        
        %%% ROC curves
        
        roc_analysis_table = [ "AUC", "meas mz", "molecule", "mono mz", "adduct", "ppm", "database (by mono mz)" ];
        sii_sample_info = [];
        
        for mzi = 1:size(datacube.spectralChannels,1)
            
            labels = [
                repmat(group0_name,  size(data4roc(logical(pixels_per_model(:,1) == 1),mzi),1), 1)
                repmat(group1_name,  size(data4roc(logical(pixels_per_model(:,2) == 1),mzi),1), 1)
                ];
            
            scores = [
                data4roc(logical(pixels_per_model(:,1) == 1),mzi)
                data4roc(logical(pixels_per_model(:,2) == 1),mzi)
                ];
            
            posclass = group1_name;
            
            [~,~,~,AUC] = perfcurve(labels,scores,posclass);
            
            if (AUC >= 0.7) || ((AUC <= 0.3) && (AUC > 0))
                
                % ROC table
                                
                indexes2add = (abs(datacube.spectralChannels(mzi)-double(new_hmdb_sample_info(:,3))) < min(diff(totalSpectrum_mzvalues)));
                
                if sum(indexes2add) >= 1
                
                roc_analysis_table = [
                    roc_analysis_table
                    [ string(repmat([ AUC, datacube.spectralChannels(mzi)],sum(indexes2add),1)) new_hmdb_sample_info(indexes2add,[1:2 4:end]) ]
                    ];
                
                else
                    
                    roc_analysis_table = [
                    roc_analysis_table
                    [ string(repmat([ AUC, datacube.spectralChannels(mzi)],1,1)) repmat("not assigned", 1, size(new_hmdb_sample_info(:,[1:2 4:end]),2)) ]
                    ];
                
                end
                
                % SIIs
                                
                indexes2add = (abs(datacube.spectralChannels(mzi)-double(extended_hmdb_sample_info(:,4))) < min(diff(totalSpectrum_mzvalues)));
                
                if sum(indexes2add) >= 1
                    
                    sii_sample_info = [ sii_sample_info; extended_hmdb_sample_info(find(indexes2add,1),:) ]; % just one sii per peak
                    
                else
                    
                    aux_row = repmat("not assigned", 1, size(extended_hmdb_sample_info,2));
                    aux_row(:,4) = datacube.spectralChannels(mzi);
                    
                    sii_sample_info = [ sii_sample_info; aux_row ]; % just one sii per peak
                    
                end
                
            end
        end
                
        sii_sample_info(1:end,7) = strjoin([ 'roc analysis ', group1_name, ' vs ', group0_name ]);
        
        % Saving roc results
        
        disp('! Started saving ROC table...')
        
        mkdir([ roc_path char(main_mask) '\' char(norm_type) ])
        cd([ roc_path char(main_mask) '\' char(norm_type) ])
        
        save([ 'roc analysis ' char(group1_name) ' vs ' char(group0_name) '.mat' ],'roc_analysis_table' )
        
        txt_row = strcat(repmat('%s\t',1,size(roc_analysis_table,2)-1),'%s\n');
        
        fileID = fopen([ 'roc analysis ' char(group1_name) ' vs ' char(group0_name) '.txt' ],'w');
        fprintf(fileID,txt_row, roc_analysis_table');
        fclose(fileID);
        
        disp('! Finished saving ROC table...')
        
        % Saving siis
        
        disp(['! Started saving ' num2str(size(sii_sample_info,1)) ' SIIs...'])
        
        if size(sii_sample_info,1)>1
            
            if isempty(dataset_name)
                
                f_saving_sii_sample_info( filesToProcess, main_mask, norm_type, sii_sample_info, mask_on )
                
            else
                
                f_saving_sii_sample_info_ca( extensive_filesToProcess, main_mask, smaller_masks_list, outputs_xy_pairs, dataset_name, norm_type, sii_sample_info )
                
            end
            
        end
        
        disp('! Finished saving SIIs...')
        
    end
end
