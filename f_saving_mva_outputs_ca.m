function f_saving_mva_outputs_ca( filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs, dataset_name, norm_list, mva_molecules_list0, mva_classes_list0, mzvalues2discard )

if nargin <= 8; mzvalues2discard = []; end

% Sorting the filesToProcess and smaller_masks_list to avoid the need to 
% load the data unnecessary times.

file_names = []; for i = 1:size(filesToProcess,1); file_names = [ file_names; string(filesToProcess(i).name) ]; end
[~, files_indicies] = sort(file_names);
filesToProcess = filesToProcess(files_indicies);
smaller_masks_list = smaller_masks_list(files_indicies);

%

for main_mask = main_mask_list
    
    % Creating the cells that will comprise the information regarding the
    % single ion images, the main mask, and the smaller mask.
    % Main mask - Mask used at the preprocessing step (usually tissue only).
    % Small mask - Mask used to plot the results in the shape of a grid
    % defined by the user (it can be a reference to a particular piece of
    % tissue or a set of tissues).
    
    datacube_cell = {};
    main_mask_cell = {};
    smaller_masks_cell = {};
    
    % Loading peak details information
    
    csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];
    
    [ ~, ~, ~, ...
        mva_list, ...
        amplratio4mva_array, numPeaks4mva_array, perc4mva_array, ...
        numComponents_array, numLoadings_array, ...
        ~, ...
        mva_molecules_list, ppmTolerance, ...
        ~, ~, ...
        pa_max_ppm, fig_ppmTolerance, outputs_path ] = f_reading_inputs(csv_inputs);
    
    if isnan(ppmTolerance); ppmTolerance = pa_max_ppm; end
    
    if isempty(mva_molecules_list0)
        mva_mzvalues_vector = [];
    elseif isstring(mva_molecules_list0)
        mva_molecules_list = mva_molecules_list0;
        mva_mzvalues_vector = [];
        numPeaks4mva_array = [];
        perc4mva_array = [];
    elseif isvector(mva_molecules_list0)
        mva_mzvalues_vector = mva_molecules_list0;
        mva_molecules_list = [];
        numPeaks4mva_array = [];
        perc4mva_array = [];
    end
    
    mva_classes_list = mva_classes_list0;
    
    if ~isempty(mva_classes_list0)
        numPeaks4mva_array = [];
        perc4mva_array = [];
    end
        
    % Defining all paths needed
    
    rois_path               = [ char(outputs_path) '\rois\' ];
    spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
    peak_assignments_path   = [ char(outputs_path) '\peak assignments\' ];
    
    for file_index = 1:length(filesToProcess)
        
        % Loading information about the peaks, the mz values saved as a
        % dacube cube and the matching of the dataset with a set of lists
        % of relevant molecules
        
        if file_index == 1
            
            load([ spectra_details_path     filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\peakDetails' ])
            load([ peak_assignments_path    filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\hmdb_sample_info' ])
            load([ peak_assignments_path    filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\relevant_lists_sample_info' ])
            load([ spectra_details_path     filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\datacubeonly_peakDetails' ])
            
        end
        
        % Loading datacubes
        
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\datacube' ])
        
        datacube_cell{file_index} = datacube;
        
        % Loading main mask information
        
        if ~strcmpi(main_mask,"no mask")
            load([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep char(main_mask) filesep 'roi'])
            main_mask_cell{file_index} = reshape(roi.pixelSelection',[],1);
        else
            main_mask_cell{file_index} = true(ones(size(datacube,1),1));
        end
        
        % Loading smaller masks information
        
        load([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep char(smaller_masks_list(file_index)) filesep 'roi'])
        smaller_masks_cell{file_index} = logical(reshape(roi.pixelSelection',[],1));
        
    end
    
    % Mean spectrum for figures
    
    filesToProcess0 = f_unique_extensive_filesToProcess(filesToProcess);
    
    y = 0;
    pixels_num0 = 0;
    
    for file_index = 1:length(filesToProcess0)
        
        % Loading spectral information
        
        if ( file_index == 1 ); load([ spectra_details_path filesToProcess0(file_index).name(1,1:end-6) filesep char(main_mask) filesep 'totalSpectrum_mzvalues' ]); end
        
        load([ spectra_details_path filesToProcess0(file_index).name(1,1:end-6) filesep char(main_mask) filesep 'totalSpectrum_intensities' ])
        load([ spectra_details_path filesToProcess0(file_index).name(1,1:end-6) filesep char(main_mask) filesep 'pixels_num' ])
        
        y = y + totalSpectrum_intensities;
        pixels_num0 = pixels_num0 + pixels_num;
        
    end
    
    meanSpectrum_intensities = y./pixels_num0;
    meanSpectrum_mzvalues = totalSpectrum_mzvalues;
    
    %
    
    mvai = 0;
    for mva_type = mva_list
        mvai = mvai + 1;
        
        for norm_type = norm_list
            
            numComponents = numComponents_array(mvai);
            numLoadings = numLoadings_array(mvai);
            
            norm_data_cell = {};
            
            for file_index = 1:length(datacube_cell)
                
                if (file_index==1) || (~strcmpi(filesToProcess(file_index-1).name(1,1:end-6),filesToProcess(file_index).name(1,1:end-6)))
                    
                    % normalisation
                    
                    norm_data = f_norm_datacube( datacube_cell{file_index}, norm_type );
                    
                end
                
                norm_data_cell{file_index} = norm_data;
                
            end
            
            % Different peak lists
            
            % Vector of mz values
            
            if ~isempty(mva_mzvalues_vector)
                
                mva_path = [ char(outputs_path) '\mva ' char(num2str(length(mva_mzvalues_vector))) ' adhoc mz values\' ];
                
                if ~isempty(mzvalues2discard)
                    mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' black peaks removed)\' ];
                end
                
                f_saving_mva_auxiliar_ca( mva_type, mva_path, dataset_name, main_mask, norm_type, norm_data_cell, numComponents, numLoadings, datacube_cell, outputs_xy_pairs, spectra_details_path, datacubeonly_peakDetails, hmdb_sample_info, relevant_lists_sample_info, filesToProcess, smaller_masks_list, smaller_masks_cell, meanSpectrum_intensities, meanSpectrum_mzvalues, fig_ppmTolerance )
                
            end
            
            % Lists
            
            for molecules_list = mva_molecules_list
                
                mva_path = [ char(outputs_path) '\mva ' char(molecules_list) '\' ];
                
                if ~isempty(mzvalues2discard)
                    mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' black peaks removed)\' ];
                end
                
                f_saving_mva_auxiliar_ca( mva_type, mva_path, dataset_name, main_mask, norm_type, norm_data_cell, numComponents, numLoadings, datacube_cell, outputs_xy_pairs, spectra_details_path, datacubeonly_peakDetails, hmdb_sample_info, relevant_lists_sample_info, filesToProcess, smaller_masks_list, smaller_masks_cell, meanSpectrum_intensities, meanSpectrum_mzvalues, fig_ppmTolerance )
                
            end
            
            % Highest peaks
            
            % Number
            
            for numPeaks4mva = numPeaks4mva_array
                
                mva_path = [ char(outputs_path) '\mva ' char(num2str(numPeaks4mva)) ' highest peaks\' ];
                
                if ~isempty(mzvalues2discard)
                    mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' black peaks removed)\' ];
                end
                
                f_saving_mva_auxiliar_ca( mva_type, mva_path, dataset_name, main_mask, norm_type, norm_data_cell, numComponents, numLoadings, datacube_cell, outputs_xy_pairs, spectra_details_path, datacubeonly_peakDetails, hmdb_sample_info, relevant_lists_sample_info, filesToProcess, smaller_masks_list, smaller_masks_cell, meanSpectrum_intensities, meanSpectrum_mzvalues, fig_ppmTolerance )
                
            end
            
            % Percentile
            
            for perc4mva = perc4mva_array
                
                mva_path = [ char(outputs_path) '\mva percentile ' char(num2str(perc4mva)) ' peaks\' ];
                
                if ~isempty(mzvalues2discard)
                    mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' black peaks removed)\' ];
                end
                
                f_saving_mva_auxiliar_ca( mva_type, mva_path, dataset_name, main_mask, norm_type, norm_data_cell, numComponents, numLoadings, datacube_cell, outputs_xy_pairs, spectra_details_path, datacubeonly_peakDetails, hmdb_sample_info, relevant_lists_sample_info, filesToProcess, smaller_masks_list, smaller_masks_cell, meanSpectrum_intensities, meanSpectrum_mzvalues, fig_ppmTolerance )
                
            end
            
            % Highest peaks after a thresholding step based on the ratio between the two amplitudes of each peak
            
            for amplratio4mva = amplratio4mva_array
                
                % Number
                
                for numPeaks4mva = numPeaks4mva_array
                    
                    mva_path = [ char(outputs_path) '\mva ' char(num2str(numPeaks4mva)) ' highest peaks + ' char(num2str(amplratio4mva)) ' ampls ratio\' ];
                    
                    if ~isempty(mzvalues2discard)
                        mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' black peaks removed)\' ];
                    end
                    
                    f_saving_mva_auxiliar_ca( mva_type, mva_path, dataset_name, main_mask, norm_type, norm_data_cell, numComponents, numLoadings, datacube_cell, outputs_xy_pairs, spectra_details_path, datacubeonly_peakDetails, hmdb_sample_info, relevant_lists_sample_info, filesToProcess, smaller_masks_list, smaller_masks_cell, meanSpectrum_intensities, meanSpectrum_mzvalues, fig_ppmTolerance )
                    
                end
                
                % Percentile
                
                for perc4mva = perc4mva_array
                    
                    mva_path = [ char(outputs_path) '\mva percentile ' char(num2str(perc4mva)) ' peaks + ' char(num2str(amplratio4mva)) ' ampls ratio\' ];
                    
                    if ~isempty(mzvalues2discard)
                        mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' black peaks removed)\' ];
                    end
                    
                    f_saving_mva_auxiliar_ca( mva_type, mva_path, dataset_name, main_mask, norm_type, norm_data_cell, numComponents, numLoadings, datacube_cell, outputs_xy_pairs, spectra_details_path, datacubeonly_peakDetails, hmdb_sample_info, relevant_lists_sample_info, filesToProcess, smaller_masks_list, smaller_masks_cell, meanSpectrum_intensities, meanSpectrum_mzvalues, fig_ppmTolerance )
                    
                end
                
            end
            
            % Classes of molecules
            
            if ~isempty(mva_classes_list)
                
                molecules_classes_specification_path = [ filesToProcess(1).folder '\molecules_classes_specification' ];
                
                [ ~, ~, classes_info ] = xlsread(molecules_classes_specification_path);
                
            end
            
            %
            
            for classes_list = mva_classes_list
                
                for classi = 2:size(classes_info,1)
                    
                    if strcmpi(classes_list,classes_info{classi,1})==1
                        
                        mva_path = [ char(outputs_path) '\mva ' char(classes_info{classi,1}) '\' ];
                        
                        if ~isempty(mzvalues2discard)
                            mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' black peaks removed)\' ];
                        end
                        
                        f_saving_mva_auxiliar_ca( mva_type, mva_path, dataset_name, main_mask, norm_type, norm_data_cell, numComponents, numLoadings, datacube_cell, outputs_xy_pairs, spectra_details_path, datacubeonly_peakDetails, hmdb_sample_info, relevant_lists_sample_info, filesToProcess, smaller_masks_list, smaller_masks_cell, meanSpectrum_intensities, meanSpectrum_mzvalues, fig_ppmTolerance )
                        
                    end
                    
                end
                
            end
            
            if strcmpi( mva_classes_list, "all" )
                
                for classi = 2:size(classes_info,1)
                    
                    mva_path = [ char(outputs_path) '\mva ' char(classes_info{classi,1}) '\' ]; if ~exist(mva_path, 'dir'); mkdir(mva_path); end
                    
                    if ~isempty(mzvalues2discard)
                        mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' black peaks removed)\' ];
                    end
                    
                    f_saving_mva_auxiliar_ca( mva_type, mva_path, dataset_name, main_mask, norm_type, norm_data_cell, numComponents, numLoadings, datacube_cell, outputs_xy_pairs, spectra_details_path, datacubeonly_peakDetails, hmdb_sample_info, relevant_lists_sample_info, filesToProcess, smaller_masks_list, smaller_masks_cell, meanSpectrum_intensities, meanSpectrum_mzvalues, fig_ppmTolerance )
                    
                end
                
            end
            
        end
    end
    
end
