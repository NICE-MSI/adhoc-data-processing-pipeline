function [ mzvalues, names, labels ] = f_molecules_list_mat(csv_file_path_list, labels_path_list)

% This function reads a csv file in which column A consists of the names of
% relevant molecules and column B of their monoisotopic masses.
%
% Inputs:
% csv_file_path_list - list of paths (strings) to csv files that contains relevant
% molecules
% labels_path_list - list of names (strings) of lists of relevant molecules
%
% Outputs:
% mzvalues - list of doubles with the monoisotopic masses of the relevant molecules
% names - list of strings specifying the names of the relevant molecules
% labels - list of strings specifying the names of the groups of relevant molecules

names = string([]);
mzvalues = [];
labels = string([]);

i = 0;
for csv_file_path = csv_file_path_list
    i = i + 1;
    [ ~, ~, cell ]  = xlsread(csv_file_path);
    if ~isnan(cell{1})
        mzvalues    = [ mzvalues; cell2mat(cell(:,2)) ];
        names       = [ names; string(cell(:,1)) ];
        labels      = [ labels; repmat(labels_path_list(1,i), size(cell,1), 1) ];
    end
end