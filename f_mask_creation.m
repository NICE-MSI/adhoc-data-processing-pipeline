function f_mask_creation( filesToProcess, input_mask, dataset_name, mva_type, mva_reference, numComponents, norm_type, vector_set, regionsNumE, regionsNumI, output_mask )

% This function creates new masks using previously run MVA results. 
% It can only be used for an imzml file at a time.
% It can only use MVAs that produce an "idx" variable ie a clustering map.
%
% Inputs:
% filesToProcess - struct with the imzml name and location 
% input mask - string specifying the name of the mask used to run the mva
% dataset_name - set to empty when using individual imzml (it might work
% for combined imzmls but it has not been tested)
% mva_type - name of the segmentation technique used
% mva_reference - name of the mvas folder to be used
% numComponents - number of clusters used (double)
% norm_type - normalisation used
% vector_set - list of doubles specifying the numbers (ids) of the clusters to keep
% regionsNumE - number of areas to cut and keep (these areas are multiplied by the clusters in vector_set - intersection of areas)
% regionsNumI - number of areas to fill and keep (these areas are added to the clusters in vector_set - union of areas)
% output_mask - string specifying the name for the new mask
%
% Outputs:
% roi - a Spectral Analysis RegionOfInterest struct for the new mask

if size(filesToProcess,1) > 1; disp('Please select a unique file to create the roi!'); end

file_index = 1;

% Defining all required paths

csv_inputs = [ filesToProcess(file_index).folder '\inputs_file' ];

[ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);

spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
mva_path                = [ char(outputs_path) '\' char(mva_reference) '\' ];
rois_path               = [ char(outputs_path) '\rois\' ];

% Creating a new "rois" folder where all the roi structs will be saved

mkdir(rois_path)

% Loading the width and height of the imzml

load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(input_mask) '\width' ])
load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(input_mask) '\height' ])

% Loading the clustering map i.e. the "idx" variable

mva_type = char(mva_type);

if isnan(numComponents)
    cd([ mva_path filesToProcess(file_index).name(1,1:end-6) '\' char(input_mask) '\' char(mva_type) '\' char(norm_type) '\' char(dataset_name) '\'])
else
    cd([ mva_path filesToProcess(file_index).name(1,1:end-6) '\' char(input_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\' char(dataset_name) '\'])
end

load('idx')

% Keeping the pixels that belong to the clusters listed in "vector_set"

tissue_vector = 0*idx;
for clusteri = vector_set
    tissue_vector(idx == clusteri) = 1;
end

% Creating a mask that contains all clusters in vector_set

roi_mask0 = logical(reshape(tissue_vector,width,height)');

if regionsNumE > 0
    roi_mask1 = 0*roi_mask0;
else
    roi_mask1 = 1;
end

% Adding (+) new areas (manually selected) to intersect with those in vector_set

for regionsi = 1:regionsNumE
    figure(1000);
    title({'Choose Areas to Keep!'})
    roi_mask2 = roipoly(roi_mask0);
    roi_mask1 = roi_mask1 + roi_mask2;
end

% Adding (+) new areas (manually selected) to fill

roi_mask3 = 0*roi_mask0;
for regionsi = 1:regionsNumI
    figure(2000);
    title({'Choose Areas to Fill In!'})
    roi_mask4 = roipoly(roi_mask0.*roi_mask1);
    roi_mask3 = roi_mask3 + roi_mask4;
end

% Creating the final mask by:
% * multiplying all clusters to keep (roi_mask0) by the areas to keep
% * adding the result of the above to the areas to fill

roi_mask = roi_mask0 .* roi_mask1 + roi_mask3;

% Creating a SpectralAnalysis roi struct with the information regarding the
% new mask

roi = RegionOfInterest(width,height);
roi.addPixels(roi_mask)

% Plotting the final mask

figure(3000);
imagesc(roi.pixelSelection); axis image
colormap gray; title({['Final ', char(output_mask), ' mask!']})

% Saving the final mask

mkdir([ rois_path filesToProcess(file_index).name(1,1:end-6) '\' char(output_mask) '\'])
cd([ rois_path filesToProcess(file_index).name(1,1:end-6) '\' char(output_mask) '\'])

save('roi','roi')

% Creating, plotting and saving the background mask

if isequal(output_mask,"tissue only")
    
    new_mask = ~roi_mask; % the background is everyting that is not tissue
    
    roi = RegionOfInterest(roi.width,roi.height);
    roi.addPixels(new_mask)
    
    figure(4000);
    imagesc(roi.pixelSelection); axis image
    colormap gray; title({'Final background mask!'})
    
    mkdir([ rois_path filesToProcess(file_index).name(1,1:end-6) '\background\'])
    cd([ rois_path filesToProcess(file_index).name(1,1:end-6) '\background\'])
    
    save('roi','roi')
    
end