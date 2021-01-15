function [ idx, C, optimal_numComponents, var, pc, cutoff ] = f_kmeans( data, numComponents, distance_metric )

if ~isnan(numComponents)
    
    [ idx, C, ~, ~ ] = kmeans( data, numComponents, 'distance', distance_metric, 'replicates', 10, 'display', 'final' );
    
    optimal_numComponents = NaN;
    var = NaN;
    pc = NaN;
    cutoff = NaN;
    
else
    
    [ idx, C , ~, optimal_numComponents, var, pc, cutoff ] = kmeans_elbow( data, min(size(data,1),24), distance_metric );
    
end