function f_anova_based_normalisation( filesToProcess, main_mask_list, norm_type, criteria)

filesToProcess = f_unique_extensive_filesToProcess(filesToProcess); % This function collects all files that need to have a common axis.

csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];

[ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);

spectra_details_path = [ char(outputs_path) '\spectra details\' ];
anova_path = [ char(outputs_path) '\anova\' ];

for main_mask = main_mask_list
    
    cd([ anova_path char(main_mask) '\' char(norm_type) ])
    
    load(char(criteria.file), 'anova_analysis_table')
    
    columns = anova_analysis_table(1,:);
    
    measmz0 = double(anova_analysis_table(2:end,ismember(columns, "meas mz")));
    Fvalues0 = double(anova_analysis_table(2:end,ismember(columns, criteria.column{i})));
    
    [~, uniquei] = unique(measmz0);
    
    measmz = measmz0(uniquei,:);
    Fvalues = Fvalues0(uniquei,:);
    
    load([spectra_details_path char(main_mask) filesep char(norm_type)])
    
end
