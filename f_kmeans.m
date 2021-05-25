function [ idx, C, optimal_numComponents, evaluation ] = f_kmeans( data, numComponents, distance_metric )

% This function computes k-means clustering using numComponents clusters 
% and the distance metric distance_metric.
% 
% Inputs:
% data - a matrix of doubles with the ion counts for each pixel (row) and
% mass channel (column)
% numComponents - number of clusters. If numComponents=NaN, the optimal 
% number of clusters is estimated by the Elbow method and used.
% distance_metric - a string specifying the distance metric
% 
% Outputs:
% idx - clusters map
% C - spectral representation of each cluster
% optimal_numComponents - optimal number of clusters determined by the 
% Elbow method
% evaluation - optimal number of clusters determined by elbow method,
% CalinskiHarabasz, and DaviesBouldin criteria


% Code used previously for paralelization of k-means
%
% pool = parpool; % Invokes workers
% stream = RandStream('mlfg6331_64'); % Random number stream
% options = statset('UseParallel', 1, 'UseSubstreams', 1, 'Streams', stream);
% 
% myfunc = @(X,K)(kmeans(X, K, 'Distance', distance_metric, 'MaxIter', 10000, 'Replicates', 5, 'Options', options, 'emptyaction', 'singleton', 'Display', 'final'));

myfunc = @(X,K)(kmeans(X, K, 'Distance', distance_metric, 'MaxIter', 10000, 'Replicates', 5, 'emptyaction', 'singleton', 'Display', 'final'));

if ~isnan(numComponents)
    
    [ idx, C, ~, ~ ] = myfunc(data, numComponents); % Running k-means clustering with number of clusters = numComponents

    optimal_numComponents = NaN;
    
    evaluation = [];
        
else
    
    evaluation = f_select_k_kmeans(data, 24, distance_metric); % Computing the optimal number of clusters (ie k)

    optimal_numComponents = evaluation.elbowMethod.OptimalK; % Grabing the optimal number of clusters according to the Elbow method
    
    [ idx, C, ~, ~ ] = myfunc(data, optimal_numComponents); % Running k-means clustering with the optimal number of clusters
    
end

delete(gcp('nocreate'))