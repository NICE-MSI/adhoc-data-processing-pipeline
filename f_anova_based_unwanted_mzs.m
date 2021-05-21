function mzvalues2discard = f_anova_based_unwanted_mzs( filesToProcess, main_mask_list, dataset_name, norm_type, criteria)

% This function creates a list of masses based on the ANOVA results.
%
% Inputs:
% filesToProcess - Matlab struct created by matlab function dir,
% containing the list of files to process and their locations / paths
% main_mask_list - array with names of the main masks i.e. those used to
% generate the representative spectrum
% dataset_name - the name of the combined dataset
% norm_list - list of strings specifying the normalisations of interest
% criteria - Matlab struct which contains the following information:
% * criteria.file - string with the name of the file with the ANOVA results
% * criteria.column - cell of strings which match the names of the columns of the ANOVA results to be used for filtering
% * criteria.ths_type - cell of strings with the rules for filtering (options: "equal_below", "below", "equal_above", "above")
% * criteria.ths_value - double between 0 and 1, usually 0.01 or 0.05
% * criteria.combination - string defining the rule to combine the multiple filtering criteria (options: "and", "or")
%
% Output:
% mzvalues2discard - a list of masses (peaks) that survived the filtering criteria

filesToProcess = f_unique_extensive_filesToProcess(filesToProcess); % collecting the unique imzmls that need to be loaded

csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];

% Reading information regarding the location of all the pipeline outputs

[ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);

% Defining the paths that will be required

anova_path = [ char(outputs_path) '\anova\' filesep char(dataset_name) filesep ];

for main_mask = main_mask_list % iterating through main masks
    
    cd([ anova_path char(main_mask) '\' char(norm_type) ])
    
    load(char(criteria.file), 'anova_analysis_table') % loading ANOVA results
    
    columns = anova_analysis_table(1,:); % grabing the names of all columns in the anova results 
    measmz = double(anova_analysis_table(2:end,ismember(columns, "meas mz"))); % grabing the column with the masses
    
    pvalues = NaN*ones(size(anova_analysis_table,1)-1,length(criteria.column));
    logical_pvalues = pvalues;
    for i = 1:length(criteria.column) % iterating through filtering criteria
        pvalues(:,i) = double(anova_analysis_table(2:end,ismember(columns, criteria.column{i})));
        if strcmpi(criteria.ths_type{i},'equal_below')
            logical_pvalues(:,i) = double(anova_analysis_table(2:end,ismember(columns, criteria.column{i}))) <= criteria.ths_value{i};
        elseif strcmpi(criteria.ths_type{i},'below')
            logical_pvalues(:,i) = double(anova_analysis_table(2:end,ismember(columns, criteria.column{i}))) < criteria.ths_value{i};
        elseif strcmpi(criteria.ths_type{i},'equal_above')
            logical_pvalues(:,i) = double(anova_analysis_table(2:end,ismember(columns, criteria.column{i}))) >= criteria.ths_value{i};
        elseif  strcmpi(criteria.ths_type{i},'above')
            logical_pvalues(:,i) = double(anova_analysis_table(2:end,ismember(columns, criteria.column{i}))) > criteria.ths_value{i};
        end
    end
    
    % Defining the list of masses that survived the filtering criteria
    
    if strcmpi(criteria.combination,'or')
        mzvalues2discard = unique(double(measmz(logical(sum(logical_pvalues,2)),1)));
    else
        mzvalues2discard = unique(double(measmz(logical(prod(logical_pvalues,2)),1)));
    end
    
end
