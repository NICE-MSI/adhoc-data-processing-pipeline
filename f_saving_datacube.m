function f_saving_datacube( filesToProcess, mask_list )

% Creates images for all peaks of interest i.e. that will be required in 
% any of the following steps of the data processing (e.g. univariate and/or 
% multivariate analyses, single ion images).
% The image of each peak is created by integrating all m/z between its 
% start and end, both estimated with the gradient method and stored in the 
% peakDetails variable.
% 
% Inputs:
% filesToProcess (struct) - Matlab structure created by Matlab 
% function dir, containing the list of files to process and their paths
% mask_list (string, 1D array) - names of the main masks to be used 
% (sequentially) to reduce data to a particular group of pixels
%
% Note: 
% The masks in mask_list can be “no mask” (all pixels are used), or names 
% of folders saved in the outputs folder “rois” (created as part of the 
% pipeline)
% 
% Outputs:
% datacube (struct) – Spectral Analysis dataRepresentation type of variable
% width (double) - width of the image
% height (double) - height of the image
% pixels_coord (double, 2D array) - coordenates of pixels in the image
%
% Note: The data in the datacube struct is not masked by the binary mask in
% "mask_type".

for mask_type = mask_list % iterating through main masks
        
    for file_index = 1:length(filesToProcess) % iterating through imzmls

        % Read relevant information from "inputs_file.xlsx"
        
        csv_inputs = [ filesToProcess(file_index).folder '\inputs_file' ];
        [ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);
        
        % Define path to spectral details folder
        
        spectra_details_path    = [ char(outputs_path) '\spectra details\' ];

        disp('! Loading mz values that have to be saved in each data cube...')
        
        % Load details for peaks of interest
        
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\datacubeonly_peakDetails.mat' ])
        
        % Load total spectrum information
        
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\totalSpectrum_mzvalues.mat' ])
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\totalSpectrum_intensities.mat' ])
        
        % Generating the data cube
        
        disp(['! Generating data cube with ' num2str(size(datacubeonly_peakDetails,1)) ' peaks...'])
        
        % Load data (SpectralAnalysis functions)
        
        addJARsToClassPath()
        
        parser = ImzMLParser([filesToProcess(file_index).folder '\' filesToProcess(file_index).name]);
        parser.parse;
        data = DataOnDisk(parser);
        
        peakTolerance = -1; % for integration over the peak width as defined per the gradient method
        toleranceUnit = 'Spectrum Unit';
        keepOriginalPixels = 1;
        output = 'New Window';
        intensityDataType = 'Double';
        storageType = 'Processed';
        
        reduction = DatacubeReduction(peakTolerance, toleranceUnit, keepOriginalPixels, output, intensityDataType, storageType);
                
        peakList = [];

        originalSpectrum = SpectralData(totalSpectrum_mzvalues, totalSpectrum_intensities); % Continuous total spectrum
        
        for i = 1:size(datacubeonly_peakDetails,1) % iterating through peaks
            
            % Peak() arguments: spectralData, centroid, intensity, minSpectralChannel, maxSpectralChannel
            
            peak = Peak(originalSpectrum, datacubeonly_peakDetails(i, 2), datacubeonly_peakDetails(i, 4), datacubeonly_peakDetails(i,1), datacubeonly_peakDetails(i, 3));            
            
            % Create a vector of Peak instances
            
            if isempty(peakList)
                peakList = peak;
            else
                peakList(i) = peak;
            end
        end
        
        % Create datacube with peaks stored in peakList

        reduction.setPeakList(peakList);
        
        datacube = reduction.process(data);
        datacube = datacube.get(1);
        datacube = datacube.saveobj();
        
        % Save datacube
        
        cd([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\'])
        
        save('datacube.mat','datacube','-v7.3')
        
        disp('! Data cube has been saved.')
        
        % Save width, height and pixel coordinates
        
        width = datacube.width;
        height = datacube.height;
        pixels_coord = datacube.pixels;
        
        save('width','width','-v7.3')
        save('height','height','-v7.3')
        save('pixels_coord','pixels_coord','-v7.3')
        
        % Check if peaks saved in this datacube (file file_index) are the 
        % same as those saved in the datacube for file 1. This is an 
        % important check step if there is the aim to combine datacubes at 
        % a later stage of the process.
        
        if (file_index~=1); disp([ '!!! datacubeonly_peakDetails consistency: ' num2str(isequal(datacubeonly_peakDetails, datacubeonly_peakDetails1))]); end
        
        datacubeonly_peakDetails1 = datacubeonly_peakDetails;
        
        %
        
    end
    
end