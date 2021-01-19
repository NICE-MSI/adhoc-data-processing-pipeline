function [ IDX, C, SUMD, K, Var, PC, Cutoff ] = f_kmeans_elbow(data, max_clusters_num, distance_metric)

% Code from https://uk.mathworks.com/matlabcentral/fileexchange/65823-kmeans_opt

pool = parpool;                      % Invokes workers
stream = RandStream('mlfg6331_64');  % Random number stream
options = statset('UseParallel', 1, 'UseSubstreams', 1, 'Streams', stream);

myfunc = @(X,K)(kmeans(X, K, 'Distance', distance_metric, 'MaxIter', 10000, 'Replicates', 10, 'Options', options, 'emptyaction', 'drop', 'Display', 'final'));

wcsd = zeros(max_clusters_num,1);
for k = 1:max_clusters_num   
    [ ~, ~, sumd, ~ ] = myfunc(data, k);
    wcsd(k,1) = sum(sumd.^2);
end
    
delete(gcp('nocreate'))

var = wcsd(1:end-1)-wcsd(2:end); % calculate %variance explained
pc = cumsum(var)/(wcsd(1)-wcsd(end));
optimalK = 1+find(pc > 0.95,1,'first');

[ idx, C, ~, ~ ] = myfunc(data, optimalK);
 
end