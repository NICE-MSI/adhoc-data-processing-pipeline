function [ reduced_x, loss, tsne_parameters ] = f_tsne( x )

% This function runs t-sne (using the Matlab function "tsne") using a
% variety of perplexities, distances, exaggerations, and principal
% component number.
% 
% Inputs:
% x - data
% Outputs:
% reduced_x - data in the 3D space (in the reduced space)
% loss - m

% Run t-sne for a set of different combinations of parameters

[ reduced_x0, loss, tsne_parameters ] = f_tsne_with_diff_parameters( x );

reduced_x = reduced_x0;
for k = 1:3 % 3D space
    reduced_x(:,k) = (reduced_x0(:,k) - min(reduced_x0(:,k))) ./ max(reduced_x0(:,k) - min(reduced_x0(:,k)));
end

end

function [ y, loss, tsne_parameters ] = f_tsne_with_diff_parameters( x )

step = ceil(1/5000*size(x,1)); % 0.5% of the original data
NumDimensions = 3;

small_x = x(step:step:(end-step),:);

loss0 = Inf;
for Distance = "correlation" % [ "euclidean", "cosine" , "correlation" ]
    for Exaggeration = [ 4, 16, 64 ] % size of natural clusters in data
        for Perplexity = [ 50, 100, 500 ]
            
            disp(join([ '! Distance: ' , Distance, ' Exaggeration: ', num2str(Exaggeration), ' Perplexity: ', num2str(Perplexity)]))
            
            [ ~, loss1 ] = tsne( small_x, 'NumDimensions' , NumDimensions, 'Distance' , char(Distance), 'Exaggeration', Exaggeration, 'Perplexity', Perplexity );
            
            disp([ '* Loss: ' num2str(loss1) ])
            
            if loss1<loss0                
                loss0 = loss1;
                tsne_parameters.distance = Distance;
                tsne_parameters.exaggeration = Exaggeration;
                tsne_parameters.numdimensions = NumDimensions;
                tsne_parameters.perplexity = Perplexity;
            end
        end
    end
end

Distance = tsne_parameters.distance;
Exaggeration = tsne_parameters.exaggeration;
Perplexity = tsne_parameters.perplexity;

disp(join([ '! (selected parameters) Distance: ' , Distance, ' Exaggeration: ', num2str(Exaggeration), ' Perplexity: ', num2str(Perplexity)]))

[ y, loss ] = tsne( x, 'NumDimensions' , NumDimensions, 'Distance' , char(Distance), 'Exaggeration', Exaggeration, 'Perplexity', Perplexity );

disp([ '* Loss: ' num2str(loss) ]) 

end