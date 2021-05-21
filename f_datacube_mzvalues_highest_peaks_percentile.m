function datacube_mzvalues_indexes = f_datacube_mzvalues_highest_peaks_percentile( perc4mva, peakDetails, datacubeonly_peakDetails )

% This function returns the indices of the peaks in the percentile perc4mva
% (most intense in the total spectrum).
%
% Inputs:
% perc4mva - percentile of the peaks to keep (double)
% peakDetails - Matlab matrix with details for all peaks found in the total spectrum
% datacubeonly_peakDetails - Matlab matrix with details for the peaks saved in the data cube
%
% Outputs:
% datacube_mzvalues_indexes - indices of the peaks in the percentile perc4mva

if ~isempty(perc4mva)
    mzvalues2keep2 = peakDetails(logical(peakDetails(:,4)>=prctile(peakDetails(:,4),perc4mva)),2);
else
    mzvalues2keep2 = [];
end

mzvalues2keep = unique(mzvalues2keep2);

[~, datacube_mzvalues_indexes] = ismembertol(mzvalues2keep,datacubeonly_peakDetails(:,2),1e-10);
