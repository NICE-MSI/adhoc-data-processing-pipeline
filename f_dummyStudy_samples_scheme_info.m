function [ extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs ] = f_dummyStudy_samples_scheme_info(dataset_name)

% This function is used to define a "new" dataset which is built by
% combined multiple imzmls and using "small" masks.
%
% Inputs:
% dataset_name - name of the "new" (combined) dataset
%
% Outputs:
% extensive_filesToProcess - A matlab struct that has the name and path to
% all the imzmls required.
% smaller_masks_list - A list of all the small masks that need to be used.
% outputs_xy_pairs - A list of x and y coordinates that is to be used to
% arrange the small masks in a 2D grid for plotting.
%
% The number of rows of extensive_filesToProcess, smaller_masks_list, and
% outputs_xy_pairs is the same.

switch dataset_name
    
    case "4 random parts of a brain"
        
        main_mask_list = "tissue only";
        data_folders = { 'X:\Teresa\dummy study\neg data\' }; % data folder
        dataset_name = '*SagittalMouseCerebellum*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        clear extensive_filesToProcess
        
        extensive_filesToProcess(1:4,:) = filesToProcess(1);
        smaller_masks_list = [
            "tissue only";  "background"; 
            "top";          "top 1 part 2 fill"
            ];
        
        outputs_xy_pairs = [ 
            1 1; 1 2; 
            2 1; 2 2 
            ];
        
end