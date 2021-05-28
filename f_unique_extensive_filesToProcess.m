function filesToProcess = f_unique_extensive_filesToProcess(extensive_filesToProcess)

% This function removes repeats of imzml files in a Matlab struct created
% using the function "dir".


string_files = string([]);
for i = 1:length(extensive_filesToProcess)
    string_files(i,1) = string(extensive_filesToProcess(i).name);
end

[~, ii] = unique(string_files);

filesToProcess = extensive_filesToProcess(ii);