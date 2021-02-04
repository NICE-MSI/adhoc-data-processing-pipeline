function f_running_mva_auxiliar( mva_type, mva_path, dataset_name, main_mask, norm_type, data4mva, mask4mva, numComponents, datacube_mzvalues_indexes )

% This function runs the multivariate analysis - mva_type - on the curated data - data4mva.
%
% Inputs:
% mva_type - string specifying which MVA to run
% mva_path - path to where the MVA results will be saved
% dataset_name - name of the dataset
% main_mask - main mask used
% norm_type - normalisation used
% data4mva - curated data
% mask4mva - mask (pixels) used to obtain curated data
% numComponents - number of components to save
% datacube_mzvalues_indexes - indicies of the peaks selected to be used in
% the MVA in the datacube
%
% Outputs:
% pca - firstCoeffs, firstScores, explainedVariance
% nnmf - W, H
% ica - z, model
% kmeans - idx, C, optimal_numComponents
% tsne - rgbData, idx, cmap, loss, tsne_parameters
% nntsne - rgbData, idx, cmap, outputSpectralContriubtion
% See the help of each function for details on its outputs. With the
% exception of nntsne, Matlab functions are called.

% Create a folder to save the outputs of the MVA

if numComponents > 0
    
    path = [ mva_path char(dataset_name) '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\'];
    
elseif isnan(numComponents)
    
    path = [ mva_path char(dataset_name) '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\'];
    
elseif numComponents < 0
    
    path = [ mva_path char(dataset_name) '\' char(main_mask) '\' char(mva_type) ' manual\' char(norm_type) '\'];
    
end

if ~exist(path, 'dir'); mkdir(path); end
cd(path)

% Save the indicies of peaks selected to be used in the MVA in the datacube

save('datacube_mzvalues_indexes','datacube_mzvalues_indexes','-v7.3')

if sum(datacube_mzvalues_indexes) >= 3 % if there are more then 3 peaks in the curated data
    
    % Running MVA
    
    tic
    
    switch mva_type
        
        case 'pca'
            
            [ coeff, score, latent ] = pca(data4mva);
            
            firstCoeffs = coeff(:,1:min(numComponents,size(coeff,2)));
            firstScores = zeros(length(mask4mva),min(numComponents,size(coeff,2))); firstScores(mask4mva,:) = score(:,1:min(numComponents,size(coeff,2)));
            explainedVariance = latent ./ sum(latent) * 100;
            
            save('firstCoeffs','firstCoeffs','-v7.3')
            save('firstScores','firstScores','-v7.3')
            save('explainedVariance','explainedVariance','-v7.3')
            
        case 'nnmf'
            
            [ W0, H ] = nnmf(data4mva, numComponents);
            
            W = zeros(length(mask4mva),numComponents); W(mask4mva,:) = W0;
            
            save('W','W','-v7.3')
            save('H','H','-v7.3')
            
        case 'rica'
            
            rng default % for reproducibility
            
            % data - matrix with the dimentions number of pixels (rows) by number of masses (columns)
            % q - the number os features
            % 'Lambda' � Regularization coefficient value (1 (default) | positive numeric scalar)
            % 'Standardize' � Flag to standardize predictor data (false (default) | true)
            % 'ContrastFcn' � Contrast function ('logcosh' (default) | 'exp' | 'sqrt')
            % 'InitialTransformWeights' � Transformation weights that initialize
            % optimization (randn(p,q) (default) | numeric matrix)
            
            q = numComponents;
            p = size(data4mva,2);
            
            InitialTransformWeights = randn(p,q); % would fix this for different runs
            
            model = rica(data4mva,q,'VerbosityLevel',1,'Lambda',1,'Standardize',true,'ContrastFcn','logcosh', 'InitialTransformWeights', InitialTransformWeights);
            
            z0 = transform(model,data4mva); % transforms the data into the features z via the model
            
            z = zeros(length(mask4mva),min(numComponents,size(z0,2))); z(mask4mva,:) = z0(:,1:min(numComponents,size(z0,2)));
            
            save('z','z','-v7.3')
            save('model','model','-v7.3')
            
        case 'kmeans'
            
            [ idx0, C, optimal_numComponents, evaluation ] = f_kmeans( data4mva, numComponents, 'cosine' );
                        
            idx = zeros(length(mask4mva),1); idx(mask4mva,:) = idx0; idx(isnan(idx)) = 0;
            
            save('idx','idx','-v7.3')
            save('C','C','-v7.3')
            save('evaluation','evaluation','-v7.3')
            
        case 'hierarclustering'
            
            dist_path = [ mva_path char(dataset_name) '\' char(main_mask) '\hierarclustering trees\'];
            
            if ~exist(dist_path, 'dir')
                
                % Create directory
                
                mkdir(dist_path)
                cd(dist_path)
                
                % Compute distances, linkage trees and saving the later
                           
                disp('! Computing cosine distances...')
                cosD = pdist(data4mva,'cosine');
                disp('! Computing WPGMA linkages...')
                Tree_cosD_WPGMA = linkage(cosD,'weighted'); clear cosD; save('Tree_cosD_WPGMA','Tree_cosD_WPGMA','-v7.3'); clear Tree_cosD_WPGMA                               
                disp('! Linkage trees saved.')
                
            else
                
                cd(dist_path)
                load('Tree_cosD_WPGMA')
                
            end
                        
            % Hierachical Clustering
            
            idx0 = cluster(Tree_cosD_WPGMA, 'maxclust', numComponents);
            
            C = zeros(size(unique(idx0),1),size(data4mva,2));
            for k = unique(idx0)'
                C(k,:) = mean(data4mva(idx0==k,:),1);
            end
            
            idx = zeros(length(mask4mva),1); idx(mask4mva,:) = idx0; idx(isnan(idx)) = 0;
            
            tree_path = [ path filesep 'cosD_WPGMA' ];
            
            if ~exist(tree_path, 'dir')
                mkdir(tree_path)
            end
            
            cd(tree_path)
            
            save('idx','idx','-v7.3')
            save('C','C','-v7.3')
                                                
        case 'tsne'
            
            dist_path = [ mva_path char(dataset_name) '\' char(main_mask) '\tsne reduced data\'];
            
            if ~exist(dist_path, 'dir')
                
                % Create directory
                
                mkdir(dist_path)
                cd(dist_path)
                                 
                disp('! Running t-SNE...')        
                [ rgbData, loss, tsne_parameters ] = f_tsne( data4mva );
                save('rgbData','rgbData','-v7.3')
                save('loss','loss','-v7.3')
                save('tsne_parameters','tsne_parameters','-v7.3')
                disp('! t-SNE reduced data and other model details saved.')
                
            else
                
                cd(dist_path)
                load('rgbData')
                
            end
            
            % Clustering t-SNE space
            
            disp('! Clustering t-SNE reduced data...')   
            
            [ idx0, cmap, optimal_numComponents, evaluation ] = f_tsne_space_clustering( rgbData, numComponents );
            
            idx = zeros(length(mask4mva),1); idx(mask4mva,:) = idx0; idx(isnan(idx)) = 0;
            
            cd(path)
            
            save('idx','idx','-v7.3')
            save('cmap','cmap','-v7.3')
            save('optimal_numComponents','optimal_numComponents','-v7.3')
            save('evaluation','evaluation','-v7.3')
            
        case 'nntsne'
            
            [ rgbData, idx0, cmap, outputSpectralContriubtion, var, pc, cutoff  ] = nnTsneFull( data4mva, numComponents );
            
            idx = zeros(length(mask4mva),1); idx(mask4mva,:) = idx0; idx(isnan(idx)) = 0;
            
            save('rgbData','rgbData','-v7.3')
            save('idx','idx','-v7.3')
            save('cmap','cmap','-v7.3')
            save('outputSpectralContriubtion','outputSpectralContriubtion','-v7.3')
            
            if isnan(numComponents)
                save('var','var','-v7.3')
                save('pc','pc','-v7.3')
                save('cutoff','cutoff','-v7.3')
            end
            
        case 'fdc'
            
            if isnan(numComponents)
                isManualSelect = 0;
                isAutoSelect = 1;
                topK = 0;
            elseif numComponents < 0
                isManualSelect = 1;
                isAutoSelect = 0;
                topK = 0;
            else
                isManualSelect = 0;
                isAutoSelect = 0;
                topK = numComponents;
            end
            
            [ idx0, C, rho, delta, centInd ]  = f_LC_FDC( data4mva, 'correlation', 0.1, 500, isManualSelect, isAutoSelect, topK, path );
            
            idx = zeros(length(mask4mva),1); idx(mask4mva,:) = idx0; idx(isnan(idx)) = 0;
            
            save('idx','idx','-v7.3')
            save('C','C','-v7.3')
            save('rho','rho','-v7.3')
            save('delta','delta','-v7.3')
            save('centInd','centInd','-v7.3')
            
    end
    
    t = toc; disp([ '!!! ' char(mva_type) ' time elapsed: ' num2str(t) ])
    
else
    
    disp('!!! There are less than 3 mz values of interest. MVA did not run.')
    
end