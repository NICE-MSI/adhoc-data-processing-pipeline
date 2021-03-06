function [ numClust, clustInd, centInd, haloInd ] = f_densityClust(dist, dc, rho, ordRho, delta, indNearNeigh, isManualSelect, istopK, isHalo, path)
%%DENSITYCLUST Clustering by fast search and find of density peaks.
%   SEE the following paper published in *SCIENCE* for more details:
%       Alex Rodriguez & Alessandro Laio: Clustering by fast search and find of density peaks,
%       Science 344, 1492 (2014); DOI: 10.1126/science.1242072.
%   INPUT:
%       dist: [NE, NE] distance matrix
%       dc: cut-off distance
%       rho: local density [row vector]
%       isHalo: 1 denotes that the haloInd assigment is provided, otherwise 0.
%   OUTPUT:
%       numClust: number of clusters
%       clustInd: cluster index that each point belongs to, NOTE that -1 represents no clustering assignment (haloInd points)
%       centInd:  centroid index vector
%       haloInd: haloInd row vector [0 denotes no haloInd assignment]


[ numClust, centInd ] = f_decisionGraph(rho, delta, isManualSelect, istopK, path); % isManualSelect = 1 denote that all the cluster centroids are selected manually, otherwise 0

% after the cluster centers have been found,
% each remaining point is assigned to the same cluster as its nearest neighbor of higher density

[NE, ~] = size(dist);
clustInd = zeros(1, NE);
for i = 1 : NE
    if centInd(ordRho(i)) == 0 % not centroid
        clustInd(ordRho(i)) = clustInd(indNearNeigh(ordRho(i)));
    else
        clustInd(ordRho(i)) = centInd(ordRho(i));
    end
end

haloInd = haloAssign(dist, clustInd, numClust, dc, rho, isHalo);

end

%% Local Function
function [haloInd] = haloAssign(dist, clustInd, numClust, dc, rho, isHalo)
[NE, ~] =size(dist);
if isHalo == 1
    haloInd = clustInd;
    bordRho = zeros(1, numClust);
    for i = 1 : (NE - 1)
        for j = (i + 1) : NE
            if (clustInd(i) ~= clustInd(j)) && ((dist(i, j) < dc))
                avgRho = (rho(i) + rho(j)) / 2;
                if avgRho > bordRho(clustInd(i))
                    bordRho(clustInd(i)) = avgRho;
                end
                if avgRho > bordRho(clustInd(j))
                    bordRho(clustInd(j)) = avgRho;
                end
            end
        end
    end
    for i = 1 : NE
        if rho(i) < bordRho(clustInd(i))
            haloInd(i) = 0; % 0 denotes the point is a halo
        end
    end
else
    haloInd = zeros(1, NE); % 0 denotes no halo assignment
end
end