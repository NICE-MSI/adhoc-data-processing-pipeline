function [ extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs ] = f_testStudy_samples_scheme_info(dataset_name)

% This function is used to define "new" datasets which are built by
% combining multiple imzmls and using small masks.
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
    
    case "4 parts brain"
        
        main_mask_list = "tissue only"; % the main mask i.e. that used to create the representative spectrum that was peak picked
        data_folders = { 'X:\ModelAndReferenceData\' }; % path to the folder with the data
        dataset_name = '*SagittalMouseCerebellum*'; % string to search for when collecting the imzmls in the folder above
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} filesep dataset_name '.imzML']) ]; end
        
        clear extensive_filesToProcess
        
        extensive_filesToProcess(1:4,:) = filesToProcess(1); % creating an extensive struct with all imzml file names (it has to be an imzml file per small mask)
        smaller_masks_list = [ "top-left-brain"; "top-right-brain"; "2-parts-botom-brain"; "random-shape" ]; % listing the small masks
        
        outputs_xy_pairs = [ 1 2; 1 2; 2 1; 2 2 ]; % list of x and y coordinates that will be used to plot the small masks in a grid (x is horizontal, y is vertical)
        
end