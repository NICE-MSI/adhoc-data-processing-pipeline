function datacube_mzvalues_indexes = f_datacube_mzvalues_highest_peaks( numPeaks4mva, peakDetails, datacubeonly_peakDetails )

% This function returns the indices of the top numPeaks4mva (most intense in the total spectrum) peaks.
%
% Inputs:
% numPeaks4mva - number of top (most intense) peaks to keep
% peakDetails - Matlab matrix with details for all peaks found in the total spectrum
% datacubeonly_peakDetails - Matlab matrix with details for the peaks saved in the data cube
%
% Outputs:
% datacube_mzvalues_indexes - indices of the top numPeaks4mva peaks

if ~isempty(numPeaks4mva)
    [ ~, mzvalues_highest_peaks_indexes ] = sort(peakDetails(:,4),'descend');
    mzvalues2keep2 = peakDetails(mzvalues_highest_peaks_indexes(1:numPeaks4mva,1),2);
else
    mzvalues2keep2 = [];
end

mzvalues2keep = unique(mzvalues2keep2);

[~, datacube_mzvalues_indexes] = ismembertol(mzvalues2keep,datacubeonly_peakDetails(:,2),1e-10);
