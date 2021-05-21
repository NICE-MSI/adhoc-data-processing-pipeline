function f_check_datacubes_mass_axis(extensive_filesToProcess, check_datacubes_size, main_mask_list)

% This function checks if the datacubes that need to be combined (those specified in extensive_filesToProcess) have the same mass axis.
% 
% Input:
% extensive_filesToProcess - struct with the names and folders of all the
% imzmls that need to be combined
% 
% Output:
% An "issue" message printed in the command line when the group of peaks 
% saved in the datacubes to be combined is NOT consistent across files.

% Reducing the complete (extensive) list of files that need to have common 
% axis to a list of unique files.

filesToProcess = f_unique_extensive_filesToProcess(extensive_filesToProcess);

if check_datacubes_size==1
    
    % Iterating over files
    
    for file_index = 1:length(filesToProcess)
        
        % Printing the name of the file being loaded
        
        disp(filesToProcess(file_index).name(1,1:end-6))
        
        % Defining the required paths
        
        csv_inputs = [ filesToProcess(file_index).folder '\inputs_file' ];
        
        [ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);
        
        spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
        
        % Loading details for all peaks saved in the data cube
        
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask_list) '\datacubeonly_peakDetails' ])
        
        if file_index==1
            
            old_datacubeonly_peakDetails = datacubeonly_peakDetails;
            
        elseif ~isequal(old_datacubeonly_peakDetails, datacubeonly_peakDetails) % comparing the list of peaks saved in the first file with that saved in all the remaining files
            
            disp('!!! ISSUE !!! These datasets do NOT have a consistent mass axis (group of peaks). Please run the pre-processing and data saving steps again.')
            
        end
        
    end
    
end