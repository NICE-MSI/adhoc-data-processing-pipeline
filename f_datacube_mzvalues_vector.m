function datacube_mzvalues_indexes = f_datacube_mzvalues_vector( mzvalues2keep, datacubeonly_peakDetails )

% This function returns the indices of the masses in mzvalues2keep.
%
% Inputs:
% mzvalues2keep - a list of masses (doubles)
% datacubeonly_peakDetails - Matlab matrix with details for the peaks saved in the data cube
%
% Outputs:
% datacube_mzvalues_indexes - indices of of the masses in mzvalues2keep

[~, datacube_mzvalues_indexes] = ismembertol(mzvalues2keep,datacubeonly_peakDetails(:,2),1e-10); % an m/z is considered the same when it differs less than 1e-12 from that saved in datacubeonly_peakDetails
