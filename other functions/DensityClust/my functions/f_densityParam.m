function [ cosD, dc, rho, ordRho, delta, indNearNeigh ] = f_densityParam(data)

% See the following paper for more details:
%       Alex Rodriguez & Alessandro Laio: Clustering by fast search and find of density peaks,
%       Science 344, 1492 (2014); DOI: 10.1126/science.1242072.
% Original code downloaded from:
%       https://uk.mathworks.com/matlabcentral/fileexchange/53922-densityclust.
%
%   Input:
%       data: [Pixels, Masses] matrix
%   Output:
%       cosD: [Pixels, Pixels] cosine distance matrix
%       dc: cut-off distance
%       rho: local density [row vector]
%       delta: ... [row vector]
%       indNearNeigh: ...

storageSize = computeStorageSize(size(data, 1) * size(data, 1));
fprintf('Memory Size: %7.2f %s\n', storageSize{1}, storageSize{2});

% Estimating dc and rho for density clustering

cosD = pdist2(data, data, 'cosine');
cosD = cosD-diag(diag(cosD)); % when using cosine distance, the diagonal was not exactly zero so hard coded that condition

percNeigh = 0.02;
kernel = 'Gauss';
[dc, rho] = paraSet(cosD, percNeigh, kernel);

[NE, ~] = size(cosD);
delta = zeros(1, NE); % minimum cosDance between each point and any other point with higher density
indNearNeigh = Inf * ones(1, NE); % index of nearest neighbor with higher density

[~, ordRho] = sort(rho, 'descend');

for i = 2 : NE
    delta(ordRho(i)) = max(cosD(ordRho(i), :));
    for j = 1 : (i-1)
        if cosD(ordRho(i), ordRho(j)) < delta(ordRho(i))
            delta(ordRho(i)) = cosD(ordRho(i), ordRho(j));
            indNearNeigh(ordRho(i)) = ordRho(j);
        end
    end
end
delta(ordRho(1)) = max(delta);
indNearNeigh(ordRho(1)) = 0; % no point with higher density