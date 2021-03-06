function f_running_mva_ca( filesToProcess, main_mask_list, smaller_masks_list, dataset_name, norm_list, mva_molecules_list0, mva_classes_list0, mzvalues2discard )

% Runs the multivariate analyses specified in "inputs_file.xlsx", and it 
% saves their standard outputs (which differ from algorithm to algorithm).
% This is done using data from all imzmls specified in filesToProcess 
% (the common mass axis aproach). 
%
% Notes: 
% 
% Each MVA can be run using one of the following groups of peaks:
% - the top N peaks (in terms of total intensity)
% - the top percentil P (in terms of total intensity)
% - those beloging to one of the lists of molecules of interest
% 
% This set of peaks can be further curated using the results of an ANOVA, 
% which can be used to define a particular set of peaks to discarded.
%
% If mva_molecules_list0 or mva_classes_list0 are not empty, 
% the top peaks (specified in "inputs_file.xlsx") are not used.
%
% Inputs:
% filesToProcess - Matlab structure created by matlab function dir,
% containing the list of files to process and their locations / paths
% main_mask_list - array with names of masks to be used (sequentially) to 
% reduce data to a particular group of pixels
% smaller_masks_list (string, 1D array) - names of the small masks that are
% to be combined with the imzmls in filesToProcess
% dataset_name (string) - name od the composite dataset 
% norm_list - list of strings specifying the normalisations of interest,
% which can be one or more of the following options: "no norm", "tic", "RMS",
% "pqn mean", "pqn median", "zscore"
% mva_molecules_list0 - an array of strings listing the names of the lists
% of the molecules of interest, or an array of doubles specifying which m/z
% are to be included in the analysis
% mva_classes_list0 - an array with strings listing the classes of
% molecules of interest
% mzvalues2discard - an array of doubles (a Matlab vector) specifying which
% m/z are to be discarded from the analysis
%
% Outputs:
% pca - firstCoeffs, firstScores, explainedVariance
% nnmf - W, H
% ica - z, model
% kmeans - idx, C, optimal_numComponents
% tsne - rgbData, idx, cmap, loss, tsne_parameters
% nntsne - rgbData, idx, cmap, outputSpectralContriubtion  
%
% See the help of each function for details on its outputs. With the
% exception of nntsne, Matlab functions are called.

if nargin <= 5; mva_molecules_list0 = []; end
if nargin <= 6; mva_classes_list0 = []; end
if nargin <= 7; mzvalues2discard = []; end

% Sorting filesToProcess and re-organising related small masks and grid
% coordinates information to avoid loading data unnecessary times

file_names = []; for i = 1:size(filesToProcess,1); file_names = [ file_names; string(filesToProcess(i).name) ]; end
[~, files_indicies] = sort(file_names);
filesToProcess = filesToProcess(files_indicies);
smaller_masks_list = smaller_masks_list(files_indicies);

for main_mask = main_mask_list % iterating through the main masks
       
    csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];
    
    [ ~, ~, ~, ...
        mva_list, ...
        amplratio4mva_array, numPeaks4mva_array, perc4mva_array, ...
        numComponents_array, ...
        ~, ~, ...
        mva_molecules_list, ~, ...
        ~, ~, ...
        pa_max_ppm, ...
        ~, ...
        outputs_path ] = f_reading_inputs(csv_inputs);
        
    % If mva_molecules_list0 or mva_classes_list0 are not empty, the top peaks (specified in "inputs_file.xlsx") are not used.

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
    
    % Adding total spectra to create the dataset representative spectrum
    
    filesToProcess0 = f_unique_extensive_filesToProcess(filesToProcess); % This function collects all files that need to have a common axis.
    
    y = 0;
    
    for file_index0 = 1:length(filesToProcess0) % iterating through imzmls
        
        % Loading total spectrum
        
        load([ spectra_details_path filesToProcess0(file_index0).name(1,1:end-6) '\' char(main_mask) '\totalSpectrum_intensities' ])
        
        y = y + totalSpectrum_intensities;
        
    end
    
    % Masks
    
    smaller_masks_cell = {};
    
    for file_index = 1:length(filesToProcess)
        
        % Loading information about the peak features (start, maximum, centroid masses) and 
        % assignments (to relevant lists and HMDB)
        
        if file_index == 1 % peak features and assignments are the same for all imzmls so they have to be loaded only once
            
            load([ spectra_details_path     filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\peakDetails' ])
            load([ spectra_details_path     filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\datacubeonly_peakDetails' ])
            
            load([ peak_assignments_path    filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\relevant_lists_sample_info' ])
            load([ peak_assignments_path    filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\hmdb_sample_info' ])
            
        end
        
        % Loading and storing smaller masks information in a cell
        
        load([ rois_path filesToProcess(file_index).name(1,1:end-6) filesep char(smaller_masks_list(file_index)) filesep 'roi'])
        smaller_masks_cell{file_index} = logical(reshape(roi.pixelSelection',[],1));
        
    end
    
    for norm_type = norm_list % iterating through the normalisations
        
        assembled_norm_data = [];
        assembled_mask = [];
        
        % Loading normalised data
        
        for file_index = 1:length(smaller_masks_cell)
            
            % Load data only if the name of the file changes.
            % filesToProcess need to be sorted for this to work properly.
            
            if file_index == 1 || ~strcmpi(filesToProcess(file_index).name(1,1:end-6),filesToProcess(file_index-1).name(1,1:end-6))
                
                disp(['! Loading ' filesToProcess(file_index).name(1,1:end-6) ' data...'])
                
                load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\' char(norm_type) '\data.mat' ])
                
            end
            
            % Collecting the data for all imzmls (vertical concatenation)
            
            assembled_norm_data = [ assembled_norm_data; data(smaller_masks_cell{file_index},:) ];
            assembled_mask = [ assembled_mask; smaller_masks_cell{file_index} ];
            
        end
        
        % Storing the indicies of the pixels that are not 0
        
        assembled_indicies = find(assembled_mask);
        
        %
        
        mvai = 0;
        for mva_type = mva_list % iterating through MVAs
            mvai = mvai+1;
            
            numComponents = numComponents_array(mvai);
            
            % Different peak lists
            
            % Using a particular list of m/z
            
            if ~isempty(mva_mzvalues_vector)
                
                mva_path = [ char(outputs_path) '\mva ' char(num2str(length(mva_mzvalues_vector))) ' adhoc mz values\' ];
                
                % Findind the required indicies of the datacube
                
                datacube_mzvalues_indexes = f_datacube_mzvalues_vector( mva_mzvalues_vector, datacubeonly_peakDetails );
                
                % Removing a particular list of m/z
                
                if ~isempty(mzvalues2discard)
                    mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' peaks discarded)\' ];
                    datacube_mzvalues_indexes = f_black_peaks_list_removal( mzvalues2discard, datacubeonly_peakDetails, datacube_mzvalues_indexes );
                end
                
                % Defining mask and data for MVA
                
                sumlog = zeros(size(assembled_mask,1),1);
                sumlog0 = logical(sum(assembled_norm_data(:,datacube_mzvalues_indexes),2)>0);
                sumlog(assembled_indicies,1) = sumlog0;
                
                mask4mva = logical(assembled_mask.*sumlog);
                data4mva = assembled_norm_data(sumlog0,datacube_mzvalues_indexes);
                
                % Creating a new folder 
                
                if ~exist(mva_path, 'dir'); mkdir(mva_path); end
                
                % Running and saving MVA outputs
                
                f_running_mva_auxiliar( mva_type, mva_path, dataset_name, main_mask, norm_type, data4mva, mask4mva, numComponents, datacube_mzvalues_indexes )
                
            end
            
            % Using a particular lists of m/z
            
            for molecules_list = mva_molecules_list % iterating through the lists
                
                mva_path = [ char(outputs_path) '\mva ' char(molecules_list) '\' ];
                
                % Findind the required indicies of the datacube
                
                datacube_mzvalues_indexes = f_datacube_mzvalues_lists( molecules_list, pa_max_ppm, relevant_lists_sample_info, datacubeonly_peakDetails );
                
                % Removing a particular list of m/z
                
                if ~isempty(mzvalues2discard)
                    mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' peaks discarded)\' ];
                    datacube_mzvalues_indexes = f_black_peaks_list_removal( mzvalues2discard, datacubeonly_peakDetails, datacube_mzvalues_indexes );
                end
                
                % Defining mask and data for MVA
                
                sumlog = zeros(size(assembled_mask,1),1);
                sumlog0 = logical(sum(assembled_norm_data(:,datacube_mzvalues_indexes),2)>0);
                sumlog(assembled_indicies,1) = sumlog0;
                
                mask4mva = logical(assembled_mask.*sumlog);
                data4mva = assembled_norm_data(sumlog0,datacube_mzvalues_indexes);
                
                % Creating a new folder
                
                if ~exist(mva_path, 'dir'); mkdir(mva_path); end
                
                % Running and saving MVA outputs
                
                f_running_mva_auxiliar( mva_type, mva_path, dataset_name, main_mask, norm_type, data4mva, mask4mva, numComponents, datacube_mzvalues_indexes )
                
            end
            
            % Using the top N peaks
                        
            for numPeaks4mva = numPeaks4mva_array % iterating through the number of top peaks
                
                mva_path = [ char(outputs_path) '\mva ' char(num2str(numPeaks4mva)) ' highest peaks\' ];
                
                % Findind the required indicies of the datacube
                
                datacube_mzvalues_indexes = f_datacube_mzvalues_highest_peaks( numPeaks4mva, peakDetails, datacubeonly_peakDetails );
                
                % Removing a particular list of m/z
                
                if ~isempty(mzvalues2discard)
                    mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' peaks discarded)\' ];
                    datacube_mzvalues_indexes = f_black_peaks_list_removal( mzvalues2discard, datacubeonly_peakDetails, datacube_mzvalues_indexes );
                end
                
                % Defining mask and data for MVA
                
                sumlog = zeros(size(assembled_mask,1),1);
                sumlog0 = logical(sum(assembled_norm_data(:,datacube_mzvalues_indexes),2)>0);
                sumlog(assembled_indicies,1) = sumlog0;
                
                mask4mva = logical(assembled_mask.*sumlog);
                data4mva = assembled_norm_data(sumlog0,datacube_mzvalues_indexes);
                
                % Creating a new folder
                
                if ~exist(mva_path, 'dir'); mkdir(mva_path); end
                
                % Running and saving MVA outputs
                
                f_running_mva_auxiliar( mva_type, mva_path, dataset_name, main_mask, norm_type, data4mva, mask4mva, numComponents, datacube_mzvalues_indexes )
                
            end
            
            % Using the top percentile P peaks
            
            for perc4mva = perc4mva_array % iterating through the percentiles of top peaks
                
                mva_path = [ char(outputs_path) '\mva percentile ' char(num2str(perc4mva)) ' peaks\' ];
                
                % Findind the required indicies of the datacube
                
                datacube_mzvalues_indexes = f_datacube_mzvalues_highest_peaks_percentile( perc4mva, peakDetails, datacubeonly_peakDetails );
                
                % Removing a particular list of m/z
                
                if ~isempty(mzvalues2discard)
                    mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' peaks discarded)\' ];
                    datacube_mzvalues_indexes = f_black_peaks_list_removal( mzvalues2discard, datacubeonly_peakDetails, datacube_mzvalues_indexes );
                end
                
                % Defining mask and data for MVA
                
                sumlog = zeros(size(assembled_mask,1),1);
                sumlog0 = logical(sum(assembled_norm_data(:,datacube_mzvalues_indexes),2)>0);
                sumlog(assembled_indicies,1) = sumlog0;
                
                mask4mva = logical(assembled_mask.*sumlog);
                data4mva = assembled_norm_data(sumlog0,datacube_mzvalues_indexes);
                
                % Creating a new folder
                
                if ~exist(mva_path, 'dir'); mkdir(mva_path); end
                
                % Running and saving MVA outputs
                
                f_running_mva_auxiliar( mva_type, mva_path, dataset_name, main_mask, norm_type, data4mva, mask4mva, numComponents, datacube_mzvalues_indexes )
                
            end
            
            % Using peaks that survive a thresholding step based on the ratio between their two amplitudes
            
            for amplratio4mva = amplratio4mva_array % iterating through the ratios
                
                % Using the top N peaks
                
                for numPeaks4mva = numPeaks4mva_array % iterating through the numbers of peaks
                    
                    mva_path = [ char(outputs_path) '\mva ' char(num2str(numPeaks4mva)) ' highest peaks + ' char(num2str(amplratio4mva)) ' ampls ratio\' ];
                    
                    % Findind the required indicies of the datacube
                    
                    datacube_mzvalues_indexes = f_datacube_mzvalues_ampl_ratio_highest_peaks( amplratio4mva, numPeaks4mva, peakDetails, datacubeonly_peakDetails, y );
                    
                    % Removing a particular list of m/z
                    
                    if ~isempty(mzvalues2discard)
                        mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' peaks discarded)\' ];
                        datacube_mzvalues_indexes = f_black_peaks_list_removal( mzvalues2discard, datacubeonly_peakDetails, datacube_mzvalues_indexes );
                    end
                    
                    % Defining mask and data for MVA
                    
                    sumlog = zeros(size(assembled_mask,1),1);
                    sumlog0 = logical(sum(assembled_norm_data(:,datacube_mzvalues_indexes),2)>0);
                    sumlog(assembled_indicies,1) = sumlog0;
                    
                    mask4mva = logical(assembled_mask.*sumlog);
                    data4mva = assembled_norm_data(sumlog0,datacube_mzvalues_indexes);
                    
                    % Creating a new folder
                    
                    if ~exist(mva_path, 'dir'); mkdir(mva_path); end
                    
                    % Running and saving MVA outputs
                    
                    f_running_mva_auxiliar( mva_type, mva_path, dataset_name, main_mask, norm_type, data4mva, mask4mva, numComponents, datacube_mzvalues_indexes )
                    
                end
                
                % Using the top percentile P peaks
                
                for perc4mva = perc4mva_array
                    
                    mva_path = [ char(outputs_path) '\mva percentile ' char(num2str(perc4mva)) ' peaks + ' char(num2str(amplratio4mva)) ' ampls ratio\' ];
                    
                    % Findind the required indicies of the datacube
                    
                    datacube_mzvalues_indexes = f_datacube_mzvalues_ampl_ratio_highest_peaks_percentile( amplratio4mva, perc4mva, peakDetails, datacubeonly_peakDetails, y );
                    
                    % Removing a particular list of m/z
                    
                    if ~isempty(mzvalues2discard)
                        mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' peaks discarded)\' ];
                        datacube_mzvalues_indexes = f_black_peaks_list_removal( mzvalues2discard, datacubeonly_peakDetails, datacube_mzvalues_indexes );
                    end
                    
                    % Defining mask and data for MVA
                    
                    sumlog = zeros(size(assembled_mask,1),1);
                    sumlog0 = logical(sum(assembled_norm_data(:,datacube_mzvalues_indexes),2)>0);
                    sumlog(assembled_indicies,1) = sumlog0;
                    
                    mask4mva = logical(assembled_mask.*sumlog);
                    data4mva = assembled_norm_data(sumlog0,datacube_mzvalues_indexes);
                    
                    % Creating a new folder
                    
                    if ~exist(mva_path, 'dir'); mkdir(mva_path); end
                    
                    % Running and saving MVA outputs
                    
                    f_running_mva_auxiliar( mva_type, mva_path, dataset_name, main_mask, norm_type, data4mva, mask4mva, numComponents, datacube_mzvalues_indexes )
                    
                end
                
            end
            
            % Using classes of molecules
            
            if ~isempty(mva_classes_list)
                
                % Reading required classes
                
                molecules_classes_specification_path = [ filesToProcess(1).folder '\molecules_classes_specification' ];
                [ ~, ~, classes_info ] = xlsread(molecules_classes_specification_path);
                
            end
            
            %
            
            for classes_list = mva_classes_list 
                
                for classi = 2:size(classes_info,1) % iterating through the classes
                    
                    if strcmpi(classes_list,classes_info{classi,1})==1
                        
                        mva_path = [ char(outputs_path) '\mva ' char(classes_info{classi,1}) '\' ];
                        
                        % Findind the required indicies of the datacube
                        
                        datacube_mzvalues_indexes = f_datacube_mzvalues_classes( classes_info, classi, hmdb_sample_info, datacubeonly_peakDetails );
                        
                        % Removing a particular list of m/z
                        
                        if ~isempty(mzvalues2discard)
                            mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' peaks discarded)\' ];
                            datacube_mzvalues_indexes = f_black_peaks_list_removal( mzvalues2discard, datacubeonly_peakDetails, datacube_mzvalues_indexes );
                        end
                        
                        % Defining mask and data for MVA
                        
                        sumlog = zeros(size(assembled_mask,1),1);
                        sumlog0 = logical(sum(assembled_norm_data(:,datacube_mzvalues_indexes),2)>0);
                        sumlog(assembled_indicies,1) = sumlog0;
                        
                        mask4mva = logical(assembled_mask.*sumlog);
                        data4mva = assembled_norm_data(sumlog0,datacube_mzvalues_indexes);
                        
                        % Creating a new folder
                        
                        if ~exist(mva_path, 'dir'); mkdir(mva_path); end
                        
                        % Running and saving MVA outputs
                        
                        f_running_mva_auxiliar( mva_type, mva_path, dataset_name, main_mask, norm_type, data4mva, mask4mva, numComponents, datacube_mzvalues_indexes )
                        
                    end
                    
                end
                
            end
            
            if strcmpi( mva_classes_list, "all" )
                
                for classi = 2:size(classes_info,1)
                    
                    mva_path = [ char(outputs_path) '\mva ' char(classes_info{classi,1}) '\' ];
                    
                    % Findind the required indicies of the datacube
                    
                    datacube_mzvalues_indexes = f_datacube_mzvalues_classes( classes_info, classi, hmdb_sample_info, datacubeonly_peakDetails );
                    
                    % Removing a particular list of m/z
                    
                    if ~isempty(mzvalues2discard)
                        mva_path = [ mva_path(1:end-1)  ' (' num2str(length(mzvalues2discard)) ' peaks discarded)\' ];
                        datacube_mzvalues_indexes = f_black_peaks_list_removal( mzvalues2discard, datacubeonly_peakDetails, datacube_mzvalues_indexes );
                    end
                    
                    % Defining mask and data for MVA
                    
                    sumlog = zeros(size(assembled_mask,1),1);
                    sumlog0 = logical(sum(assembled_norm_data(:,datacube_mzvalues_indexes),2)>0);
                    sumlog(assembled_indicies,1) = sumlog0;
                    
                    mask4mva = logical(assembled_mask.*sumlog);
                    data4mva = assembled_norm_data(sumlog0,datacube_mzvalues_indexes);
                    
                    % Creating a new folder
                    
                    if ~exist(mva_path, 'dir'); mkdir(mva_path); end
                    
                    % Running and saving MVA outputs
                    
                    f_running_mva_auxiliar( mva_type, mva_path, dataset_name, main_mask, norm_type, data4mva, mask4mva, numComponents, datacube_mzvalues_indexes )
                    
                end
                
            end
            
        end
    end
end

