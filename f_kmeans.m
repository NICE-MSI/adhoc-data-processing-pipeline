function [ idx, C, optimal_numComponents ] = f_kmeans( data, numComponents, distance_metric )

if ~isnan(numComponents)
    
    [ idx, C, ~, ~ ] = kmeans( data, numComponents, 'distance', distance_metric, 'replicates', 10, 'display', 'final' );
    
    optimal_numComponents = NaN;
    
else
    
    [ idx, C , ~, optimal_numComponents ] = kmeans_elbow( data, min(size(data,1),24) );
    
end