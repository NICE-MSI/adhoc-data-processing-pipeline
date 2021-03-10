clear all; close all; clc;

%% Load Data Set
%   the dataset is from the websit:
%   http://cs.uef.fi/sipu/datasets/t4.8k.txt
% Ref.
%   t4.8k: G. Karypis, E.H. Han, V. Kumar, 
%   CHAMELEON: A hierarchical 765 clustering algorithm using dynamic modeling,
%   IEEE Trans. on Computers, 32 (8), 68-75, 1999.

fileName = 't4.8k.txt';
X = load(fileName);
storageSize = computeStorageSize(size(X, 1) * size(X, 1));
fprintf('Memory Size: %7.2f %s\n', storageSize{1}, storageSize{2});

figure(1);
plot(X(:, 1), X(:, 2), 'b.');
xlabel('Dim 1');
ylabel('Dim 2');
title('Original Data Set');

%% Settings of System Parameters for DensityClust
dist = pdist2(X, X);
percNeigh = 0.02;
kernel = 'Gauss';
[dc, rho] = paraSet(dist, percNeigh, kernel); 
figure(2);
plot(rho, 'b*');
xlabel('ALL Data Points');
ylabel('\rho');
title('Distribution Plot of \rho');

%% Density Clustering
[numClust, clustInd, centInd, haloInd] = densityClust(dist, dc, rho, 1);
save('densityClust.mat', 'numClust', 'clustInd', 'centInd', 'haloInd');
FID = fopen(['DCA.clustInd.' num2str(length(unique(clustInd))) '.txt'], 'w');
fprintf(FID, '%2i ', clustInd');
fclose(FID);
save('densityClust.mat', 'numClust', 'clustInd', 'centInd', 'haloInd');
FID = fopen(['DCA.centInd.' num2str(length(unique(clustInd))) '.txt'], 'w');
fprintf(FID, '%2i ', clustInd');
fclose(FID);
save('densityClust.mat', 'numClust', 'clustInd', 'centInd', 'haloInd');
FID = fopen(['DCA.haloInd.' num2str(length(unique(clustInd))) '.txt'], 'w');
fprintf(FID, '%2i ', clustInd');
fclose(FID);
% NOTE that the number of centers seems to be 4, and 13.
% For better visualization, R code is provided in the same folder!