function f_saving_whole_tissue_roc_analysis_ca( filesToProcess, main_mask_list, dataset_name, group0, group0_name, group1, group1_name, norm_list, molecules_list )

% molecules_list = "Shorter Beatson metabolomics & CRUK list";

aux_names = []; for i = 1:length(filesToProcess); aux_names = [ aux_names, string(filesToProcess(i).name) ]; end
[ ~, uindexes ] = unique(aux_names);
filesToProcess = filesToProcess(uindexes,:);

csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];

[ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);

spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
peak_assignments_path   = [ char(outputs_path) '\peak assignments\' ];
if isempty(molecules_list)
    roc_path                = [ char(outputs_path) '\roc\' ]; if ~exist(roc_path, 'dir'); mkdir(roc_path); end
end
rois_path               = [ char(outputs_path) '\rois\' ];

for main_mask = main_mask_list
    
    for norm_type = norm_list
        
        data4roc = [];
        pixels_per_model = [];
        
        for file_index = 1:length(filesToProcess)
            
            % Datacube loading
            
            load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\datacube' ])
            load([ rois_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\roi'])
            
            norm_mask = reshape(roi.pixelSelection',[],1);
            
            % Data normalisation
            
            norm_data = f_norm_datacube_v2( datacube, norm_mask, norm_type );
            
            % Data compilation
            
            data4roc = [ data4roc; norm_data ];
            
            % Masks
            
            pixels_per_model0 = zeros(size(norm_data,1),2);
            
            %
            
            all_folders = dir([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep '*']);
            all_folders_names = string([]); for fi = 3:size(all_folders,1); all_folders_names(fi-2) = all_folders(fi).name; end
            
            [ common1, all_folders_names_i1, ~ ] = intersect(all_folders_names,group0);
            
            if ~isempty(common1)
                
                for aux_i = all_folders_names_i1'
                    
                    load([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep char(all_folders_names(aux_i)) filesep 'roi' ])
                    
                    model_mask = reshape(roi.pixelSelection',[],1);
                    pixels_per_model0(:,1) = pixels_per_model0(:,1) + model_mask;
                    
                end
                
            end
            
            [ common2, all_folders_names_i2, ~ ] = intersect(all_folders_names,group1);
            
            if ~isempty(common2)
                
                for aux_i = all_folders_names_i2'
                    
                    load([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep char(all_folders_names(aux_i)) filesep 'roi' ])
                    
                    model_mask = reshape(roi.pixelSelection',[],1);
                    pixels_per_model0(:,2) = pixels_per_model0(:,2) + model_mask;
                    
                end
                
            end
            
            pixels_per_model = [ pixels_per_model; pixels_per_model0 ];
                        
        end
                
        load([ peak_assignments_path filesToProcess(1).name(1,1:end-6) '\' char(main_mask) '\hmdb_sample_info' ])
        load([ peak_assignments_path filesToProcess(1).name(1,1:end-6) '\' char(main_mask) '\relevant_lists_sample_info' ])
        
        new_hmdb_sample_info = f_saving_curated_hmdb_info( hmdb_sample_info, relevant_lists_sample_info );
        
        %%% ROC curves
        
        roc_analysis_table = [ "AUC", "meas mz", "molecule", "mono mz", "adduct", "ppm", "database" ];
        
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
                
                indexes2add = (abs(datacube.spectralChannels(mzi)-double(new_hmdb_sample_info(:,3))) < 0.0000001);
                
                roc_analysis_table = [
                    roc_analysis_table
                    [ string(repmat([ AUC, datacube.spectralChannels(mzi)],sum(indexes2add),1)) new_hmdb_sample_info(indexes2add,[1:2 4:end]) ]
                    ];
                
            end
        end
        
        mkdir([ roc_path char(dataset_name) '\' char(main_mask) '\whole tissue roc analysis\' char(norm_type) ])
        cd([ roc_path char(dataset_name) '\' char(main_mask) '\whole tissue roc analysis\' char(norm_type) ])
        
        save([ 'roc_analysis_' char(strjoin([ group1_name ' vs ' group0_name])) '.mat'],'roc_analysis_table' )
        
        txt_row = strcat(repmat('%s\t',1,size(roc_analysis_table,2)-1),'%s\n');
        
        fileID = fopen([ 'roc_analysis_' char(strjoin([ group1_name ' vs ' group0_name])) '.txt' ],'w');
        fprintf(fileID,txt_row, roc_analysis_table');
        fclose(fileID);
        
    end
end