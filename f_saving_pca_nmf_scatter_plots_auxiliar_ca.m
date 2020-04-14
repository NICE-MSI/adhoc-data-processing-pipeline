function f_saving_pca_nmf_scatter_plots_auxiliar_ca( mva_type, mva_path, dataset_name, main_mask, norm_type, numComponents, datacube_cell, outputs_rgb_codes )

if ~isnan(numComponents)
    cd([ mva_path char(dataset_name) '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\'])    
else    
    cd([ mva_path char(dataset_name) '\' char(main_mask) '\' char(mva_type) '\' char(norm_type) '\'])
end

load('datacube_mzvalues_indexes')

o_numComponents = NaN;

if sum(datacube_mzvalues_indexes) > 0
    
    % Loading MVA results
    
    switch mva_type
        
        case 'pca'
            
            load('datacube_mzvalues_indexes')
            load('firstCoeffs')
            load('firstScores')
            load('explainedVariance')
            
            numComponentsSaved = size(firstCoeffs,2);
            o_numComponents = numComponents;
            numComponents = numComponentsSaved;
            
        case 'nnmf'
            
            load('datacube_mzvalues_indexes')
            load('W')
            load('H')
            
            numComponentsSaved = size(W,2);
            o_numComponents = numComponents;
                        
%         case 'nntsne'
%             
%             load('datacube_mzvalues_indexes')
%             load('idx')
%             load('cmap')
%             load('rgbData')
%             load('outputSpectralContriubtion')
%             
%             numComponentsSaved = max(idx);
%             o_numComponents = numComponents;
%             numComponents = numComponentsSaved;
%             
%         case 'tsne'
%             
%             load('datacube_mzvalues_indexes')
%             load('idx')
%             load('cmap')
%             load('rgbData')
%             
%             numComponentsSaved = max(idx);
%             o_numComponents = numComponents;
%             numComponents = numComponentsSaved;
            
    end
    
    if numComponents > numComponentsSaved
        disp('!!! Error - The currently saved MVA results do not comprise all the information you want to look at! Please run the function f_running_mva again.')
        return
    else
                
        first_componenet_read = 1;
        
        for componenti = 1:numComponents
                        
            switch mva_type
                
                case 'pca'
                                        
                    component_by_file = f_pca_nmf_scatter_plots_colouring( firstScores(:,componenti), datacube_cell );
                    % component_by_file = f_pca_nmf_scatter_plots_colouring( firstCoeffs(:,componenti), datacube_cell );                   
                    
                    if first_componenet_read
                        component2plot = NaN*ones(size(component_by_file,1),size(component_by_file,2),numComponents);
                        first_componenet_read = 0;
                    end
                    
                    component2plot(:,:,componenti) = component_by_file;
                    
                case 'nnmf'
                    
                    mkdir([ mva_path char(dataset_name) '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\factor ' num2str(componenti) '\'])
                    cd([ mva_path char(dataset_name) '\' char(main_mask) '\' char(mva_type) ' ' num2str(numComponents) ' components\' char(norm_type) '\factor ' num2str(componenti) '\'])
                    
                    %                     image_component = f_mva_output_collage( W(:,componenti), datacube_cell, outputs_xy_pairs );
                    %
                    %                     spectral_component = H(componenti,:);
                    
            end
            
        end
        
        for component_x = 1
            for component_y = 3
                %for component_z = 3
                    figure; hold on;                    
                    for file_index = 1:size(component2plot,2)
                      	scatter(component2plot(:,file_index,component_x),component2plot(:,file_index,component_y),0.1,colors(file_index,1:3))
                 %       scatter3(component2plot(:,file_index,component_x),component2plot(:,file_index,component_y),component2plot(:,file_index,component_z),1,colors(file_index,1:3))
                    end
                %end
            end
        end
                        
            switch mva_type
                
                case 'pca'
                    
                    title({['PC ' num2str(componenti) ' (exp. var. ' num2str(round(explainedVariance(componenti,1),2)) '%) loadings' ]})
                    
                    figname_char = [ 'pc ' num2str(componenti) ' scores and loadings.fig'];
                    tifname_char = [ 'pc ' num2str(componenti) ' scores and loadings.tif'];
                    svgname_char = [ 'pc ' num2str(componenti) ' scores and loadings.svg'];
                    
                case 'nnmf'
                    
                    title({['Factor ' num2str(componenti) ' spectrum' ]})
                    
                    figname_char = [ 'factor ' num2str(componenti) ' image and spectrum.fig'];
                    tifname_char = [ 'factor ' num2str(componenti) ' image and spectrum.tif'];
                    svgname_char = [ 'factor ' num2str(componenti) ' image and spectrum.svg'];
                    
                case 'kmeans'
                    
                    title({['Cluster ' num2str(componenti) ' spectrum' ]})
                    
                    figname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.fig'];
                    tifname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.tif'];
                    svgname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.svg'];
                    
                case 'nntsne'
                    
                    title({['Cluster ' num2str(componenti) ' spectrum' ]})
                    
                    figname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.fig'];
                    tifname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.tif'];
                    svgname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.svg'];
                    
                case 'tsne'
                    
                    title({['Cluster ' num2str(componenti) ' spectrum' ]})
                    
                    figname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.fig'];
                    tifname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.tif'];
                    svgname_char = [ 'cluster ' num2str(componenti) ' image and spectrum.svg'];
                    
            end
            
            savefig(fig,figname_char,'compact')
            saveas(fig,tifname_char)
            saveas(fig,svgname_char)
            
            close all
            clear fig
            
            
        
    end
    
end