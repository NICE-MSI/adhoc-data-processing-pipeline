function [ table2plot, distributionsM ] = f_mva_output_table( mva_output, data_cell )

% Creates a table with the number of unique clusters for each small mask, 
% and a .mat variable with the number of pixels assigned to each cluster, 
% and for each small mask.
%
% Inputs
% mva_output (double, array) - MVA output (e.g. clusters map, PC 1
% image, t-sne maps, etc.) for all imzmls
% data_cell (struct, cell ) - small mask, pixel coordinates, indiviudal
% images height and width, for each imzml
%
% Outputs
% table2plot (string, 2D array) - table with the number of unique clusters 
% for each small mask (rows: clusters, columns: small masks)
% distributionsM (double, 2D array) - variable with the MVAs outputs for 
% each small mask (rows: pixels, columns: small masks)

table2plot = string(zeros(length(unique(mva_output))+1,length(data_cell)+1));
distributionsM = NaN*ones(1,length(data_cell));

endi = 0;
for file_index = 1:length(data_cell) % iterating through the imzml and small masks pairs
    
    table2plot(1,file_index+1) = data_cell{file_index}.id;
    if file_index==1
        table2plot(1,1) = "cluster id";
        aux = string(unique(mva_output));
        table2plot(2:end-1,1) = aux(2:end);
        table2plot(end,1) = "# clusters per tissue";
    end
    
    starti = endi + 1;
    endi = starti+data_cell{file_index}.width*data_cell{file_index}.height-1;
    
    mva_output0 = mva_output(starti:endi,:); % grabing MVAs results for the current imzml and small mask pair
    mva_output0(~data_cell{file_index}.mask) = []; % removing pixels outside the small mask
        
    % initiating distributionsM 
    
    if size(mva_output0,1)>size(distributionsM,1)
        distributionsM = [ distributionsM; NaN*ones(size(mva_output0,1)-size(distributionsM,1),size(distributionsM,2)) ];        
    end
    
    for k = unique(mva_output)'
        if k>0
            if sum(mva_output0==k)>=0.05*sum(mva_output0>0)
                table2plot(k+1,file_index+1) = string(k);
            end
            distributionsM(1:size(mva_output0,1),file_index) = mva_output0;
        end
    end
    
end

table2plot(end,2:end) = string(sum(logical(double(table2plot(2:end,2:end))),1));
