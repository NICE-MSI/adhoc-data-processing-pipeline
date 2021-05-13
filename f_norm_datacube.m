function norm_data = f_norm_datacube( datacube, norm_type )

% This function performs one the following normalisations:
% none - "no norm"
% total ion count per pixel - "tic"
% total ion count for the entire dataset - "sims tic"
% root mean square - "RMS"
% pqn-mean - "pqn mean"
% pqn-median - "pqn median"
% z-score of each pixel - "zscore"
% 
% Inputs:
% datacube - Spectral Analysis dataRepresentation type of variable, which
% includes the data to be normalised
% norm_type - string specifying the normalisation to perform 
% (e.g.: "no norm", "tic", "RMS", "pqn mean", "pqn median", "zscore")
%
% Outputs:
% norm_data - matrix with normalised data (dimentions: pixels (rows) by mass channels (columns))


% Select pixels with at least one m/z channel with intensity above 0

data = datacube.data(logical(sum(datacube.data,2)>0),:);

% Normalise data

norm_data0 = 0;

switch norm_type
    
    case 'no norm' % No normalisation
        
        norm_data0 = data;
        
    case 'tic'
        
        norm_data0 = bsxfun(@rdivide, data, nansum(data,2));
        
    case 'sims tic'
        
        norm_data0 = bsxfun(@rdivide, data, nansum(data(:)));
        
    case 'RMS'
        
        norm_data0 = bsxfun(@rdivide, data, sqrt(nanmean(data.^2,2)));
        
    case 'pqn mean'
        
        norm_data0 = f_crukNormalise(data,'pqn-mean');
        
    case 'pqn median'
        
        norm_data0 = f_crukNormalise(data,'pqn-median');
    
    case 'zscore'
        
        norm_data0 = zscore(data')';
               
end

if norm_data0==0; disp('!!! Unknown normalisation metric. Please specify a different one.'); for i=1; break; end; end

% Update the shape of the normalised data matrix - all pixels and mass 
% channels are kept
    
norm_data = 0*datacube.data;
norm_data(logical(sum(datacube.data,2)>0),:) = norm_data0;
