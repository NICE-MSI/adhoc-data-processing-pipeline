function [ idx, C, optimal_numComponents, evaluation ] = f_kmeans( data, numComponents, distance_metric )

if ~isnan(numComponents)
    
    pool = parpool;                      % Invokes workers
    stream = RandStream('mlfg6331_64');  % Random number stream
    options = statset('UseParallel', 1, 'UseSubstreams', 1, 'Streams', stream);
    
    myfunc = @(X,K)(kmeans(X, K, 'Distance', distance_metric, 'MaxIter', 10000, 'Replicates', 10, 'Options', options, 'emptyaction', 'singleton', 'Display', 'final'));
    
    [ idx, C, ~, ~ ] = myfunc(data, numComponents);
    
    delete(gcp('nocreate'))
    
    optimal_numComponents = NaN;
    
    evaluation = [];
    
    %     var = NaN;
    %     pc = NaN;
    %     cutoff = NaN;
    
else
    
    % [ idx, C , ~, optimal_numComponents, var, pc, cutoff ] = kmeans_elbow( data, min(size(data,1),24), distance_metric );
    
    idx = NaN;
    C = NaN;
    optimal_numComponents = NaN;
    [ evaluation ] = f_select_k_kmeans(data, 24, distance_metric);
    
    
end