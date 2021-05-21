function datacube_mzvalues_indexes = f_datacube_mzvalues_ampl_ratio_highest_peaks( amplratio4mva, numPeaks4mva, peakDetails, datacubeonly_peakDetails, totalSpectrum_intensities )

% This function returns the indices of the top numPeaks4mva peaks that
% survive a filtering step based on their amplitude.
%
% Inputs:
% amplratio4mva - threshold for the amplitude ratio (double)
% numPeaks4mva - number of top (most intense) peaks to keep
% peakDetails - Matlab matrix with details for all peaks found in the total spectrum
% datacubeonly_peakDetails - Matlab matrix with details for the peaks saved in the data cube
% totalSpectrum_intensities - array of doubles with the amplitudes of the total spectrum
%
% Outputs:
% datacube_mzvalues_indexes - indices of the top numPeaks4mva peaks that
% survive a filtering step based on their amplitude

y = totalSpectrum_intensities; % total spectrum

peak_amplitude_feature = zeros(size(peakDetails,1),1);
peak_mz = zeros(size(peakDetails,1),1);
peak_amplitude = zeros(size(peakDetails,1),1);

for peaki = 1:size(peakDetails,1) % iterating through peaks
    
    maxA = max(y(peakDetails(peaki,6):peakDetails(peaki,7)))-min(y(peakDetails(peaki,6)),y(peakDetails(peaki,7)));
    minA = max(y(peakDetails(peaki,6):peakDetails(peaki,7)))-max(y(peakDetails(peaki,6)),y(peakDetails(peaki,7)));
    
    peak_amplitude_feature(peaki,1) = minA./maxA*100; % computing amplitude ratio (this is a way to quantify how "shoulder like" is a peak)
    peak_mz(peaki) = peakDetails(peaki,2); % mass
    peak_amplitude(peaki) = max(y(peakDetails(peaki,6):peakDetails(peaki,7)));
    
end

peaki2keep = logical(peak_amplitude_feature>=amplratio4mva);

smaller_peakDetails = peakDetails(peaki2keep,:);

if size(smaller_peakDetails,1)<numPeaks4mva
    
    disp("!!! After the amplitude ratio thresholding, there are not enought peaks to run the MVA.");
    
    mzvalues2keep2 = [];
    
else
    
    % Select the mz values of the peaks that show the highest counts in the total spectrum.
    
    if ~isempty(numPeaks4mva)
        [ ~, mzvalues_highest_peaks_indexes ] = sort(smaller_peakDetails(:,4),'descend');
        mzvalues2keep2 = smaller_peakDetails(mzvalues_highest_peaks_indexes(1:numPeaks4mva,1),2);
    else
        mzvalues2keep2 = [];
    end
    
end

mzvalues2keep = unique(mzvalues2keep2);

[~, datacube_mzvalues_indexes] = ismembertol(mzvalues2keep,datacubeonly_peakDetails(:,2),1e-10);