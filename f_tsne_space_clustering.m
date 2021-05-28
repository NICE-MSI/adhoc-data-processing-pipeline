function [ idx, tsne_colomap, optimal_numComponents, evaluation ] = f_tsne_space_clustering( reduced_x, clusters_num )

% This function segments the t-sne embedding space using k-means. See
% f_kmeans for more details regarding the segmentation.
%
% Inputs:
% reduced_x - data in the reduced (tsne) space
% clusters_num - number of clusters (can be an integer or NaN)
% Outputs:
% idx - cluster labels
% tsne_colormap - map to use when plotting the segmentation results
% optimal_numComponents - optimal number of clusters based on Elbow method
% evaluation - a few metrics regarding the selection of the optimal number
% of clusters


% Clustering the t-sne space

[ idx, C, optimal_numComponents, evaluation ] = f_kmeans( reduced_x, clusters_num, 'sqeuclidean' );

C(C<0) = 0;
C(C>1) = 1;

tsne_colomap(1,1:3) = 0;
tsne_colomap(2:max(idx)+1,:) = C;

end