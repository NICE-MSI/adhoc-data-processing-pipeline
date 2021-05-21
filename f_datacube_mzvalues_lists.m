function datacube_mzvalues_indexes = f_datacube_mzvalues_lists( mva_molecules_lists_label_list, ppmTolerance, sample_info, datacubeonly_peakDetails )

% This function returns the indices of the peaks assigned to at least one
% of the lists of molecules of interest.
%
% Inputs:
% mva_molecules_lists_label_list - list of lists of molecules of interest
% ppmTolerance - maximum error for the assigments
% sample_info - information about peak assigments
% datacubeonly_peakDetails - Matlab matrix with details for the peaks saved in the data cube
%
% Outputs:
% datacube_mzvalues_indexes - indices of the peaks assigned to at least one
% of the lists of molecules of interest


mini_sample_info_mzvalues_indexes = 0;
for labeli = mva_molecules_lists_label_list
    mini_sample_info_mzvalues_indexes = mini_sample_info_mzvalues_indexes + ( strcmp(sample_info(:,7),labeli) .* logical(double(sample_info(:,5))<=ppmTolerance) );
end

mzvalues2keep1 = double(unique(sample_info(logical(mini_sample_info_mzvalues_indexes),4)));

mzvalues2keep = unique(mzvalues2keep1);

[~, datacube_mzvalues_indexes] = ismembertol(mzvalues2keep,datacubeonly_peakDetails(:,2),1e-10);
