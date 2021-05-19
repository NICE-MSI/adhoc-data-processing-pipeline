function f_saving_mva_auxiliar( file_name, main_mask, mva_type, mva_path, norm_type, norm_data, numComponents, numLoadings, datacube, datacubeonly_peakDetails, hmdb_sample_info, totalSpectrum_intensities, totalSpectrum_mzvalues, pixels_num, fig_ppmTolerance)

if numComponents > 0
    
    path = [ mva_path char(file_name) '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\'];
    
elseif isnan(numComponents)
    
    path = [ mva_path char(file_name) '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\'];
    
end

mkdir(path)
cd(path)

load('datacube_mzvalues_indexes')

o_numComponents = NaN;

if sum(datacube_mzvalues_indexes) > 0
    
    % Loading MVA outputs
    
    switch mva_type
        
        case 'pca'
            
            load('datacube_mzvalues_indexes')
            load('firstCoeffs')
            load('firstScores')
            load('explainedVariance')
            
            numComponentsSaved = size(firstCoeffs,2);
            o_numComponents = numComponents;
            numComponents = numComponentsSaved;
            
        case 'rica'
            
            load('z')
            load('model')
            
            numComponentsSaved = size(z,2);
            o_numComponents = numComponents;
            
        case 'nnmf'
            
            load('datacube_mzvalues_indexes')
            load('W')
            load('H')
            
            numComponentsSaved = size(W,2);
            o_numComponents = numComponents;
            
        case 'kmeans'
            
            load('datacube_mzvalues_indexes')
            load('C')
            load('idx')
            
            numComponentsSaved = max(idx);
            o_numComponents = numComponents;
            numComponents = numComponentsSaved;
            
        case 'nntsne'
            
            load('datacube_mzvalues_indexes')
            load('idx')
            load('cmap')
            load('rgbData')
            load('outputSpectralContriubtion')
            
            numComponentsSaved = max(idx);
            o_numComponents = numComponents;
            numComponents = numComponentsSaved;
            
        case 'tsne'
            
            load('datacube_mzvalues_indexes')
            load('idx')
            load('cmap')
            load([ mva_path char(file_name) '\' char(main_mask) '\tsne reduced data\' char(norm_type) '\rgbData\'])
            load('representative_spectra')
            
            numComponentsSaved = max(idx);
            o_numComponents = numComponents;
            numComponents = numComponentsSaved;
            
        case 'fdc'
            
            load('datacube_mzvalues_indexes')
            load('C')
            load('idx')
            load('rho')
            load('delta')
            load('centInd')
            
            numComponentsSaved = max(idx);
            o_numComponents = numComponents;
            numComponents = numComponentsSaved;
            
        case 'hierarclustering'
            
            load('datacube_mzvalues_indexes')
            
            trees_cell.id = { 'EucD_UPGMA', 'EucD_WPGMA', 'EucD_ward', 'cosD_UPGMA', 'cosD_WPGMA', 'Corr_UPGMA', 'Corr_WPGMA' };
            
            for treei = 5 % cosD_WPGMA
                
                tree_path = [ path filesep trees_cell.id{treei} ];
                cd(tree_path)
                
                load('C')
                load('idx')
                
            end
            
            numComponentsSaved = max(idx);
            o_numComponents = numComponents;
            numComponents = numComponentsSaved;
            
    end
    
    if numComponents > numComponentsSaved
        disp('!!! ERROR !!! The currently saved MVA results do not comprise all the information you want to look at! Please run the function f_running_mva again.')
        return
    else
        
        % Defining colour map for clustering maps
        
        if numComponents <= 10
            clustmap = tab10(numComponents);
        elseif numComponents <= 20
            clustmap = tab20(numComponents);
        elseif numComponents <= 40
            clustmap = f_40colourscheme(numComponents);
        else
            clustmap = viridis(numComponents);
        end
        
        for componenti = 1:numComponents
                        
            if ( componenti == 1 )
                
                %  Clustering maps
                
                if isnan(o_numComponents)
                    cd([ mva_path char(file_name) '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\'])
                elseif o_numComponents>0
                    cd([ mva_path char(file_name) '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\'])
                end
                
                fig0 = figure('units','normalized','outerposition',[0 0 .7 .7]); % set(gcf,'Visible', 'off');

                if isequal(char(mva_type),'kmeans') || isequal(char(mva_type),'hierarclustering') || isequal(char(mva_type),'fdc') 
                                        
                    % Plotting clustering map
                    
                    image_component = reshape(idx,datacube.width,datacube.height)';
                    imagesc(image_component)            
                    if min(idx)==0
                        colormap([ 0 0 0; clustmap ])
                    else
                        colormap(clustmap)
                    end
                    colorbar
                    axis off
                    axis image
                    set(gca, 'fontsize', 12);
                    title({['Clustering map (' num2str(numComponents)  ' clusters)']})
                    
                    % Saving fig and tif files
                    
                    figname_char = 'all clusters image.fig'; savefig(fig0,figname_char,'compact')
                    tifname_char = 'all clusters image.tif'; saveas(fig0,tifname_char)
                    
                    close all
                    clear fig0
                    
                    % Plotting and saving the rho vs delta plot (for fdc only)
                    
                    if isequal(char(mva_type),'fdc')
                        
                        fig000 = figure;
                        plot(rho, delta, 'o', 'MarkerSize', 7, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'w')
                        title('Decision Graph', 'FontSize', 12)
                        xlabel('\rho')
                        ylabel('\delta')
                        hold on;
                        for k = 1:numComponents
                            plot(rho(centInd==k), delta(centInd==k), 'o', 'MarkerSize', 9, 'MarkerFaceColor', clustmap(k,:), 'MarkerEdgeColor', 'w'); axis square; grid on;
                        end
                        title('Decision Graph', 'FontSize', 11)
                        savefig(fig000,'coloured_decision_graph.fig','compact')
                        saveas(fig000,'coloured_decision_graph.tif','tif')
                        close(fig000)
                        
                    end
                    
                elseif isequal(char(mva_type),'tsne')
                                        
                    % Plotting clustered t-sne map
                                        
                    image_component = reshape(idx,datacube.width,datacube.height)'; 
                    subplot(3,4,[1:3 5:7 9:11]) 
                    imagesc(image_component) % clustering map
                    if min(idx)==0
                        colormap(cmap)
                    else
                        colormap(cmap(2:end,:))
                        print('here')
                    end
                    colorbar
                    axis off
                    axis image
                    set(gca, 'fontsize', 12);
                    title({['t-sne space segmentation - ' num2str(numComponents)  ' clusters']})

                    % Plotting clustered t-sne embedding space
                    
                    scatter3_colour_vector = []; for cii = 1:max(idx); scatter3_colour_vector(idx(idx>0)==cii,1:3) = repmat(cmap(cii+1,:),sum(idx(idx>0)==cii),1); end                    
                    
                    subplot(3,4,4)
                    scatter3(rgbData(:,1),rgbData(:,2),rgbData(:,3),1,scatter3_colour_vector); % t-sne embedding space plot
                    colorbar
                    title({'t-sne space'})
                    
                    % Saving fig and tif files
                    
                    figname_char = 'all clusters image.fig'; savefig(fig0,figname_char,'compact')
                    tifname_char = 'all clusters image.tif'; saveas(fig0,tifname_char)
                    
                    close all
                    clear fig0
                    
                    %
                    
                    fig0 = figure('units','normalized','outerposition',[0 0 .7 .7]); % set(gcf,'Visible', 'off');
                    
                    rgb_image_component = zeros(size(image_component,1),size(image_component,2),size(rgbData,2));
                    for ci = 1:size(rgbData,2); aux_rgbData = 0*idx; aux_rgbData(idx>0,1) = rgbData(:,ci); rgb_image_component(:,:,ci) = reshape(aux_rgbData,datacube.width,datacube.height)'; end

                    aux_rgb = logical((sum(rgb_image_component,3)==0)+(isnan(sum(rgb_image_component,3))));
                    
                    for ci = 1:3
                        image_component =  rgb_image_component(:,:,ci);
                        image_component(aux_rgb) = 1;
                        rgb_image_component(:,:,ci) = image_component;
                    end
                    
                    % Plotting t-sne map
                    
                    subplot(3,4,[1:3 5:7 9:11])
                    image(rgb_image_component)
                    axis off
                    axis image
                    set(gca, 'fontsize', 12)
                    title({'t-sne space colours'})
                    
                    % Plotting t-sne embedding space
                    
                    subplot(3,4,4)
                    scatter3(rgbData(:,1),rgbData(:,2),rgbData(:,3),2,rgbData,'filled')
                    title({'t-sne space colours'})
                    
                    % Saving fig and tif files
                    
                    figname_char = 'all clusters image - t-sne space colours.fig'; savefig(fig0,figname_char,'compact')
                    tifname_char = 'all clusters image - t-sne space colours.tif'; saveas(fig0,tifname_char)
                    
                    close all
                    clear fig0
                    
                end
                
            end
            
            % Plotting individual clusters and their spectral signatures
            
            fig = figure('units','normalized','outerposition',[0 0 .7 .7]); % set(gcf,'Visible', 'off');
            jFrame = get(handle(fig), 'JavaFrame');
            jFrame.setMinimized(1);
            
            subplot(1,2,1)
            
            switch mva_type
                
                case 'pca'
                    
                    mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\pc ' num2str(componenti) '\'])
                    cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\pc ' num2str(componenti) '\'])
                    
                    % Plotting PC image
                    
                    image_component = reshape(firstScores(:,componenti),datacube.width,datacube.height)'; 
                    imagesc(image_component)
                    axis off
                    axis image
                    colorbar
                    set(gca, 'fontsize', 12)
                    cmap = makePCAcolormap_tm('DarkRose-LightRose-White-LightGreen-DarkGreen');
                    scaleColorMap(cmap, 0)
                    title({['pc ' num2str(componenti) ' scores - ' num2str(explainedVariance(componenti,1)) '% of explained variance' ]})

                    % PC spectral signature
                    
                    spectral_component = firstCoeffs(:,componenti); % pc 
                    
                    % Outputs path
                    
                    outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\pc ' num2str(componenti) '\top loadings images\']; mkdir(outputs_path)
                    
                case 'rica'
                    
                    mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\ic ' num2str(componenti) '\'])
                    cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\ic ' num2str(componenti) '\'])
                    
                    % Plotting IC image
                    
                    image_component = reshape(z(:,componenti),datacube.width,datacube.height)';
                    imagesc(image_component)
                    axis off
                    axis image
                    colorbar
                    set(gca, 'fontsize', 12)
                    cmap = makePCAcolormap_tm('DarkRose-LightRose-White-LightGreen-DarkGreen');
                    scaleColorMap(cmap, 0)
                    title({['ic ' num2str(componenti) ]})

                    % IC spectral signature
                    
                    spectral_component = model.TransformWeights(:,componenti);

                    % Outputs path
                    
                    outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\ic ' num2str(componenti) '\top loadings images\']; mkdir(outputs_path)
                    
                case 'nnmf'
                    
                    mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\factor ' num2str(componenti) '\'])
                    cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\factor ' num2str(componenti) '\'])
                    
                    % Plotting factor image
                    
                    image_component = reshape(W(:,componenti),datacube.width,datacube.height)';
                    imagesc(image_component)
                    axis off
                    axis image
                    colorbar
                    set(gca, 'fontsize', 12)
                    colormap(viridis)
                    title({['factor ' num2str(componenti) ' image ' ]})
                    
                    % Factor spectral signature

                    spectral_component = H(componenti,:);
                    
                    % Outputs path
                    
                    outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\factor ' num2str(componenti) '\top loadings images\']; mkdir(outputs_path)
                    
                case 'kmeans'
                    
                    if isnan(o_numComponents)
                        mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\top loadings images\'];
                        mkdir(outputs_path)
                    else
                        mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\top loadings images\'];
                        mkdir(outputs_path)
                    end
                    
                    % Plotting cluster image
                    
                    image_component = reshape(logical(idx.*(idx==componenti)),datacube.width,datacube.height)';
                    imagesc(image_component)
                    axis off
                    axis image
                    colorbar
                    set(gca, 'fontsize', 12)
                    colormap([ 0 0 0; clustmap(componenti,:)])
                    title({['cluster ' num2str(componenti) ' image ' ]})
                    
                    % Cluster spectral signature
                    
                    spectral_component = C(componenti,:);
                    
                case 'tsne'
                    
                    if isnan(o_numComponents)
                        mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\top loadings images\'];
                        mkdir(outputs_path)
                    else
                        mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\top loadings images\'];
                        mkdir(outputs_path)
                    end
                    
                    % Plotting cluster image
                    
                    image_component = reshape(logical(idx.*(idx==componenti)),datacube.width,datacube.height)';
                    imagesc(image_component)
                    axis off
                    axis image
                    colorbar
                    set(gca, 'fontsize', 12)
                    colormap([0 0 0; cmap(componenti+1,:)])
                    title({['cluster ' num2str(componenti) ' image ' ]})
                    
                    % Cluster spectral signature
                    
                    spectral_component = representative_spectra(componenti,:);
                
                case 'fdc'
                    
                    if isnan(o_numComponents)
                        mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\top loadings images\'];
                        mkdir(outputs_path)
                    else
                        mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\top loadings images\'];
                        mkdir(outputs_path)
                    end
                    
                    % Plotting cluster image
                    
                    image_component = reshape(logical(idx.*(idx==componenti)),datacube.width,datacube.height)';
                    imagesc(image_component)
                    axis off
                    axis image
                    colorbar
                    set(gca, 'fontsize', 12)
                    colormap([0 0 0; clustmap(componenti,:)])
                    title({['cluster ' num2str(componenti) ' image ' ]})
                    
                    % Cluster spectral signature
                    
                    spectral_component = C(componenti,:);

                case 'hierarclustering'
                    
                    if isnan(o_numComponents)
                        mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\cluster ' num2str(componenti) '\top loadings images\'];
                        mkdir(outputs_path)
                    else
                        mkdir([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        cd([ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\'])
                        outputs_path = [ mva_path file_name '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\cluster ' num2str(componenti) '\top loadings images\'];
                        mkdir(outputs_path)
                    end
                    
                    image_component = reshape(logical(idx.*(idx==componenti)),datacube.width,datacube.height)';
                    imagesc(image_component)
                    axis off
                    axis image
                    colorbar
                    set(gca, 'fontsize', 12)
                    colormap([0 0 0; clustmap(componenti,:)]); 
                    title({['cluster ' num2str(componenti) ' image ' ]})
                    
                    % Cluster spectral signature
                    
                    spectral_component = C(componenti,:);
                    
            end
            
            % Plotting spectral signature
            
            subplot(1,2,2)
            
            stem(datacube.spectralChannels(datacube_mzvalues_indexes), spectral_component, 'color', [0 0 0] , 'marker', 'none'); xlabel('\it{m/z}'); axis square;
            set(gca, 'LineWidth', 2 );
            set(gca, 'fontsize', 12);
            set(gca, 'Xlim', [min(datacube.spectralChannels(datacube_mzvalues_indexes)) max(datacube.spectralChannels(datacube_mzvalues_indexes))])
            set(gca, 'Ylim', [min(spectral_component).*1.1 max(spectral_component).*1.1])
            
            % Saving fig and tif files
            
            switch mva_type
                
                case 'pca'
                    
                    title({['PC ' num2str(componenti) ' loadings' ]})
                    
                    figname_char = [ 'pc ' num2str(componenti) ' scores and loadings.fig'];
                    tifname_char = [ 'pc ' num2str(componenti) ' scores and loadings.tif'];
                    
                case 'rica'
                    
                    title({['IC ' num2str(componenti) ' weights' ]})
                    
                    figname_char = [ 'ic ' num2str(componenti) ' transformation and weights.fig'];
                    tifname_char = [ 'ic ' num2str(componenti) ' transformation and weights.tif'];
                    
                case 'nnmf'
                    
                    title({['Factor ' num2str(componenti) ' spectra' ]})
                    
                    figname_char = [ 'factor ' num2str(componenti) ' image and spectra.fig'];
                    tifname_char = [ 'factor ' num2str(componenti) ' image and spectra.tif'];
                    
                case 'kmeans'
                    
                    title({['Cluster ' num2str(componenti) ' spectra' ]})
                    
                    figname_char = [ 'cluster ' num2str(componenti) ' image and spectra.fig'];
                    tifname_char = [ 'cluster ' num2str(componenti) ' image and spectra.tif'];
                    
                case 'nntsne'
                    
                    title({['Cluster ' num2str(componenti) ' spectrum' ]})
                    
                    figname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.fig'];
                    tifname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.tif'];
                    
                case 'tsne'
                    
                    title({'Spectral Component is not available.'})
                    
                    figname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.fig'];
                    tifname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.tif'];
                    
                case 'fdc'
                    
                    title({['Cluster ' num2str(componenti) ' spectra' ]})
                    
                    figname_char = [ 'cluster ' num2str(componenti) ' image and spectra.fig'];
                    tifname_char = [ 'cluster ' num2str(componenti) ' image and spectra.tif'];
                    
            end
            
            savefig(fig,figname_char,'compact')
            saveas(fig,tifname_char)
            
            close all
            clear fig 
            
            % Saving single ion images of the highest loadings
            
            if ~strcmpi(main_mask,'no mask')
                
                [ ~, mz_indexes ] = sort(abs(spectral_component),'descend');
                
                if numLoadings <= length(mz_indexes)
                    
                    mva_mzvalues        = datacubeonly_peakDetails(datacube_mzvalues_indexes,2);
                    mva_ion_images      = norm_data(:,datacube_mzvalues_indexes);
                    mva_peakDetails     = datacubeonly_peakDetails(datacube_mzvalues_indexes,:);
                    
                    mini_mzvalues       = mva_mzvalues(mz_indexes(1:numLoadings));
                    mini_ion_images     = mva_ion_images(:,mz_indexes(1:numLoadings));
                    mini_peak_details   = mva_peakDetails(mz_indexes(1:numLoadings),:); % Peak details need to be sorted in the intended way (e.g, highest loading peaks first)! Sii will be saved based on it.
                    
                    all_mzvalues        = double(hmdb_sample_info(:,4));
                    
                    th_mz_diff          = min(diff(totalSpectrum_mzvalues));
                    
                    mini_mzvalues_aux   = repmat(mini_mzvalues,1,size(all_mzvalues,1));
                    all_mzvalues_aux    = repmat(all_mzvalues',size(mini_mzvalues,1),1);
                    
                    mini_sample_info    = hmdb_sample_info(logical(sum(abs(mini_mzvalues_aux-all_mzvalues_aux)<th_mz_diff,1))',:);
                    
                    aux_string1 = "not assigned";
                    aux_string2 = "NA";
                    
                    aux_string_left     = repmat([ aux_string1 aux_string2 aux_string2 ],1,1);
                    aux_string_right    = repmat([ aux_string2 aux_string2 aux_string1 repmat(aux_string2, 1, size(mini_sample_info,2)-7) ],1,1);
                    
                    mini_sample_info_indexes = [];
                    for mzi = mini_mzvalues'
                        if sum(abs(mzi-double(mini_sample_info(:,4)))<th_mz_diff,1)
                            mini_sample_info_indexes = [
                                mini_sample_info_indexes
                                find(abs(mzi-double(mini_sample_info(:,4)))<th_mz_diff,1,'first')
                                ];
                        else
                            mini_sample_info_indexes = [
                                mini_sample_info_indexes
                                size(mini_sample_info,1)+1
                                ];
                            mini_sample_info = [
                                mini_sample_info
                                aux_string_left string(mzi) aux_string_right
                                ];
                        end
                    end
                    
                    % Generating the figures and saving them
                    
                    f_saving_sii_files( outputs_path, mini_sample_info, mini_sample_info_indexes, mini_ion_images, datacube.width, datacube.height, mini_peak_details, pixels_num, totalSpectrum_intensities, totalSpectrum_mzvalues, fig_ppmTolerance, 1 )
                    
                else
                    
                    disp('!!! The number of loadings is higher than the number of peaks used to run the mva.')
                    
                end
                
            end
        end
    end
    
end