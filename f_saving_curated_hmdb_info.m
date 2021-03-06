function new_hmdb_sample_info = f_saving_curated_hmdb_info( hmdb_sample_info, relevant_lists_sample_info )

% Curates the top loadings information table (hmdb_sample_info)
%
% Inputs:
% hmdb_sample_info (string, 2D array) - table with peak assignments to HMDB information
% relevant_lists_sample_info (string, 2D array) - table with peak assignments to relevant lists of molecules information
%
% Outputs:
% new_hmdb_sample_info (string, 2D array) - curated table with peak assignments to HMDB and relevant lists of molecules information

% Sort by monoisotopic mass

[ ~, i1 ] = sort(double(hmdb_sample_info(:,12)),'ascend');

hmdb_sample_info1 = hmdb_sample_info(i1,:);

% Sort by measured mass

[ ~, i2 ] = sort(double(hmdb_sample_info1(:,4)),'ascend');

hmdb_sample_info2 = hmdb_sample_info1(i2,:);

log_diff = find(logical(diff(double(hmdb_sample_info2(:,12)))+diff(double(hmdb_sample_info2(:,4)))))';

i = 1;
starti = 1;
new_hmdb_sample_info = strings(length(log_diff),10);
for endi = log_diff
    
    % molecule name
    
    long_string0 = unique(hmdb_sample_info2(starti:endi,1),'stable');
    long_string = reshape([long_string0 repmat(", ",size(long_string0,1),1)]',1,[]);
    long_string = char(strjoin(long_string(1:end-1)));
    long_string = long_string(1,1:min(size(long_string,2),32000)); % to avoid the excel cell breaking issue
    new_hmdb_sample_info(i,1) = string(long_string);
    
    % monoisotopic mass
    
    new_hmdb_sample_info(i,2) = num2str(unique(double(hmdb_sample_info2(starti:endi,12)),'stable'),'%1.12f');
    
    % measured mass
    
    new_hmdb_sample_info(i,3) = unique(hmdb_sample_info2(starti:endi,4),'stable');
    
    % adduct form
    
    long_string0 = unique(hmdb_sample_info2(starti:endi,3),'stable');
    long_string = reshape([long_string0 repmat(", ",size(long_string0,1),1)]',1,[]);
    new_hmdb_sample_info(i,4) = strjoin(long_string(1:end-1));
    
    % ppm error
    
    long_string0 = unique(hmdb_sample_info2(starti:endi,8),'stable');
    long_string = reshape([long_string0 repmat(", ",size(long_string0,1),1)]',1,[]);
    new_hmdb_sample_info(i,5) = strjoin(long_string(1:end-1));
    
    % database name
    
    database_rows_mono = strcmpi(relevant_lists_sample_info(:,12),num2str(unique(double(hmdb_sample_info2(starti:endi,12)),'stable'),'%1.12f')); % Monoisotopic mass comparison
    
    long_string0 = unique(relevant_lists_sample_info(database_rows_mono,7),'stable');
    long_string = reshape([long_string0 repmat(", ",size(long_string0,1),1)]',1,[]);
    new_hmdb_sample_info(i,6) = strjoin(long_string(1:end-1));
    
    % kingdom
    
    long_string0 = unique(hmdb_sample_info2(starti:endi,14),'stable');
    long_string = reshape([long_string0 repmat(", ",size(long_string0,1),1)]',1,[]);
    long_string = char(strjoin(long_string(1:end-1)));
    if ~isempty(long_string)
        long_string = long_string(1,1:min(size(long_string,2),32000)); % to avoid the excel cell breaking issue
    end
    new_hmdb_sample_info(i,7) = string(long_string);
    
    % super class
    
    long_string0 = unique(hmdb_sample_info2(starti:endi,15),'stable');
    long_string = reshape([long_string0 repmat(", ",size(long_string0,1),1)]',1,[]);
    long_string = char(strjoin(long_string(1:end-1)));
    if ~isempty(long_string)
        long_string = long_string(1,1:min(size(long_string,2),32000)); % to avoid the excel cell breaking issue
    end
    new_hmdb_sample_info(i,8) = string(long_string);
    
    % class
    
    long_string0 = unique(hmdb_sample_info2(starti:endi,16),'stable');
    long_string = reshape([long_string0 repmat(", ",size(long_string0,1),1)]',1,[]);
    long_string = char(strjoin(long_string(1:end-1)));
    if ~isempty(long_string)
        long_string = long_string(1,1:min(size(long_string,2),32000)); % to avoid the excel cell breaking issue
    end
    new_hmdb_sample_info(i,9) = string(long_string);
    
    % sub class
    
    long_string0 = unique(hmdb_sample_info2(starti:endi,17),'stable');
    long_string = reshape([long_string0 repmat(", ",size(long_string0,1),1)]',1,[]);
    long_string = char(strjoin(long_string(1:end-1)));
    if ~isempty(long_string)
        long_string = long_string(1,1:min(size(long_string,2),32000)); % to avoid the excel cell breaking issue
    end
    new_hmdb_sample_info(i,10) = string(long_string);
    
    i = i + 1;
    starti = endi+1;
    
end