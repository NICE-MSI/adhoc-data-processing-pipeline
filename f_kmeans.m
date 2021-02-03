function [ idx, C, optimal_numComponents, evaluation ] = f_kmeans( data, numComponents, distance_metric )
    
pool = parpool; % Invokes workers
stream = RandStream('mlfg6331_64'); % Random number stream
options = statset('UseParallel', 1, 'UseSubstreams', 1, 'Streams', stream);

myfunc = @(X,K)(kmeans(X, K, 'Distance', distance_metric, 'MaxIter', 10000, 'Replicates', 5, 'Options', options, 'emptyaction', 'singleton', 'Display', 'final'));

if ~isnan(numComponents)
    
    [ idx, C, ~, ~ ] = myfunc(data, numComponents);

    optimal_numComponents = NaN;
    
    evaluation = [];
        
else
    
    evaluation = f_select_k_kmeans(data, 24, distance_metric);

    optimal_numComponents = evaluation.elbowMethod.OptimalK; % Elbow method
    
    [ idx, C, ~, ~ ] = myfunc(data, optimal_numComponents); % Run k-means for selected k
    
end

delete(gcp('nocreate'))