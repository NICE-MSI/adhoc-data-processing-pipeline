function image2plot = f_mva_output_collage( mva_output, data_cell, outputs_xy_pairs )

% Creates an image with the outputs of the MVAs (mva_output), using the
% pixel coordinates in the original datacubes (data_cell) and the
% grid coordinates in outputs_xy_pairs.
%
% Inputs
% mva_output (double, array) - MVA output (e.g. clusters map, PC 1
% image, t-sne maps, etc.) for all imzmls
% data_cell (struct, cell ) - small mask, pixel coordinates, indiviudal
% images height and width, for each imzml
% outputs_xy_pairs (double, 2D array ) - x and y coordinates to place the
% MVA results in the grid
%
% Outputs
% image2plot (double, 2D array) - composite MVA output (all imzmls files,
% masked with all small masks, and organised in a large grid)


min_cn = 0;
min_rn = 0;
image_cell2plot = {};
endi = 0;
for file_index = 1:length(data_cell) % iterating through the imzml and small masks pairs
    
    % Defining the indicies of the start and end of each imzml (note that 
    % mva_output contains all the pairs of imzml and small masks)
                   
    starti = endi + 1;
    endi = starti+data_cell{file_index}.width*data_cell{file_index}.height-1;
    
    % Reducing the complete MVAs output to that related to the current imzml
    % and small mask only
    
    mva_output0 = mva_output(starti:endi,:); % MVAs results corresponde to all pixels in the imzml file.
    mva_output0(~data_cell{file_index}.mask) = []; % Removing all pixels with value equal to 0
    
    % Grabbing the pixel coordinates in the imzml space
    
    x_coord = data_cell{file_index}.pixels_coord(:,1);
    y_coord = data_cell{file_index}.pixels_coord(:,2);
    
    % Updating the pixel coordinates in the imzml space to produce the the
    % smallest possible image (minimise 0s)
    
    x_coord = x_coord-min(x_coord)+1; 
    y_coord = y_coord-min(y_coord)+1;
    
    % Bulding the 2D image related to the current imzml and small mask
    
    image2plot = zeros(max(x_coord), max(y_coord));
    for i = 1:size(x_coord,1); image2plot(x_coord(i),y_coord(i)) = mva_output0(i); end
    
    % Gathering all 2D images in one large cell
       
    image_cell2plot{outputs_xy_pairs(file_index,1),outputs_xy_pairs(file_index,2)} = image2plot;
    
    % Recording the minimum number of columns and rows that will be used
    % when assembling the final composite 2D image that shows the results
    % of the MVA
    
    min_cn = max(min_cn,size(image2plot,2));
    min_rn = max(min_rn,size(image2plot,1));
    
end

% Building the final composite 2D image that shows the results of the MVA

image2plot = [];
for ri = 1:size(image_cell2plot,1) % iterating through the rows of the cell (which correspond to the rows of the final 2D image grid)
    
    image2plot3 = [];
    for ci = 1:size(image_cell2plot,2) % iterating through the columns of the cell (which correspond to the columns of the final 2D image grid)
        
        % Building each final 2D image, using the minimum number of rows
        % and columns to center each one of these in their position in the
        % final grid
        
        image2plot0 = image_cell2plot{ri,ci};
        image2plot1 = [ zeros(size(image2plot0,1), floor(max(0,(min_cn-size(image2plot0,2))/2))), image2plot0, zeros(size(image2plot0,1), ceil(max(0,(min_cn-size(image2plot0,2))/2))) ];
        image2plot2 = [ zeros(floor(max(0,(min_rn-size(image2plot1,1))/2)),size(image2plot1,2)); image2plot1; zeros(ceil(max(0,(min_rn-size(image2plot1,1))/2)),size(image2plot1,2)) ];
        image2plot3 = [ image2plot3 image2plot2 ];
        
    end
    
    % Concatenating rows of individual 2D images to build the final composite 2D image 
    
    image2plot = [ image2plot; image2plot3 ];
    
end
