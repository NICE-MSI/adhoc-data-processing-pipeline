function [ IDX, C, SUMD, K, Var, PC, Cutoff ] = f_select_k_keans(data, data, max_clusters_num, distance_metric, distance_metric)

Cutoff=0.95;

D = zeros(ToTest,1); % initialize the results matrix
for c=1:ToTest % for each sample
    [ ~, ~, dist ] = kmeans(X, c, 'Distance', distance_metric, 'emptyaction', 'drop', 'replicates', 10, 'display', 'final'); % compute the sum of intra-cluster distances (returns the best of 10 runs)
    D(c,1) = sum(dist);
    % tmp=sum(dist); %best so far
    % for cc=2:Repeats %repeat the algo
        % [~,~,dist]=kmeans(X,c,'emptyaction','drop');
        % tmp=min(sum(dist),tmp);
    % end
    % D(c,1)=tmp; % collect the best so far in the results vector
end

Var = D(1:end-1)-D(2:end); % calculate % variance explained
PC = cumsum(Var)/(D(1)-D(end));

[ r, ~ ] = find( PC > Cutoff ); % find the best index
K = 1 + r(1,1); % get the optimal number of clusters
[ IDX, C, SUMD ] = kmeans(X, K, 'Distance', distance_metric, 'emptyaction', 'drop', 'replicates', 10, 'display', 'final'); % rerun kmeans with the optimal number of clusters (returns the best of 10 runs)
 
end