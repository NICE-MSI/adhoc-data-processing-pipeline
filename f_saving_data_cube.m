function f_saving_data_cube( filesToProcess, mask_list )

for file_index = 1:length(filesToProcess)
    
    csv_inputs = [ filesToProcess(file_index).folder '\inputs_file' ];
    
    [ ~, ~, ~, ~, numPeaks4mva_array, perc4mva_array, ~, ~, ~, ~, ~, ~, ~, ppmTolerance, ~, outputs_path ] = f_reading_inputs(csv_inputs);
    
    spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
    peak_assignments_path   = [ char(outputs_path) '\peak assignments\' ];
    
    for mask_type = mask_list
        
        % Loading relevant molecules peak details
                
        load([ peak_assignments_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\relevant_lists_sample_info.mat' ])
        load([ peak_assignments_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\relevant_lists_sample_info_aux.mat' ])
        
        % Loading tissue only peak details
        
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\peakDetails.mat' ])
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\totalSpectrum_mzvalues.mat' ])
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\totalSpectrum_intensities.mat' ])
        
        % Peaks
        
        datacubeonly_peakDetails = f_peakdetails4datacube( relevant_lists_sample_info, ppmTolerance, numPeaks4mva_array, perc4mva_array, peakDetails, totalSpectrum_mzvalues, totalSpectrum_intensities );
        
        %%% Generating the data cube
        
        % Data loading (SpectralAnalysis functions)
        
        parser = ImzMLParser([filesToProcess(file_index).folder '\' filesToProcess(file_index).name]);
        parser.parse;
        data = DataOnDisk(parser);
        
        reduction = DatacubeReductionAutomated('integrate over peak', 'New Window');
        reduction.setPeakList(datacubeonly_peakDetails(:,2));
        reduction.setPeakDetails(datacubeonly_peakDetails);
        reduction.setIntegrateOverPeak;
        
        datacube = reduction.process(data);
        
        cd([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(mask_type) '\'])
        save('datacubeonly_peakDetails','datacubeonly_peakDetails','-v7.3')
        save('datacube','datacube','-v7.3')
        
        width = datacube.width;
        height = datacube.height;
        
        save('width','width','-v7.3')
        save('height','height','-v7.3')
        
    end
    
end