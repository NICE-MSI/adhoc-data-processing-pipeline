function datacube_mzvalues_indexes = f_datacube_mzvalues_classes( classes_info, classi, hmdb_sample_info, datacubeonly_peakDetails )

% This function returns the indices of the peaks that belong to a 
% particular kingdom, super-class, class and/or sub-class.
%
% Inputs:
% classes_info - cell with all the information in the file named molecules_classes_specification
% classi - row of the cell classes_info
% hmdb_sample_info - Matlab matrix with details regarding the assigments of
% all peaks found in the total spectrum
% datacubeonly_peakDetails - Matlab matrix with details for peaks saved in the data cube
%
% Outputs:
% datacube_mzvalues_indexes - indices of the peaks that belong to a 
% particular kingdom, super-class, class and/or sub-class

indexes2keep = ones(size(hmdb_sample_info,1),1);
for i = 2:5
    if ~isnan(classes_info{classi,i}); indexes2keep = indexes2keep .* strcmpi(hmdb_sample_info(:,14+(i-2)),classes_info{classi,i}); end
end

mzvalues2keep = double(unique(hmdb_sample_info(logical(indexes2keep),4)));

[~, datacube_mzvalues_indexes] = ismembertol(mzvalues2keep,datacubeonly_peakDetails(:,2),1e-10);