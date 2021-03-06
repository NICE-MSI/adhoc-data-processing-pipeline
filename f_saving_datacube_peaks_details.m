function f_saving_datacube_peaks_details( filesToProcess, mask_list )

% Saves information for all peaks of interest i.e. those required for at 
% least one the following steps of the data processing (e.g. univariate and
% multivariate analyses, single ion images).
% 
% Inputs:
% filesToProcess (string, struct) - Matlab struct created by the Matlab 
% function dir, containing the list of files to process and their paths
% mask_list (string, 1D array) - names of masks to be used (sequentially) 
% to reduce data to a particular group of pixels
%
% Note: 
% The masks in mask_list can be �no mask� (all pixels are used), or names 
% of folders saved in the outputs folder �rois� (other masks created as 
% part of the pipeline)
% 
% Outputs:
% datacubeonly_peakDetails (double, 2D array) - a curated peakDetails that 
% contains all required peaks - it determines which peaks are saved in the 
% datacube and in the data tables within the normalisation specific
% folders, and therefore which peaks are available for any following data 
% processing step


for file_index = 1:length(filesToProcess) % iterating through the imzmls
    
    for mask_type = mask_list % iterating through the main masks
        
        % Reading relevant information from "inputs_file.xlsx"
        
        csv_inputs = [ filesToProcess(file_index).folder '\inputs_file' ];
        [ ~, ~, ~, ~, amplratio4mva_array, numPeaks4mva_array, perc4mva_array, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);
        
        % Defining paths to spectral details and peak assigments folders
        
        spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
        peak_assignments_path   = [ char(outputs_path) '\peak assignments\' ];
        
        % Loading assigments information (to HMDB and lists of molecules of interest) information
        
        load([ peak_assignments_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\hmdb_sample_info.mat' ])
        load([ peak_assignments_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\relevant_lists_sample_info.mat' ])
        
        % Loading peak details
        
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\peakDetails.mat' ])
                
        % Loading total spectrum information
        
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\totalSpectrum_intensities.mat' ])
                
        disp('! Defining mz values that have to be saved in each data cube...')
        
        molecules_classes_specification_path = [ filesToProcess(file_index).folder '\molecules_classes_specification' ];
        
        % Searching for peaks of interest
        
        datacubeonly_peakDetails = f_peakdetails4datacube( relevant_lists_sample_info, amplratio4mva_array, numPeaks4mva_array, perc4mva_array, molecules_classes_specification_path, hmdb_sample_info, peakDetails, totalSpectrum_intensities );
        
        % Saving details for peaks of interest
        
        cd([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\'])
        save('datacubeonly_peakDetails','datacubeonly_peakDetails','-v7.3')
        
        disp('! Data cube specific peak details saved.')
        
    end
    
end