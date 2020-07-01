function black_meas_mz = f_anova_based_meas_mz_array( filesToProcess, main_mask_list, norm_list, anova_effect_1_name, anova_effect_2_name, column1, equal_above_or_below1, threshold1, column2, equal_above_or_below2, threshold2)

filesToProcess = f_unique_extensive_filesToProcess(filesToProcess); % This function collects all files that need to have a common axis.

csv_inputs = [ filesToProcess(1).folder '\inputs_file' ];

[ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);

% spectra_details_path = [ char(outputs_path) '\spectra details\' ];
anova_path = [ char(outputs_path) '\anova\' ]; if ~exist(anova_path, 'dir'); mkdir(anova_path); end

for main_mask = main_mask_list
    
    for norm_type = norm_list
        
        cd([ anova_path char(main_mask) '\' char(norm_type) ])
        
        load([ 'anova ' char(anova_effect_1_name), ' & ', char(anova_effect_2_name), '.mat' ],'anova_analysis_table' )
        
        columns = anova_analysis_table(1,:);
                
        pvalues1 = double(anova_analysis_table(2:end,ismember(columns, column1)));
        pvalues2 = double(anova_analysis_table(2:end,ismember(columns, column2)));
        
        measmz = double(anova_analysis_table(2:end,ismember(columns, "meas mz")));
                
        if strcmpi(equal_above_or_below1,'equal_below')
            bol1 = (pvalues1 <= threshold1);
        elseif strcmpi(equal_above_or_below1,'below')
            bol1 = (pvalues1 < threshold1);
        elseif strcmpi(equal_above_or_below1,'equal_above')
            bol1 = (pvalues1 >= threshold1);
        elseif  strcmpi(equal_above_or_below1,'above')
            bol1 = (pvalues1 > threshold1);
        end
        
        if strcmpi(equal_above_or_below2,'equal_below')
            bol2 = (pvalues2 <= threshold2);
        elseif strcmpi(equal_above_or_below2,'below')
            bol2 = (pvalues2 < threshold2);
        elseif strcmpi(equal_above_or_below2,'equal_above')            
            bol2 = (pvalues2 >= threshold2);
        elseif  strcmpi(equal_above_or_below2,'above')
            bol2 = (pvalues2 > threshold2);
            
        end
        
        black_meas_mz = unique(double(measmz(logical(bol1+bol2),1)));
        
    end
    
end
