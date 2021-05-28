function f_saving_peaks_details_ca( filesToProcess, mask_list )

% Performs peak detection in the composite total spectrum and saved details 
% for all peaks found. The composite total spectrum is computed by adding 
% the total spectra of all the files in filesToProcess.
%
% Inputs:
% filesToProcess - Matlab structure created by matlab function dir, 
% containing the list of files to process and their locations / paths
% mask_list - array with names of masks to be used (sequentially) to reduce 
% data to a particular group of pixels
%
% Note: 
% The masks in mask_list can be “no mask” (all pixels of the imzml file are
% used), or names of folders saved in the outputs folder “rois” (created as
% part of the pipeline)
% 
% Outputs:
% peakDetails - matlab variable with the start, centroid and end of each 
% peak in terms of m/z values, and amplitude at the centroid of the peak


for mask_type = mask_list
    
    disp('! Loading and adding all total spectra...')
    
    y = 0;
    
    for file_index = 1:length(filesToProcess) % iterating through imzmls
        
        csv_inputs = [ filesToProcess(file_index).folder '\inputs_file' ];
        
        [ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);
        
        spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
        
        cd([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\'])
        
        if file_index == length(filesToProcess); load('totalSpectrum_mzvalues'); end
        
        load('totalSpectrum_intensities')
        
        y = y + totalSpectrum_intensities;
        
    end
    
    disp('! Running peak picking on total spectum...')
    
    addJARsToClassPath()
    
    % Detecting peaks in the composite total spectrum using the Gradient algorithm
    
    peakPicking = GradientPeakDetection();
    
    peaks = peakPicking.process(SpectralData(totalSpectrum_mzvalues, y)); % peak pick total spectrum
    
    peakDetails = [ [ peaks.minSpectralChannel ]', [ peaks.centroid ]', [ peaks.maxSpectralChannel ]', [ peaks.intensity ]' ];
    
    % Saving the unique peak details mat file
    
    for file_index = 1:length(filesToProcess)
        
        csv_inputs = [ filesToProcess(file_index).folder '\inputs_file' ];
        
        [ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);
        
        spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
        
        cd([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\'])
        
        save('peakDetails','peakDetails','-v7.3')
        
        disp('! Peak details saved.')
        
    end
    
end


