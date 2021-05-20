function f_saving_mva_rois_ca( filesToProcess, main_mask_list, dataset_name, mva_list, numComponents_list, norm_list, mva_reference )

% Sorting the filesToProcess (and re-organising the related
% information) to avoid the need to load the data unnecessary times.

file_names = []; for i = 1:size(filesToProcess,1); file_names = [ file_names; string(filesToProcess(i).name) ]; end
[~, files_indicies] = sort(file_names);
filesToProcess = filesToProcess(files_indicies);

%

csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];

[ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);

spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
mva_path                = [ char(outputs_path) '\' char(mva_reference) '\' ]; if ~exist(mva_path, 'dir'); mkdir(mva_path); end
rois_path               = [ char(outputs_path) '\rois\' ];

for main_mask = main_mask_list
    
    mvai = 0;
    for mva_type = mva_list
        mvai = mvai+1;
        numComponents = numComponents_list(mvai);
        
        for norm_type = norm_list
            
            if isnan(numComponents)
                
                load([ mva_path char(dataset_name) '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\idx' ]);
                idx0 = idx; clear idx
                
            else
                
                load([ mva_path char(dataset_name) '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\idx' ]);
                idx0 = idx; clear idx
                
            end
            
            mask4idx = [];
            starti = 1;
            coli = 1;
            unique_file_names = string([]);
            
            for file_index = 1:length(filesToProcess)
                                
                load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\width' ]); % Loading original images width and height
                load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask) '\height' ]); % Loading original images width and height
                                
                endi = starti+width*height-1; % pixels number
                
                if file_index>1 && ~isequal(filesToProcess(file_index-1).name(1,1:end-6),filesToProcess(file_index).name(1,1:end-6))
                    coli = coli + 1;
                end
                
                unique_file_names(1,coli) = filesToProcess(file_index).name(1,1:end-6);
                
                mask4idx(starti:endi,coli) = 1;
                
                starti = endi+1;
                
            end
            
            for coli = 1:length(unique_file_names)
                
                load([ spectra_details_path char(unique_file_names(coli)) '\' char(main_mask) '\width' ]); % Loading original images width and height
                load([ spectra_details_path char(unique_file_names(coli)) '\' char(main_mask) '\height' ]); % Loading original images width and height
                
                idx1 = idx0(logical(mask4idx(:,coli)),1);
                
                idx = sum(reshape(idx1,height*width,[]),2);
                idx_image = reshape(idx,width,height)';

                if isnan(numComponents)
                    
                    mkdir([ rois_path char(unique_file_names(coli)) '\mva rois\' char(dataset_name) '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\mva ' char(mva_reference) '\' ])
                    cd([ rois_path char(unique_file_names(coli)) '\mva rois\' char(dataset_name) '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\mva ' char(mva_reference) '\' ])
                    
                else
                    
                    mkdir([ rois_path char(unique_file_names(coli)) '\mva rois\' char(dataset_name) '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\mva ' char(mva_reference) '\' ])
                    cd([ rois_path char(unique_file_names(coli)) '\mva rois\' char(dataset_name) '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\mva ' char(mva_reference) '\' ])
                    
                end
                
                save('idx','idx')
                save('idx_image','idx_image')

                for idx_i = unique(idx)'
                    
                    roi_image = logical(reshape(logical(idx==idx_i),width,height)');
                    
                    roi = RegionOfInterest(width,height);
                    roi.addPixels(roi_image)
                    
%                     figure();
%                     
%                     imagesc(roi.pixelSelection); axis image
%                     colormap gray;
%                     title({['component ' num2str(idx_i)]})
                    
                    mkdir(['component ' num2str(idx_i)])
                    cd(['component ' num2str(idx_i)])
                    
                    save('roi','roi')
                    save('roi_image','roi_image')
                    
                    cd('..')
                    
                end
                
                clear idx idx_image roi roi_image
                
            end
        end
    end
end
