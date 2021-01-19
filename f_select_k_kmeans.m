
function [ eva ] = f_select_k_kmeans(data, max_clusters_num, distance_metric)

pool = parpool;                      % Invokes workers
stream = RandStream('mlfg6331_64');  % Random number stream
options = statset('UseParallel', 1, 'UseSubstreams', 1, 'Streams', stream);

% tic

myfunc = @(X,K)(kmeans(X, K, 'Distance', distance_metric, 'MaxIter', 10000, 'Replicates', 10, 'Options', options, 'emptyaction', 'drop', 'Display', 'final'));

disp(['! Running k-means Clustering for k=1,2,...,' num2str(max_clusters_num) ' in search of optimal k...'])

wcsd = zeros(1,max_clusters_num);
all_idx = zeros(size(data,1),max_clusters_num);
for k = 1:max_clusters_num   
    [ idx, ~, sumd, ~ ] = myfunc(data, k);
    wcsd(1,k) = sum(sumd);
    all_idx(:,k) = idx;
end

% Elbow Method

cutoff = 0.95;

var = wcsd(1:end-1)-wcsd(2:end); % calculate %variance explained
pc = cumsum(var)/(wcsd(1)-wcsd(end));
optimalK = 1+find(pc>cutoff,1,'first');

eva.elbowMethod.OptimalK = optimalK;
eva.elbowMethod.OptimalY = all_idx(:,optimalK);
eva.elbowMethod.explVar = var;
eva.elbowMethod.normCumSumExplVar = pc;
eva.elbowMethod.explVarCutOff = cutoff;

% EvalClusters (see details below)

eva0 = evalclusters( data, all_idx, 'CalinskiHarabasz');

eva.CalinskiHarabasz.OptimalK = eva0.OptimalK;
eva.CalinskiHarabasz.OptimalY = all_idx(:,eva.CalinskiHarabasz.OptimalK);
eva.CalinskiHarabasz.CriterionValues = eva0.CriterionValues;

eva0 = evalclusters( data, all_idx, 'DaviesBouldin');

eva.DaviesBouldin.OptimalK = eva0.OptimalK;
eva.DaviesBouldin.OptimalY = all_idx(:,eva.DaviesBouldin.OptimalK);
eva.DaviesBouldin.CriterionValues = eva0.CriterionValues;

eva0 = evalclusters( data, all_idx, 'silhouette', 'Distance', distance_metric);

eva.silhouette.OptimalK = eva0.OptimalK;
eva.silhouette.OptimalY = all_idx(:,eva.silhouette.OptimalK);
eva.silhouette.CriterionValues = eva0.CriterionValues;

eva0 = evalclusters( data, myfunc, 'gap', 'Distance', distance_metric, 'klist', 1:max_clusters_num); % To compute the Gap criterion, you must pass CLUST as a character vector or a function handle representing a clustering algorithm and provide KLIST.

eva.gap.OptimalK = eva0.OptimalK;
eva.gap.OptimalY = eva0.OptimalY;
eva.gap.CriterionValues = eva0.CriterionValues;

% disp(toc)

% % Perform k-means for the optimal k
% 
% optimalK = mode([eva.elbowMethod.OptimalK, eva_CalinskiHarabasz.OptimalK, eva_DaviesBouldin.OptimalK, eva_gap.OptimalK, eva_silhouette.OptimalK]);
% 
% [ idx, C, ~, ~ ] = myfunc(data, optimalK);

delete(gcp('nocreate'))

disp('! Finished running k-means Clustering.')

%

% Evaluate the optimal number of clusters for the sepal length data using the 'CalinskiHarabasz' criterion for example.

% Evaluation criterion can be:
% - 'CalinskiHarabasz'
% - 'DaviesBouldin'	
% - 'gap'	
% - 'silhouette'

% For 'silhouette' and 'gap':
% 'Distance' — Distance metric: 'sqEuclidean' (default), 'Euclidean',
% 'cityblock', 'cosine', 'correlation', 'Hamming' (only valid for the
% silhouette criterion), 'Jaccard', given function, etc.

% For Silhouette Only:
% 'ClusterPriors': 'empirical' (default) or 'equal'

% For Gap Only: 
% 'B' — Number of reference data sets: 100 (default) or a positive integer value
% 'ReferenceDistribution' — Reference data generation method: 'PCA' (default) or 'uniform'

% 'SearchMethod' — Method for selecting optimal number of clusters: 
% 'globalMaxSE' (default) or 'firstMaxSE'
% 'globalMaxSE': Evaluate each proposed number of clusters in KList and
% select the smallest number of clusters satisfying  Gap(K) ? GAPMAX ?
% SE(GAPMAX), where K is the number of clusters, Gap(K) is the gap value 
% for the clustering solution with K clusters, GAPMAX is the largest gap 
% value, and SE(GAPMAX) is the standard error corresponding to the largest 
% gap value.
% 'firstMaxSE': Evaluate each proposed number of clusters in KList and
% select the smallest number of clusters satisfying 
% Gap(K) ? Gap(K+1) ? SE(K+1), where K is the number of clusters, Gap(K) is
% the gap value for the clustering solution with K clusters, and SE(K + 1) 
% is the standard error of the clustering solution with K + 1 clusters.
