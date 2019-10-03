function [ extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs ] = f_matrix_coating_studies_scheme_info( dataset_name, background, check_datacubes_size)

switch dataset_name
    
    case "study 6"
        
        data_folders = { 'X:\BinYan\matrix coating studies\pos plasma api maldi imzmls and ibds\30k\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % tissue only
            
            main_mask_list = "no mask";
            
            extensive_filesToProcess(1,:) = filesToProcess(1,:);
            smaller_masks_list = "Sandwich";
            extensive_filesToProcess(2,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "Top" ];
            extensive_filesToProcess(3,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "Bottom" ];
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(1,:);
            smaller_masks_list = "Sandwich";
            extensive_filesToProcess(2,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "Top" ];
            extensive_filesToProcess(3,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "Bottom" ];
            
        end
        
        outputs_xy_pairs = [
            1 1; 
            2 1; 
            3 1;
            ];
        
end

if check_datacubes_size==1
    
    for file_index = 1:length(filesToProcess)
        
        csv_inputs = [ filesToProcess(file_index).folder '\inputs_file' ];
        
        [ ~, ~, ~, ...
            ~, ~, ...
            ~, ~, ...
            ~, ~, ~, ...
            ~, ~, ~, ...
            ~, ...
            outputs_path ] = f_reading_inputs(csv_inputs);
        
        spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
        
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask_list) '\datacubeonly_peakDetails' ])
        
        if file_index
            
            old_datacubeonly_peakDetails = datacubeonly_peakDetails;
            
            disp(filesToProcess(file_index).name(1,1:end-6))
            
        elseif isequal(old_datacubeonly_peakDetails, datacubeonly_peakDetails)
            
            disp(filesToProcess(file_index).name(1,1:end-6))
            
            disp('!!! ISSUE !!! Datasets do NOT have a compatible mz axis. Please check and make sure that all datasets to be combined have a commom list of peaks and matches.')
            
        end
        
    end
    
end