function norm_data = f_norm_datacube_v2( datacube, mask0, norm_type )

% Datacube normalisation using a particular mask.

% Mask

mask = logical( (sum(datacube.data,2)>0) .* mask0 );

% mz selection

data = datacube.data(mask,:);

% Multiple normalisation metrics

switch norm_type
    
    case 'no norm' % No normalisation
        
        norm_data0 = data;
        
    case 'tic norm' % TIC normalisation
        
        norm_data0 = f_tic_norm(data);
        
    case 'L2 norm' % L2 normalisation
        
        norm_data0 = f_L2_norm(data); 
        
    case 'RMS norm' % RMS normalisation
        
        norm_data0 = f_RMS_norm(data); 
        
    case 'median norm' % median normalisation
        
        norm_data0 = f_median_norm(data); 
        
    case 'zscore'
        
        norm_data0 = f_zscore_norm(data);
        
    case 'pqn mean'
        
        norm_data0 = crukNormalise(data,'pqn-mean');
        
    case 'pqn median'
        
        norm_data0 = crukNormalise(data,'pqn-median');
        
    case 'log' % no normalisation & log
        
        d0 = data(data>0);
        norm_data0 = log(data+prctile(d0(:),5));

    case "median norm & log" % median normalisation & log
        
        d00 = f_median_norm(data);
        d0 = d00(d00>0);
        norm_data0 = log(d00+prctile(d0(:),5));
        
    case 'pqn median & log'
        
        d00 = crukNormalise(data,'pqn-median');
        d0 = d00(d00>0);
        norm_data0 = log(d00+prctile(d0(:),5));
        
end

norm_data = NaN*ones(length(mask),size(norm_data0,2));
norm_data(mask,:) = norm_data0;
