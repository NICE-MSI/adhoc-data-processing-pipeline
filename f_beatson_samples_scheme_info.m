function [ extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs ] = f_beatson_samples_scheme_info( dataset_name, background, check_datacubes_size )

switch dataset_name
    
        case "neg DESI intracolonics vbh + R2B2 set"
            
            main_mask_list = "tissue only"; % tissue only
            clear extensive_filesToProcess
            
            data_folders = { 'D:\veal-brain-homogenate-study\vbh data\' };% Datasets
            
            dataset_name = '*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess = filesToProcess([ 16 21 33 ]);
            smaller_masks_list = [ "vbh-20201127"; "vbh-20201202"; "vbh-20201207" ];
            
            data_folders = { 'D:\veal-brain-homogenate-study\tumours data\' };% Datasets
            
            dataset_name = '*R2B2_S19*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(4:5,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S19-bg"; "apc-kras-2-R2-B2-S19-bg" ];
            extensive_filesToProcess(6:9,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S19-bg"; "apc-kras-3-R2-B2-S19-bg"; "apc-kras-5-R2-B2-S19-bg"; "apc-kras-6-R2-B2-S19-bg" ];
            
            dataset_name = '*R2B2_S20*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(10:11,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S20-bg"; "apc-kras-2-R2-B2-S20-bg" ];
            extensive_filesToProcess(12:13,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S20-bg"; "apc-kras-3-R2-B2-S20-bg" ];
            extensive_filesToProcess(14,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S20-bg" ];
            
            dataset_name = '*R2B2_S21*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(15:16,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S21-bg"; "apc-kras-2-R2-B2-S21-bg" ];
            extensive_filesToProcess(17:18,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S21-bg"; "apc-kras-3-R2-B2-S21-bg" ];
            extensive_filesToProcess(19,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S21-bg" ];
            extensive_filesToProcess(20,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-6-R2-B2-S21-bg" ];
            
            outputs_xy_pairs = [
                1 1; 1 3; 1 6;
                2 1; 4 1; 3 2; 5 2; 6 2; 7 2;
                2 3; 4 3; 3 4; 5 4; 6 5;
                2 6; 4 6; 3 7; 5 7; 6 8; 7 9
                ];
    
    case "neg DESI intracolonics homogenate set with background"
        
        main_mask_list = "tissue only"; % tissue only
        data_folders = { 'D:\veal-brain-homogenate-study\tumours data\' };% Datasets
        clear extensive_filesToProcess
        
        dataset_name = '*R1B1_s28*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(1:3,:) = filesToProcess(2,:);
        smaller_masks_list = [ "apc-3-R1-B1-S28-bg"; "apc-5-R1-B1-S28-bg"; "apc-kras-2-R1-B1-S28-bg" ];
        extensive_filesToProcess(4,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S28-bg" ];
        extensive_filesToProcess(5,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S28-bg" ];
        
        dataset_name = '*R2B3_S5*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(6:7,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S5-bg"; "wt-2-R2-B3-S5-bg" ];
        extensive_filesToProcess(8,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "wt-3-R2-B3-S5-bg" ];
        extensive_filesToProcess(9,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "wt-4-R2-B3-S5-bg" ];
        
        dataset_name = '*R2B1_S16*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(10:12,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S16-bg"; "apc-3-R2-B1-S16-bg"; "apc-kras-1-R2-B1-S16-bg" ];
        extensive_filesToProcess(13:14,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S16-bg"; "apc-kras-5-R2-B1-S16-bg" ];
        
        dataset_name = '*R2B2_S19*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(15:16,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S19-bg"; "apc-kras-2-R2-B2-S19-bg" ];
        extensive_filesToProcess(17:20,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S19-bg"; "apc-kras-3-R2-B2-S19-bg"; "apc-kras-5-R2-B2-S19-bg"; "apc-kras-6-R2-B2-S19-bg" ];
        
        dataset_name = '*R2B3_S6*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(21:24,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S6-bg"; "wt-2-R2-B3-S6-bg"; "wt-3-R2-B3-S6-bg"; "wt-4-R2-B3-S6-bg" ];
        
        dataset_name = '*R2B1_S38*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(25:27,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-R2-B1-S38-bg"; "apc-kras-4-R2-B1-S38-bg"; "apc-kras-5-R2-B1-S38-bg" ];
        
        dataset_name = '*R2B2_S20*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(28:29,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S20-bg"; "apc-kras-2-R2-B2-S20-bg" ];
        extensive_filesToProcess(30:31,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S20-bg"; "apc-kras-3-R2-B2-S20-bg" ];
        extensive_filesToProcess(32,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S20-bg" ];
        
        dataset_name = '*R2B2_S21*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(33:34,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S21-bg"; "apc-kras-2-R2-B2-S21-bg" ];
        extensive_filesToProcess(35:36,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S21-bg"; "apc-kras-3-R2-B2-S21-bg" ];
        extensive_filesToProcess(37,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S21-bg" ];
        extensive_filesToProcess(38,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-6-R2-B2-S21-bg" ];
        
        dataset_name = '*R1B1_s29*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(39,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S29-bg" ];
        extensive_filesToProcess(40,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S29-bg" ];
        extensive_filesToProcess(41,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-5-R1-B1-S29-bg" ];
        extensive_filesToProcess(42,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S29-bg" ];
        extensive_filesToProcess(43,:) = filesToProcess(5,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S29-bg" ];
        
        outputs_xy_pairs = [
            1 1; 2 1; 4 1; 3 1; 5 1;
            1 2; 2 2; 3 2; 4 2;
            1 3; 2 3; 4 3; 5 3; 6 3;
            1 4; 4 4; 2 4; 5 4; 6 4; 7 4;
            1 5; 2 5; 3 5; 4 5;
            1 6; 4 6; 5 6;
            1 7; 4 7; 2 7; 5 7; 6 7;
            1 8; 4 8; 2 8; 5 8; 6 8; 7 8;
            4 9; 1 9; 2 9; 5 9; 3 9;
            ];
        
    case "neg DESI veal brain homogenate"
        
        main_mask_list = "no mask"; % tissue only
        data_folders = { 'D:\veal-brain-homogenate-study\data\' };% Datasets
        clear extensive_filesToProcess
        
        dataset_name = '*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        filesToProcess = filesToProcess([ 13 16 17 21 33 38 ]);
        
        extensive_filesToProcess = filesToProcess;
        smaller_masks_list = [
            "vbh-20201126", "vbh-20201127", "vbh-20201130", "vbh-20201202", "vbh-20201207", "vbh-20201209"
            ];
        outputs_xy_pairs = [
            1 1; 1 2; 1 3; 1 4; 1 5; 1 6
            ];
        
    case "neg DESI intracolonics tumour & normal only"
        
        main_mask_list = "tissue only"; % tissue only
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Data\neg DESI\Xevo V3 Sprayer\Selected Set\' };% Datasets
        clear extensive_filesToProcess
        
        dataset_name = '*20190815_intracolonics_neg_slide9*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(1:10,:) = filesToProcess(1,:);
        smaller_masks_list = [
            "apc-3-tumour-R1-B1-S9";        "apc-5-tumour-R1-B1-S9";    "apc-6-tumour-R1-B1-S9"; "apc-kras-2-tumour-R1-B1-S9";   "apc-kras-7-tumour-R1-B1-S9"
            "apc-3-normal-R1-B1-S9";        "apc-5-normal-R1-B1-S9";    "apc-6-normal-R1-B1-S9"; "apc-kras-2-normal-R1-B1-S9";   "apc-kras-7-normal-R1-B1-S9"
            ];
        
        dataset_name = '*R1B1_S26*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(11,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-2-tumour-R1-B1-S26" ];
        extensive_filesToProcess(12:14,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-tumour-R1-B1-S26"; "apc-5-tumour-R1-B1-S26"; "apc-kras-7-tumour-R1-B1-S26" ];
        extensive_filesToProcess(15,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-tumour-R1-B1-S26" ];
        extensive_filesToProcess(16,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-2-normal-R1-B1-S26" ];
        extensive_filesToProcess(17:19,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-normal-R1-B1-S26"; "apc-5-normal-R1-B1-S26"; "apc-kras-7-normal-R1-B1-S26" ];
        extensive_filesToProcess(20,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-normal-R1-B1-S26" ];
        
        dataset_name = '*R1B1_s28*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(21:23,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-tumour-R1-B1-S28"; "apc-5-tumour-R1-B1-S28"; "apc-kras-2-tumour-R1-B1-S28" ];
        extensive_filesToProcess(24,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-tumour-R1-B1-S28" ];
        extensive_filesToProcess(25,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-7-tumour-R1-B1-S28" ];
        extensive_filesToProcess(26:27,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-normal-R1-B1-S28"; "apc-5-normal-R1-B1-S28" ];
        extensive_filesToProcess(28,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-normal-R1-B1-S28" ];
        extensive_filesToProcess(29,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-7-normal-R1-B1-S28" ];
        
        dataset_name = '*R1B1_s30*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(30,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-2-tumour-R1-B1-S30" ];
        extensive_filesToProcess(31,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-tumour-R1-B1-S30" ];
        extensive_filesToProcess(32,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-5-tumour-R1-B1-S30" ];
        extensive_filesToProcess(33,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-tumour-R1-B1-S30" ];
        extensive_filesToProcess(34,:) = filesToProcess(5,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-7-tumour-R1-B1-S30" ];
        extensive_filesToProcess(35,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-normal-R1-B1-S30" ];
        extensive_filesToProcess(36,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-5-normal-R1-B1-S30" ];
        extensive_filesToProcess(37,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-normal-R1-B1-S30" ];
        extensive_filesToProcess(38,:) = filesToProcess(5,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-7-normal-R1-B1-S30" ];
        
        dataset_name = '*R2B1_S13*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(39:41,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-tumour-R2-B1-S13"; "apc-3-tumour-R2-B1-S13"; "apc-kras-1-tumour-R2-B1-S13" ];
        extensive_filesToProcess(42:43,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-4-tumour-R2-B1-S13"; "apc-kras-5-tumour-R2-B1-S13" ];
        extensive_filesToProcess(44:46,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-normal-R2-B1-S13"; "apc-3-normal-R2-B1-S13"; "apc-kras-1-normal-R2-B1-S13" ];
        extensive_filesToProcess(47,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-5-normal-R2-B1-S13" ];
        
        dataset_name = '*R2B1_S14*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(48:50,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-tumour-R2-B1-S14"; "apc-3-tumour-R2-B1-S14"; "apc-kras-1-tumour-R2-B1-S14" ];
        extensive_filesToProcess(51:52,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-4-tumour-R2-B1-S14"; "apc-kras-5-tumour-R2-B1-S14" ];
        extensive_filesToProcess(53:55,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-normal-R2-B1-S14"; "apc-3-normal-R2-B1-S14"; "apc-kras-1-normal-R2-B1-S14" ];
        extensive_filesToProcess(56,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-5-normal-R2-B1-S14" ];
        
        dataset_name = '*R2B1_S16*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(57:59,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-tumour-R2-B1-S16"; "apc-3-tumour-R2-B1-S16"; "apc-kras-1-tumour-R2-B1-S16" ];
        extensive_filesToProcess(60:61,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-4-tumour-R2-B1-S16"; "apc-kras-5-tumour-R2-B1-S16" ];
        extensive_filesToProcess(62:64,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-normal-R2-B1-S16"; "apc-3-normal-R2-B1-S16"; "apc-kras-1-normal-R2-B1-S16" ];
        extensive_filesToProcess(65,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-5-normal-R2-B1-S16" ];
        
        dataset_name = '*R2B2_S19*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(66:67,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-1-tumour-R2-B2-S19"; "apc-kras-2-tumour-R2-B2-S19" ];
        extensive_filesToProcess(68:71,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-4-tumour-R2-B2-S19"; "apc-kras-3-tumour-R2-B2-S19"; "apc-kras-5-tumour-R2-B2-S19"; "apc-kras-6-tumour-R2-B2-S19" ];
        extensive_filesToProcess(72:73,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-1-normal-R2-B2-S19"; "apc-kras-2-normal-R2-B2-S19" ];
        
        dataset_name = '*R2B2_S21*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(74:75,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-1-tumour-R2-B2-S21"; "apc-kras-2-tumour-R2-B2-S21" ];
        extensive_filesToProcess(76:77,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-4-tumour-R2-B2-S21"; "apc-kras-3-tumour-R2-B2-S21" ];
        extensive_filesToProcess(78,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-5-tumour-R2-B2-S21" ];
        extensive_filesToProcess(79,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-6-tumour-R2-B2-S21" ];
        extensive_filesToProcess(80:81,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-1-normal-R2-B2-S21"; "apc-kras-2-normal-R2-B2-S21" ];
        extensive_filesToProcess(82:83,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-4-normal-R2-B2-S21"; "apc-kras-3-normal-R2-B2-S21" ];
        
        
        dataset_name = '*R2B3_S5*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(84:85,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S5"; "wt-2-R2-B3-S5" ];
        extensive_filesToProcess(86,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "wt-3-R2-B3-S5" ];
        extensive_filesToProcess(87,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "wt-4-R2-B3-S5" ];
        
        dataset_name = '*R2B3_S6*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(88:91,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S6"; "wt-2-R2-B3-S6"; "wt-3-R2-B3-S6"; "wt-4-R2-B3-S6" ];
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1; 5 1;        1+7 1;  2+7 1; 3+7 1;   4+7 1; 5+7 1;
            4 2; 1 2; 2 2; 5 2; 3 2;        4+7 2;  1+7 2; 2+7 2;   5+7 2; 3+7 2;
            1 3; 2 3; 4 3; 3 3; 5 3;        1+7 3;  2+7 3;          3+7 3; 5+7 3;
            4 4; 1 4; 2 4; 3 4; 5 4;                1+7 4; 2+7 4;   3+7 4; 5+7 4;
            1 5; 2 5; 4 5; 5 5; 6 5;        1+7 5;  2+7 5; 4+7 5;   6+7-1 5;
            1 6; 2 6; 4 6; 5 6; 6 6;        1+7 6;  2+7 6; 4+7 6;   6+7-1 6;
            1 7; 2 7; 4 7; 5 7; 6 7;        1+7 7;  2+7 7; 4+7 7;   6+7-1 7;
            1 8; 4 8; 2 8; 5 8; 6 8; 7 8;   1+7 8;  4+7 8;
            1 9; 4 9; 2 9; 5 9; 6 9; 7 9;   1+7 9;  4+7 9; 2+7 9;   5+7 9;
            8 10; 9 10; 10 10; 11 10;
            8 11; 9 11; 10 11; 11 11;
            ];
        
    case "PI3K C DESI Negative (AZ data)"
        
        main_mask_list = "tissue only"; % tissue only
        data_folders = { 'X:\Beatson\PI3K study (drug swiss)\Data\neg DESI (AZ)\' };% Datasets
        clear extensive_filesToProcess
        dataset_name = '*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(1:14,:) = filesToProcess(1,:);
        smaller_masks_list = [ ...
            "b1_vehicle", "b1_6244", "b1_8186", "b1_2014", "b1_6244_8186", "b1_6244_2014", "b1_2014_8186", ...
            "b3_vehicle", "b3_6244", "b3_8186", "b3_2014", "b3_6244_8186", "b3_6244_2014", "b3_2014_8186", ...
            ];
        extensive_filesToProcess(15:27,:) = filesToProcess(2,:);
        smaller_masks_list = [ ...
            smaller_masks_list,...
            "b2_vehicle", "b2_6244", "b2_8186", "b2_2014", "b2_6244_8186", "b2_6244_2014", ...
            "b4_vehicle", "b4_6244", "b4_8186", "b4_2014", "b4_6244_8186", "b4_6244_2014", "b4_2014_8186", ...
            ];
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 3; 1 4; 1 5; 1 6; 1 7;
            3 1; 3 2; 3 3; 3 4; 3 5; 3 6; 3 7;
            2 1; 2 2; 2 3; 2 4; 2 5; 2 6;
            4 1; 4 2; 4 3; 4 4; 4 5; 4 6; 4 7;
            ];
        
    case "neg DESI intracolonics selected set"
        
        main_mask_list = "tissue only"; % tissue only
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Data\neg DESI\Xevo V3 Sprayer\Selected Set\' };% Datasets
        clear extensive_filesToProcess
        
        dataset_name = '*20190815_intracolonics_neg_slide9*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(1:5,:) = filesToProcess(1,:);
        smaller_masks_list = [ "apc-3-R1-B1-S9"; "apc-5-R1-B1-S9"; "apc-6-R1-B1-S9"; "apc-kras-2-R1-B1-S9"; "apc-kras-7-R1-B1-S9" ];
        
        dataset_name = '*R1B1_S26*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(6,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S26" ];
        extensive_filesToProcess(7:9,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S26"; "apc-5-R1-B1-S26"; "apc-kras-7-R1-B1-S26" ];
        extensive_filesToProcess(10,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S26" ];
        
        dataset_name = '*R1B1_s28*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(11:13,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S28"; "apc-5-R1-B1-S28"; "apc-kras-2-R1-B1-S28" ];
        extensive_filesToProcess(14,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S28" ];
        extensive_filesToProcess(15,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S28" ];
        
        dataset_name = '*R1B1_s30*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(16,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S30" ];
        extensive_filesToProcess(17,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S30" ];
        extensive_filesToProcess(18,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-5-R1-B1-S30" ];
        extensive_filesToProcess(19,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S30" ];
        extensive_filesToProcess(20,:) = filesToProcess(5,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S30" ];
        
        dataset_name = '*R2B1_S13*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(21:23,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S13"; "apc-3-R2-B1-S13"; "apc-kras-1-R2-B1-S13" ];
        extensive_filesToProcess(24:25,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S13"; "apc-kras-5-R2-B1-S13" ];
        
        dataset_name = '*R2B1_S14*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(26:28,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S14"; "apc-3-R2-B1-S14"; "apc-kras-1-R2-B1-S14" ];
        extensive_filesToProcess(29:30,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S14"; "apc-kras-5-R2-B1-S14" ];
        
        dataset_name = '*R2B1_S16*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(31:33,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S16"; "apc-3-R2-B1-S16"; "apc-kras-1-R2-B1-S16" ];
        extensive_filesToProcess(34:35,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S16"; "apc-kras-5-R2-B1-S16" ];
        
        dataset_name = '*R2B2_S19*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(36:37,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S19"; "apc-kras-2-R2-B2-S19" ];
        extensive_filesToProcess(38:41,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S19"; "apc-kras-3-R2-B2-S19"; "apc-kras-5-R2-B2-S19"; "apc-kras-6-R2-B2-S19" ];
        
        dataset_name = '*R2B2_S21*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(42:43,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S21"; "apc-kras-2-R2-B2-S21" ];
        extensive_filesToProcess(44:45,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S21"; "apc-kras-3-R2-B2-S21" ];
        extensive_filesToProcess(46,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S21" ];
        extensive_filesToProcess(47,:) = filesToProcess(4,:);
        smaller_masks_list = [ smaller_masks_list; "apc-kras-6-R2-B2-S21" ];
        
        dataset_name = '*R2B3_S5*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(48:49,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S5"; "wt-2-R2-B3-S5" ];
        extensive_filesToProcess(50,:) = filesToProcess(2,:);
        smaller_masks_list = [ smaller_masks_list; "wt-3-R2-B3-S5" ];
        extensive_filesToProcess(51,:) = filesToProcess(3,:);
        smaller_masks_list = [ smaller_masks_list; "wt-4-R2-B3-S5" ];
        
        dataset_name = '*R2B3_S6*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        extensive_filesToProcess(52:55,:) = filesToProcess(1,:);
        smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S6"; "wt-2-R2-B3-S6"; "wt-3-R2-B3-S6"; "wt-4-R2-B3-S6" ];
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1; 5 1;
            4 2; 1 2; 2 2; 5 2; 3 2;
            1 3; 2 3; 4 3; 3 3; 5 3;
            4 4; 1 4; 2 4; 3 4; 5 4;
            1 5; 2 5; 4 5; 5 5; 6 5;
            1 6; 2 6; 4 6; 5 6; 6 6;
            1 7; 2 7; 4 7; 5 7; 6 7;
            1 8; 4 8; 2 8; 5 8; 6 8; 7 8;
            1 9; 4 9; 2 9; 5 9; 6 9; 7 9;
            8 10; 9 10; 10 10; 11 10;
            8 11; 9 11; 10 11; 11 11;
            ];
        
    case "neg DESI intracolonics selected set with background"
        
        if background ~= 1
            main_mask_list = "tissue only"; % tissue only
            data_folders = { 'X:\Beatson\Intracolonic tumour study\Data\neg DESI\Xevo V3 Sprayer\Selected Set\' };% Datasets
            clear extensive_filesToProcess
            
            dataset_name = '*20190815_intracolonics_neg_slide9*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(1:5,:) = filesToProcess(1,:);
            smaller_masks_list = [ "apc-3-R1-B1-S9-bg"; "apc-5-R1-B1-S9-bg"; "apc-6-R1-B1-S9-bg"; "apc-kras-2-R1-B1-S9-bg"; "apc-kras-7-R1-B1-S9-bg" ];
            
            dataset_name = '*R1B1_S26*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(6,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S26-bg" ];
            extensive_filesToProcess(7:9,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S26-bg"; "apc-5-R1-B1-S26-bg"; "apc-kras-7-R1-B1-S26-bg" ];
            extensive_filesToProcess(10,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S26-bg" ];
            
            dataset_name = '*R1B1_s28*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(11:13,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S28-bg"; "apc-5-R1-B1-S28-bg"; "apc-kras-2-R1-B1-S28-bg" ];
            extensive_filesToProcess(14,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S28-bg" ];
            extensive_filesToProcess(15,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S28-bg" ];
            
            dataset_name = '*R1B1_s30*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(16,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S30-bg" ];
            extensive_filesToProcess(17,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S30-bg" ];
            extensive_filesToProcess(18,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-5-R1-B1-S30-bg" ];
            extensive_filesToProcess(19,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S30-bg" ];
            extensive_filesToProcess(20,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S30-bg" ];
            
            dataset_name = '*R2B1_S13*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(21:23,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S13-bg"; "apc-3-R2-B1-S13-bg"; "apc-kras-1-R2-B1-S13-bg" ];
            extensive_filesToProcess(24:25,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S13-bg"; "apc-kras-5-R2-B1-S13-bg" ];
            
            dataset_name = '*R2B1_S14*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(26:28,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S14-bg"; "apc-3-R2-B1-S14-bg"; "apc-kras-1-R2-B1-S14-bg" ];
            extensive_filesToProcess(29:30,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S14-bg"; "apc-kras-5-R2-B1-S14-bg" ];
            
            dataset_name = '*R2B1_S16*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(31:33,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S16-bg"; "apc-3-R2-B1-S16-bg"; "apc-kras-1-R2-B1-S16-bg" ];
            extensive_filesToProcess(34:35,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S16-bg"; "apc-kras-5-R2-B1-S16-bg" ];
            
            dataset_name = '*R2B2_S19*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(36:37,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S19-bg"; "apc-kras-2-R2-B2-S19-bg" ];
            extensive_filesToProcess(38:41,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S19-bg"; "apc-kras-3-R2-B2-S19-bg"; "apc-kras-5-R2-B2-S19-bg"; "apc-kras-6-R2-B2-S19-bg" ];
            
            dataset_name = '*R2B2_S21*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(42:43,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S21-bg"; "apc-kras-2-R2-B2-S21-bg" ];
            extensive_filesToProcess(44:45,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S21-bg"; "apc-kras-3-R2-B2-S21-bg" ];
            extensive_filesToProcess(46,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S21-bg" ];
            extensive_filesToProcess(47,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-6-R2-B2-S21-bg" ];
            
            dataset_name = '*R2B3_S5*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(48:49,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S5-bg"; "wt-2-R2-B3-S5-bg" ];
            extensive_filesToProcess(50,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "wt-3-R2-B3-S5-bg" ];
            extensive_filesToProcess(51,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "wt-4-R2-B3-S5-bg" ];
            
            dataset_name = '*R2B3_S6*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(52:55,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S6-bg"; "wt-2-R2-B3-S6-bg"; "wt-3-R2-B3-S6-bg"; "wt-4-R2-B3-S6-bg" ];
            
        end
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1; 5 1;
            4 2; 1 2; 2 2; 5 2; 3 2;
            1 3; 2 3; 4 3; 3 3; 5 3;
            4 4; 1 4; 2 4; 3 4; 5 4;
            1 5; 2 5; 4 5; 5 5; 6 5;
            1 6; 2 6; 4 6; 5 6; 6 6;
            1 7; 2 7; 4 7; 5 7; 6 7;
            1 8; 4 8; 2 8; 5 8; 6 8; 7 8;
            1 9; 4 9; 2 9; 5 9; 6 9; 7 9;
            8 10; 9 10; 10 10; 11 10;
            8 11; 9 11; 10 11; 11 11;
            ];
        
    case "neg DESI intracolonics autumn 2020 set 2 with background"
        
        if background ~= 1
            main_mask_list = "tissue only"; % tissue only
            data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\Autumn 2020 (Round 2, Set 2)\' };% Datasets
            clear extensive_filesToProcess
            dataset_name = '*R1B1_s28*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(1:3,:) = filesToProcess(2,:);
            smaller_masks_list = [ "apc-3-R1-B1-S28-bg"; "apc-5-R1-B1-S28-bg"; "apc-kras-2-R1-B1-S28-bg" ];
            extensive_filesToProcess(4,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S28-bg" ];
            extensive_filesToProcess(5,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S28-bg" ];
            dataset_name = '*R1B1_s29*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(6,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S29-bg" ];
            extensive_filesToProcess(7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S29-bg" ];
            extensive_filesToProcess(8,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-5-R1-B1-S29-bg" ];
            extensive_filesToProcess(9,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S29-bg" ];
            extensive_filesToProcess(10,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S29-bg" ];
            dataset_name = '*R1B1_s30*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(11,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S30-bg" ];
            extensive_filesToProcess(12,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S30-bg" ];
            extensive_filesToProcess(13,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-5-R1-B1-S30-bg" ];
            extensive_filesToProcess(14,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S30-bg" ];
            extensive_filesToProcess(15,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S30-bg" ];
            dataset_name = '*R2B1_S16*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(16:18,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S16-bg"; "apc-3-R2-B1-S16-bg"; "apc-kras-1-R2-B1-S16-bg" ];
            extensive_filesToProcess(19:20,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S16-bg"; "apc-kras-5-R2-B1-S16-bg" ];
            dataset_name = '*R2B1_S38*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(21:23,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R2-B1-S38-bg"; "apc-kras-4-R2-B1-S38-bg"; "apc-kras-5-R2-B1-S38-bg" ];
            dataset_name = '*R2B2_S19*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(24:25,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S19-bg"; "apc-kras-2-R2-B2-S19-bg" ];
            extensive_filesToProcess(26:29,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S19-bg"; "apc-kras-3-R2-B2-S19-bg"; "apc-kras-5-R2-B2-S19-bg"; "apc-kras-6-R2-B2-S19-bg" ];
            dataset_name = '*R2B2_S20*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(30:31,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S20-bg"; "apc-kras-2-R2-B2-S20-bg" ];
            extensive_filesToProcess(32:33,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S20-bg"; "apc-kras-3-R2-B2-S20-bg" ];
            extensive_filesToProcess(34,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S20-bg" ];
            dataset_name = '*R2B2_S21*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(35:36,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S21-bg"; "apc-kras-2-R2-B2-S21-bg" ];
            extensive_filesToProcess(37:38,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S21-bg"; "apc-kras-3-R2-B2-S21-bg" ];
            extensive_filesToProcess(39,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S21-bg" ];
            extensive_filesToProcess(40,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-6-R2-B2-S21-bg" ];
            dataset_name = '*R2B3_S5*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(41:42,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S5-bg"; "wt-2-R2-B3-S5-bg" ];
            extensive_filesToProcess(43,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "wt-3-R2-B3-S5-bg" ];
            extensive_filesToProcess(44,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "wt-4-R2-B3-S5-bg" ];
            dataset_name = '*R2B3_S6*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(45:48,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S6-bg"; "wt-2-R2-B3-S6-bg"; "wt-3-R2-B3-S6-bg"; "wt-4-R2-B3-S6-bg" ];
        end
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 4; 1 3; 1 5;
            2 4; 2 1; 2 2; 2 5; 2 3;
            3 4; 3 1; 3 2; 3 3; 3 5;
            4 1; 4 2; 4 4; 4 5; 4 6;
            5 1; 5 4; 5 5;
            6 1; 6 4; 6 2; 6 5; 6 6; 6 7;
            7 1; 7 4; 7 2; 7 5; 7 6;
            8 1; 8 4; 8 2; 8 5; 8 6; 8 7;
            9 8; 9 9; 9 10; 9 11;
            10 8; 10 9; 10 10; 10 11
            ];
        
    case "neg DESI intracolonics autumn 2020 set 1"
        
        if background ~= 1
            main_mask_list = "tissue only"; % tissue only
            data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\Autumn 2020 (Round 2, Set 1)\' };% Datasets
            clear extensive_filesToProcess
            dataset_name = '*R1B1_S25*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(1,:) = filesToProcess(1,:);
            smaller_masks_list = [ "apc-kras-2-R1-B1-S25" ];
            extensive_filesToProcess(2:4,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S25"; "apc-5-R1-B1-S25"; "apc-kras-7-R1-B1-S25" ];
            extensive_filesToProcess(5,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S25" ];
            dataset_name = '*R1B1_S26*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(6,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S26" ];
            extensive_filesToProcess(7:9,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S26"; "apc-5-R1-B1-S26"; "apc-kras-7-R1-B1-S26" ];
            extensive_filesToProcess(10,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S26" ];
            dataset_name = '*R1B1_S27*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(11,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S27" ];
            extensive_filesToProcess(12:14,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S27"; "apc-5-R1-B1-S27"; "apc-kras-7-R1-B1-S27"];
            extensive_filesToProcess(15,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S27" ];
            dataset_name = '*R2B1_S13*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(16:18,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S13"; "apc-3-R2-B1-S13"; "apc-kras-1-R2-B1-S13" ];
            extensive_filesToProcess(19:20,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S13"; "apc-kras-5-R2-B1-S13" ];
            dataset_name = '*R2B1_S14*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(21:23,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S14"; "apc-3-R2-B1-S14"; "apc-kras-1-R2-B1-S14" ];
            extensive_filesToProcess(24:25,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S14"; "apc-kras-5-R2-B1-S14" ];
            dataset_name = '*R2B1_S15*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(26,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-1-R2-B1-S15" ];
            extensive_filesToProcess(27:28,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S15"; "apc-3-R2-B1-S15" ];
            dataset_name = '*R2B1_S33*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(29,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R2-B1-S33" ];
            dataset_name = '*R2B1_S34*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(30,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R2-B1-S34" ];
            dataset_name = '*R2B1_S35*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(31:33,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R2-B1-S35"; "apc-kras-4-R2-B1-S35"; "apc-kras-5-R2-B1-S35" ];
            dataset_name = '*R2B2_S13*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(34,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S13" ];
            extensive_filesToProcess(35,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R2-B2-S13" ];
            extensive_filesToProcess(36:38,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S13"; "apc-kras-3-R2-B2-S13"; "apc-kras-5-R2-B2-S13" ];
            extensive_filesToProcess(39,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-6-R2-B2-S13" ];
            dataset_name = '*R2B2_S15*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(40:41,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S15"; "apc-kras-2-R2-B2-S15" ];
            extensive_filesToProcess(42:43,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S15"; "apc-kras-3-R2-B2-S15" ];
            extensive_filesToProcess(44:45,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S15"; "apc-kras-6-R2-B2-S15" ];
            dataset_name = '*20201102_intracolonics_neg_xDESI_R2B2*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(46:51,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S16"; "apc-4-R2-B2-S16"; "apc-kras-2-R2-B2-S16"; "apc-kras-3-R2-B2-S16"; "apc-kras-5-R2-B2-S16"; "apc-kras-6-R2-B2-S16" ];
            dataset_name = '*R2B2_S17*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(52:53,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S17"; "apc-kras-2-R2-B2-S17" ];
            extensive_filesToProcess(54:57,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S17"; "apc-kras-3-R2-B2-S17"; "apc-kras-5-R2-B2-S17"; "apc-kras-6-R2-B2-S17" ];
            dataset_name = '*R2B2_S18*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(58:59,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S18"; "apc-kras-2-R2-B2-S18" ];
            extensive_filesToProcess(60:63,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S18"; "apc-kras-3-R2-B2-S18"; "apc-kras-5-R2-B2-S18"; "apc-kras-6-R2-B2-S18" ];
            dataset_name = '*R2B3_S1*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(64:65,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S1"; "wt-2-R2-B3-S1" ];
            extensive_filesToProcess(66,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "wt-3-R2-B3-S1" ];
            extensive_filesToProcess(67,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "wt-4-R2-B3-S1" ];
            dataset_name = '*R2B3_S3*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(68:71,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S3"; "wt-2-R2-B3-S3"; "wt-3-R2-B3-S3"; "wt-4-R2-B3-S3" ];
            dataset_name = '*R2B3_S4*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(72:75,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S4"; "wt-2-R2-B3-S4"; "wt-3-R2-B3-S4"; "wt-4-R2-B3-S4" ];
        end
        
        outputs_xy_pairs = [
            1 4; 1 1; 1 2; 1 5; 1 3;
            2 4; 2 1; 2 2; 2 5; 2 3;
            3 4; 3 1; 3 2; 3 5; 3 3;
            4 1; 4 2; 4 4; 4 5; 4 6;
            5 1; 5 2; 5 4; 5 5; 5 6;
            6 4; 6 1; 6 2;
            7 1;
            8 1;
            9 1; 9 4; 9 5;
            10 1; 10 4; 10 2; 10 5; 10 6; 10 7;
            11 1; 11 4; 11 2; 11 5; 11 6; 11 7;
            12 1; 12 2; 12 4; 12 5; 12 6; 12 7;
            13 1; 13 4; 13 2; 13 5; 13 6; 13 7;
            14 1; 14 4; 14 2; 14 5; 14 6; 14 7;
            15 8; 15 9; 15 10; 15 11;
            16 8; 16 9; 16 10; 16 11;
            17 8; 17 9; 17 10; 17 11;
            ];
        
    case "neg DESI intracolonics autumn 2020 set 2"
        
        if background ~= 1
            main_mask_list = "tissue only"; % tissue only
            data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\Autumn 2020 (Round 2, Set 2)\' };% Datasets
            clear extensive_filesToProcess
            dataset_name = '*R1B1_s28*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(1:3,:) = filesToProcess(2,:);
            smaller_masks_list = [ "apc-3-R1-B1-S28"; "apc-5-R1-B1-S28"; "apc-kras-2-R1-B1-S28" ];
            extensive_filesToProcess(4,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S28" ];
            extensive_filesToProcess(5,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S28" ];
            dataset_name = '*R1B1_s29*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(6,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S29" ];
            extensive_filesToProcess(7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S29" ];
            extensive_filesToProcess(8,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-5-R1-B1-S29" ];
            extensive_filesToProcess(9,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S29" ];
            extensive_filesToProcess(10,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S29" ];
            dataset_name = '*R1B1_s30*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(11,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-2-R1-B1-S30" ];
            extensive_filesToProcess(12,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-3-R1-B1-S30" ];
            extensive_filesToProcess(13,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-5-R1-B1-S30" ];
            extensive_filesToProcess(14,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R1-B1-S30" ];
            extensive_filesToProcess(15,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-7-R1-B1-S30" ];
            dataset_name = '*R2B1_S16*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(16:18,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-2-R2-B1-S16"; "apc-3-R2-B1-S16"; "apc-kras-1-R2-B1-S16" ];
            extensive_filesToProcess(19:20,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-4-R2-B1-S16"; "apc-kras-5-R2-B1-S16" ];
            dataset_name = '*R2B1_S38*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(21:23,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-6-R2-B1-S38"; "apc-kras-4-R2-B1-S38"; "apc-kras-5-R2-B1-S38" ];
            dataset_name = '*R2B2_S19*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(24:25,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S19"; "apc-kras-2-R2-B2-S19" ];
            extensive_filesToProcess(26:29,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S19"; "apc-kras-3-R2-B2-S19"; "apc-kras-5-R2-B2-S19"; "apc-kras-6-R2-B2-S19" ];
            dataset_name = '*R2B2_S20*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(30:31,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S20"; "apc-kras-2-R2-B2-S20" ];
            extensive_filesToProcess(32:33,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S20"; "apc-kras-3-R2-B2-S20" ];
            extensive_filesToProcess(34,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S20" ];
            dataset_name = '*R2B2_S21*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(35:36,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "apc-1-R2-B2-S21"; "apc-kras-2-R2-B2-S21" ];
            extensive_filesToProcess(37:38,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "apc-4-R2-B2-S21"; "apc-kras-3-R2-B2-S21" ];
            extensive_filesToProcess(39,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-5-R2-B2-S21" ];
            extensive_filesToProcess(40,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "apc-kras-6-R2-B2-S21" ];
            dataset_name = '*R2B3_S5*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(41:42,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S5"; "wt-2-R2-B3-S5" ];
            extensive_filesToProcess(43,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "wt-3-R2-B3-S5" ];
            extensive_filesToProcess(44,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "wt-4-R2-B3-S5" ];
            dataset_name = '*R2B3_S6*'; filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            extensive_filesToProcess(45:48,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "wt-1-R2-B3-S6"; "wt-2-R2-B3-S6"; "wt-3-R2-B3-S6"; "wt-4-R2-B3-S6" ];
        end
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 4; 1 3; 1 5;
            2 4; 2 1; 2 2; 2 5; 2 3;
            3 4; 3 1; 3 2; 3 3; 3 5;
            4 1; 4 2; 4 4; 4 5; 4 6;
            5 1; 5 4; 5 5;
            6 1; 6 4; 6 2; 6 5; 6 6; 6 7;
            7 1; 7 4; 7 2; 7 5; 7 6;
            8 1; 8 4; 8 2; 8 5; 8 6; 8 7;
            9 8; 9 9; 9 10; 9 11;
            10 8; 10 9; 10 10; 10 11
            ];
        
    case "PI3K SI uMALDI Negative"
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            % Datasets
            
            data_folders = { 'X:\Beatson\PI3K study (drug swiss)\Data\uMALDI neg\imzml\' };
            
            dataset_name = '*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(1:7,:) = filesToProcess(3,:);
            smaller_masks_list = [
                "b1s18_vehicle"; "b1s18_2014"; "b1s18_8186"; "b1s18_6244"; "b1s18_6244_8186"; "b1s18_6244_2014"; "b1s18_2014_8186"
                ];
            
            extensive_filesToProcess(8:14,:) = filesToProcess(6,:);
            smaller_masks_list = [
                smaller_masks_list
                "b1s20_vehicle"; "b1s20_2014"; "b1s20_8186"; "b1s20_6244"; "b1s20_6244_8186"; "b1s20_6244_2014"; "b1s20_2014_8186"
                ];
            
            extensive_filesToProcess(15:20,:) = filesToProcess(1,:);
            smaller_masks_list = [
                smaller_masks_list
                "b2s17_vehicle"; "b2s17_2014"; "b2s17_8186"; "b2s17_6244"; "b2s17_6244_8186"; "b2s17_6244_2014"
                ];
            
            extensive_filesToProcess(21:26,:) = filesToProcess(4,:);
            smaller_masks_list = [
                smaller_masks_list
                "b2s18_vehicle"; "b2s18_2014"; "b2s18_8186"; "b2s18_6244"; "b2s18_6244_8186"; "b2s18_6244_2014"
                ];
            
            extensive_filesToProcess(27:32,:) = filesToProcess(2,:);
            smaller_masks_list = [
                smaller_masks_list
                "b3s17_vehicle"; "b3s17_2014"; "b3s17_8186"; "b3s17_6244"; "b3s17_6244_8186"; "b3s17_6244_2014"
                ];
            
            extensive_filesToProcess(33:38,:) = filesToProcess(7,:);
            smaller_masks_list = [
                smaller_masks_list
                "b3s18_vehicle"; "b3s18_2014"; "b3s18_8186"; "b3s18_6244"; "b3s18_6244_8186"; "b3s18_6244_2014"
                ];
            
            extensive_filesToProcess(39:45,:) = filesToProcess(5,:);
            smaller_masks_list = [
                smaller_masks_list
                "b4s17_vehicle"; "b4s17_2014"; "b4s17_8186"; "b4s17_6244"; "b4s17_6244_8186"; "b4s17_6244_2014"; "b4s17_2014_8186"
                ];
            
            extensive_filesToProcess(46:52,:) = filesToProcess(8,:);
            smaller_masks_list = [
                smaller_masks_list
                "b4s18_vehicle"; "b4s18_2014"; "b4s18_8186"; "b4s18_6244"; "b4s18_6244_8186"; "b4s18_6244_2014"; "b4s18_2014_8186"
                ];
            
        end
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 3; 1 4; 1 5; 1 6; 1 7;
            2 1; 2 2; 2 3; 2 4; 2 5; 2 6; 2 7;
            3 1; 3 2; 3 3; 3 4; 3 5; 3 6;
            4 1; 4 2; 4 3; 4 4; 4 5; 4 6;
            5 1; 5 2; 5 3; 5 4; 5 5; 5 6;
            6 1; 6 2; 6 3; 6 4; 6 5; 6 6;
            7 1; 7 2; 7 3; 7 4; 7 5; 7 6; 7 7;
            8 1; 8 2; 8 3; 8 4; 8 5; 8 6; 8 7;
            ];
        
    case "PI3K SI DESI Negative epithelium only"
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            main_mask_list = "tissue only";
            
            % Datasets
            
            data_folders = { 'X:\Beatson\PI3K study (drug swiss)\Data\DESI Neg\imzml\Synapt\' };
            
            dataset_name = '*SI*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(1:7,:) = filesToProcess(1,:);
            smaller_masks_list = [ "b1s24_vehicle epithelium"; "b1s24_8186 epithelium"; "b1s24_6244_8186 epithelium"; "b1s24_6244_2014 epithelium"; "b1s24_6244 epithelium"; "b1s24_2014_8186 epithelium"; "b1s24_2014 epithelium";  ];
            
            extensive_filesToProcess(8:13,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "b2s22_vehicle epithelium"; "b2s22_8186 epithelium"; "b2s22_6244_8186 epithelium"; "b2s22_6244_2014 epithelium"; "b2s22_6244 epithelium"; "b2s22_2014 epithelium";  ];
            
            extensive_filesToProcess(14:20,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "b3s24_vehicle epithelium"; "b3s24_8186 epithelium"; "b3s24_6244_8186 epithelium"; "b3s24_6244_2014 epithelium"; "b3s24_6244 epithelium"; "b3s24_2014_8186 epithelium"; "b3s24_2014 epithelium";  ];
            
            extensive_filesToProcess(21:22,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "b4s20_8186 epithelium"; "b4s20_6244 epithelium";  ];
            
            extensive_filesToProcess(23:29,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "b1s19_vehicle epithelium"; "b1s19_8186 epithelium"; "b1s19_6244_8186 epithelium"; "b1s19_6244_2014 epithelium"; "b1s19_6244 epithelium"; "b1s19_2014_8186 epithelium"; "b1s19_2014 epithelium";  ];
            
            extensive_filesToProcess(30:35,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "b2s21_vehicle epithelium"; "b2s21_8186 epithelium"; "b2s21_6244_8186 epithelium"; "b2s21_6244_2014 epithelium"; "b2s21_6244 epithelium"; "b2s21_2014 epithelium";  ];
            
            extensive_filesToProcess(36:42,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "b3s25_vehicle epithelium"; "b3s25_8186 epithelium"; "b3s25_6244_8186 epithelium"; "b3s25_6244_2014 epithelium"; "b3s25_6244 epithelium"; "b3s25_2014_8186 epithelium"; "b3s25_2014 epithelium";  ];
            
            extensive_filesToProcess(43:45,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "b4s24_vehicle epithelium"; "b4s24_8186 epithelium"; "b4s24_6244 epithelium"; ];
            
            extensive_filesToProcess(46:51,:) = filesToProcess(9,:);
            smaller_masks_list = [ smaller_masks_list; "b4s23_vehicle epithelium"; "b4s23_8186 epithelium"; "b4s23_6244_8186 epithelium"; "b4s23_6244 epithelium"; "b4s23_2014_8186 epithelium"; "b4s23_2014 epithelium";  ];
            
            extensive_filesToProcess(52:58,:) = filesToProcess(10,:);
            smaller_masks_list = [ smaller_masks_list; "b3s26_vehicle epithelium"; "b3s26_8186 epithelium"; "b3s26_6244_8186 epithelium"; "b3s26_6244_2014 epithelium"; "b3s26_6244 epithelium"; "b3s26_2014_8186 epithelium"; "b3s26_2014 epithelium";  ];
            
        end
        
        outputs_xy_pairs = [
            1 1; 1 3; 1 5; 1 6; 1 4; 1 7; 1 2;
            3 1; 3 3; 3 5; 3 6; 3 4;      3 2;
            5 1; 5 3; 5 5; 5 6; 5 4; 5 7; 5 2;
            8 3;           8 4;
            2 1; 2 3; 2 5; 2 6; 2 4; 2 7; 2 2;
            4 1; 4 3; 4 5; 4 6; 4 4;      4 2;
            6 1; 6 3; 6 5; 6 6; 6 4; 6 7; 6 2;
            9 1; 9 3; 9 4;
            10 1; 10 3; 10 5; 10 4; 10 7; 10 2;
            7 1; 7 3; 7 5; 7 6; 7 4; 7 7 ; 7 2;
            ];
        
    case "PI3K SI DESI Negative 4 feature selection work"
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            main_mask_list = "tissue only";
            
            % Datasets
            
            data_folders = { 'X:\Beatson\PI3K study (drug swiss)\Data\DESI Neg\imzml\Synapt\' };
            
            dataset_name = '*SI*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(1:14,:) = filesToProcess(1,:);
            smaller_masks_list = [ "b1s24_vehicle epithelium"; "b1s24_8186 epithelium"; "b1s24_6244_8186 epithelium"; "b1s24_6244_2014 epithelium"; "b1s24_6244 epithelium"; "b1s24_2014_8186 epithelium"; "b1s24_2014 epithelium";  ];
            smaller_masks_list = [ smaller_masks_list; "b1s24_vehicle"; "b1s24_8186"; "b1s24_6244_8186"; "b1s24_6244_2014"; "b1s24_6244"; "b1s24_2014_8186"; "b1s24_2014" ];
            
            extensive_filesToProcess(15:26,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "b2s22_vehicle epithelium"; "b2s22_8186 epithelium"; "b2s22_6244_8186 epithelium"; "b2s22_6244_2014 epithelium"; "b2s22_6244 epithelium"; "b2s22_2014 epithelium";  ];
            smaller_masks_list = [ smaller_masks_list; "b2s22_vehicle"; "b2s22_8186"; "b2s22_6244_8186"; "b2s22_6244_2014"; "b2s22_6244"; "b2s22_2014" ];
            
            extensive_filesToProcess(27:40,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "b3s24_vehicle epithelium"; "b3s24_8186 epithelium"; "b3s24_6244_8186 epithelium"; "b3s24_6244_2014 epithelium"; "b3s24_6244 epithelium"; "b3s24_2014_8186 epithelium"; "b3s24_2014 epithelium";  ];
            smaller_masks_list = [ smaller_masks_list; "b3s24_vehicle"; "b3s24_8186"; "b3s24_6244_8186"; "b3s24_6244_2014"; "b3s24_6244"; "b3s24_2014_8186"; "b3s24_2014" ];
            
            extensive_filesToProcess(41:44,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "b4s20_8186 epithelium"; "b4s20_6244 epithelium" ];
            smaller_masks_list = [ smaller_masks_list; "b4s20_8186"; "b4s20_6244" ];
            
            extensive_filesToProcess(45:58,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "b1s19_vehicle epithelium"; "b1s19_8186 epithelium"; "b1s19_6244_8186 epithelium"; "b1s19_6244_2014 epithelium"; "b1s19_6244 epithelium"; "b1s19_2014_8186 epithelium"; "b1s19_2014 epithelium";  ];
            smaller_masks_list = [ smaller_masks_list; "b1s19_vehicle"; "b1s19_8186"; "b1s19_6244_8186"; "b1s19_6244_2014"; "b1s19_6244"; "b1s19_2014_8186"; "b1s19_2014" ];
            
            extensive_filesToProcess(59:70,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "b2s21_vehicle epithelium"; "b2s21_8186 epithelium"; "b2s21_6244_8186 epithelium"; "b2s21_6244_2014 epithelium"; "b2s21_6244 epithelium"; "b2s21_2014 epithelium";  ];
            smaller_masks_list = [ smaller_masks_list; "b2s21_vehicle"; "b2s21_8186"; "b2s21_6244_8186"; "b2s21_6244_2014"; "b2s21_6244"; "b2s21_2014" ];
            
            extensive_filesToProcess(71:84,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "b3s25_vehicle epithelium"; "b3s25_8186 epithelium"; "b3s25_6244_8186 epithelium"; "b3s25_6244_2014 epithelium"; "b3s25_6244 epithelium"; "b3s25_2014_8186 epithelium"; "b3s25_2014 epithelium";  ];
            smaller_masks_list = [ smaller_masks_list; "b3s25_vehicle"; "b3s25_8186"; "b3s25_6244_8186"; "b3s25_6244_2014"; "b3s25_6244"; "b3s25_2014_8186"; "b3s25_2014" ];
            
            extensive_filesToProcess(85:90,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "b4s24_vehicle epithelium"; "b4s24_8186 epithelium"; "b4s24_6244 epithelium" ];
            smaller_masks_list = [ smaller_masks_list; "b4s24_vehicle"; "b4s24_8186"; "b4s24_6244" ];
            
            extensive_filesToProcess(91:102,:) = filesToProcess(9,:);
            smaller_masks_list = [ smaller_masks_list; "b4s23_vehicle epithelium"; "b4s23_8186 epithelium"; "b4s23_6244_8186 epithelium"; "b4s23_6244 epithelium"; "b4s23_2014_8186 epithelium"; "b4s23_2014 epithelium" ];
            smaller_masks_list = [ smaller_masks_list; "b4s23_vehicle"; "b4s23_8186"; "b4s23_6244_8186"; "b4s23_6244"; "b4s23_2014_8186"; "b4s23_2014" ];
            
            extensive_filesToProcess(103:116,:) = filesToProcess(10,:);
            smaller_masks_list = [ smaller_masks_list; "b3s26_vehicle epithelium"; "b3s26_8186 epithelium"; "b3s26_6244_8186 epithelium"; "b3s26_6244_2014 epithelium"; "b3s26_6244 epithelium"; "b3s26_2014_8186 epithelium"; "b3s26_2014 epithelium";  ];
            smaller_masks_list = [ smaller_masks_list; "b3s26_vehicle"; "b3s26_8186"; "b3s26_6244_8186"; "b3s26_6244_2014"; "b3s26_6244"; "b3s26_2014_8186"; "b3s26_2014" ];
            
        end
        
        outputs_xy_pairs = [
            1 1; 1 3; 1 5; 1 6; 1 4; 1 7; 1 2; 1 1+7; 1 3+7; 1 5+7; 1 6+7; 1 4+7; 1 7+7; 1 2+7;
            3 1; 3 3; 3 5; 3 6; 3 4;      3 2; 3 1+7; 3 3+7; 3 5+7; 3 6+7; 3 4+7;      3 2+7;
            5 1; 5 3; 5 5; 5 6; 5 4; 5 7; 5 2; 5 1+7; 5 3+7; 5 5+7; 5 6+7; 5 4+7; 5 7+7; 5 2+7;
            8 3;           8 4; 8 3+7;           8 4+7;
            2 1; 2 3; 2 5; 2 6; 2 4; 2 7; 2 2; 2 1+7; 2 3+7; 2 5+7; 2 6+7; 2 4+7; 2 7+7; 2 2+7;
            4 1; 4 3; 4 5; 4 6; 4 4;      4 2; 4 1+7; 4 3+7; 4 5+7; 4 6+7; 4 4+7;      4 2+7;
            6 1; 6 3; 6 5; 6 6; 6 4; 6 7; 6 2; 6 1+7; 6 3+7; 6 5+7; 6 6+7; 6 4+7; 6 7+7; 6 2+7;
            9 1; 9 3; 9 4; 9 1+7; 9 3+7; 9 4+7;
            10 1; 10 3; 10 5; 10 4; 10 7; 10 2; 10 1+7; 10 3+7; 10 5+7; 10 4+7; 10 7+7; 10 2+7;
            7 1; 7 3; 7 5; 7 6; 7 4; 7 7 ; 7 2; 7 1+7; 7 3+7; 7 5+7; 7 6+7; 7 4+7; 7 7+7; 7 2+7;
            ];
        
    case "PI3K SI DESI Negative"
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            % Datasets
            
            data_folders = { 'X:\Beatson\PI3K study (drug swiss)\Data\DESI Neg\imzml\Synapt\' };
            
            dataset_name = '*SI*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(1:7,:) = filesToProcess(1,:);
            smaller_masks_list = [ "b1s24_vehicle"; "b1s24_8186"; "b1s24_6244_8186"; "b1s24_6244_2014"; "b1s24_6244"; "b1s24_2014_8186"; "b1s24_2014";  ];
            
            extensive_filesToProcess(8:13,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "b2s22_vehicle"; "b2s22_8186"; "b2s22_6244_8186"; "b2s22_6244_2014"; "b2s22_6244"; "b2s22_2014";  ];
            
            extensive_filesToProcess(14:20,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "b3s24_vehicle"; "b3s24_8186"; "b3s24_6244_8186"; "b3s24_6244_2014"; "b3s24_6244"; "b3s24_2014_8186"; "b3s24_2014";  ];
            
            extensive_filesToProcess(21:22,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "b4s20_8186"; "b4s20_6244";  ];
            
            extensive_filesToProcess(23:29,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "b1s19_vehicle"; "b1s19_8186"; "b1s19_6244_8186"; "b1s19_6244_2014"; "b1s19_6244"; "b1s19_2014_8186"; "b1s19_2014";  ];
            
            extensive_filesToProcess(30:35,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "b2s21_vehicle"; "b2s21_8186"; "b2s21_6244_8186"; "b2s21_6244_2014"; "b2s21_6244"; "b2s21_2014";  ];
            
            extensive_filesToProcess(36:42,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "b3s25_vehicle"; "b3s25_8186"; "b3s25_6244_8186"; "b3s25_6244_2014"; "b3s25_6244"; "b3s25_2014_8186"; "b3s25_2014";  ];
            
            extensive_filesToProcess(43:45,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "b4s24_vehicle"; "b4s24_8186"; "b4s24_6244"; ];
            
            extensive_filesToProcess(46:51,:) = filesToProcess(9,:);
            smaller_masks_list = [ smaller_masks_list; "b4s23_vehicle"; "b4s23_8186"; "b4s23_6244_8186"; "b4s23_6244"; "b4s23_2014_8186"; "b4s23_2014";  ];
            
            extensive_filesToProcess(52:58,:) = filesToProcess(10,:);
            smaller_masks_list = [ smaller_masks_list; "b3s26_vehicle"; "b3s26_8186"; "b3s26_6244_8186"; "b3s26_6244_2014"; "b3s26_6244"; "b3s26_2014_8186"; "b3s26_2014";  ];
            
        end
        
        outputs_xy_pairs = [
            1 1; 1 3; 1 5; 1 6; 1 4; 1 7; 1 2;
            3 1; 3 3; 3 5; 3 6; 3 4;      3 2;
            5 1; 5 3; 5 5; 5 6; 5 4; 5 7; 5 2;
            8 3;           8 4;
            2 1; 2 3; 2 5; 2 6; 2 4; 2 7; 2 2;
            4 1; 4 3; 4 5; 4 6; 4 4;      4 2;
            6 1; 6 3; 6 5; 6 6; 6 4; 6 7; 6 2;
            9 1; 9 3; 9 4;
            10 1; 10 3; 10 5; 10 4; 10 7; 10 2;
            7 1; 7 3; 7 5; 7 6; 7 4; 7 7 ; 7 2;
            ];
        
    case "pos uMALDI intercolonics"
        
        main_mask_list = "tissue only";
        
        % Datasets
        
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Pos uMALDI Data\' };
        
        dataset_name = '20191009_beatson_intracolonics_batch2_slide5 uMALDI_pos';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        clear extensive_filesToProcess
        
        extensive_filesToProcess(1,:) = filesToProcess(1,:);
        smaller_masks_list = [
            "tissue only"
            ];
        
        outputs_xy_pairs = [
            1 1
            ];
        
    case "cell pellets v3"
        
        main_mask_list = "tissue only";
        
        % Datasets
        
        data_folders = { 'X:\Beatson\Cell Pellets\negative REIMS ibds and imzMLs version 3\' };
        
        dataset_name = 'Beatson Pellets v3';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        clear extensive_filesToProcess
        
        extensive_filesToProcess(1:13,:) = filesToProcess(1,:);
        smaller_masks_list = [
            
        "apc-kras-vehicle-1";
        "apc-kras-vehicle-2";
        "apc-kras-vehicle-3";
        "apc-kras-vehicle-4";
        
        "apc-kras-6244-1";
        "apc-kras-6244-2";
        
        "apc-kras-2014-1";
        "apc-kras-2014-2";
        "apc-kras-2014-3";
        
        "apc-kras-6244-2014-1";
        "apc-kras-6244-2014-2";
        "apc-kras-6244-2014-3";
        "apc-kras-6244-2014-4";
        ];
    
    outputs_xy_pairs = [
        1 1; 2 1; 3 1; 4 1;
        1 2; 2 2;
        1 3; 2 3; 3 3;
        1 4; 2 4; 3 4; 4 4;
        ];
    
    
    case "U13C Leucine"
        
        main_mask_list = "tissue only";
        
        % Datasets
        
        data_folders = { 'X:\Beatson\SLC7a5 study\AZ data\Leucine\data\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        clear extensive_filesToProcess
        
        extensive_filesToProcess(1:8,:) = filesToProcess(1,:);
        smaller_masks_list = [
            
        "si-wt-1-A1";
        "si-apc-1-B1";
        "si-kras-1-C1";
        "si-apc-kras-1-D1";
        
        "si-wt-5-A5";
        "si-apc-5-B5";
        "si-apc-kras-5-D5";
        "si-apc-kras-slc7a5-5-E5"
        
        ];
    
    extensive_filesToProcess(9:9+3*5-1,:) = filesToProcess(2,:);
    smaller_masks_list = [
        smaller_masks_list;
        
        "si-wt-2-A2";
        "si-apc-2-B2";
        "si-kras-2-C2";
        "si-apc-kras-2-D2";
        "si-apc-kras-slc7a5-2-E2";
        
        "si-wt-3-A3";
        "si-apc-3-B3";
        "si-kras-3-C3";
        "si-apc-kras-3-D3";
        "si-apc-kras-slc7a5-3-E3";
        
        "si-wt-4-A4";
        "si-apc-4-B4";
        "si-kras-4-C4";
        "si-apc-kras-4-D4";
        "si-apc-kras-slc7a5-4-E4"
        
        ];
    
    extensive_filesToProcess(24:24+2*4-1,:) = filesToProcess(3,:);
    smaller_masks_list = [
        smaller_masks_list;
        
        "c-wt-5-A5";
        "c-apc-5-B5";
        "c-kras-5-C5";
        "c-apc-kras-5-D5";
        
        "c-wt-1-A1";
        "c-apc-1-B1";
        "c-apc-kras-1-D1";
        "c-apc-kras-slc7a5-1-E1"
        
        ];
    
    extensive_filesToProcess(32:32+3*5-1,:) = filesToProcess(4,:);
    smaller_masks_list = [
        smaller_masks_list;
        
        "c-wt-2-A2";
        "c-apc-2-B2";
        "c-kras-2-C2";
        "c-apc-kras-2-D2";
        "c-apc-kras-slc7a5-2-E2";
        
        "c-wt-3-A3";
        "c-apc-3-B3";
        "c-kras-3-C3";
        "c-apc-kras-3-D3";
        "c-apc-kras-slc7a5-3-E3";
        
        "c-wt-4-A4";
        "c-apc-4-B4";
        "c-kras-4-C4";
        "c-apc-kras-4-D4";
        "c-apc-kras-slc7a5-4-E4"
        
        ];
    
    outputs_xy_pairs = [
        1 1; 1 2; 1 3; 1 4;
        5 1; 5 2; 5 4; 5 5;
        2 1; 2 2; 2 3; 2 4; 2 5;
        3 1; 3 2; 3 3; 3 4; 3 5;
        4 1; 4 2; 4 3; 4 4; 4 5;
        
        5 1+5; 5 2+5; 5 3+5; 5 4+5;
        1 1+5; 1 2+5; 1 4+5; 1 5+5;
        2 1+5; 2 2+5; 2 3+5; 2 4+5; 2 5+5;
        3 1+5; 3 2+5; 3 3+5; 3 4+5; 3 5+5;
        4 1+5; 4 2+5; 4 3+5; 4 4+5; 4 5+5;
        ];
    
    case "PI3K SI-initial look"
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            % Datasets
            
            data_folders = { 'X:\Beatson\PI3K study (drug swiss)\Data\DESI Neg\imzml\' };
            
            dataset_name = '*SI*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = 0;
            smaller_masks_list = [];
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(1:7,:) = filesToProcess(1,:);
            smaller_masks_list = [ "RHS212c"; "RHS212e"; "RHS223a"; "RHS223c"; "RHS213a"; "RHS224e"; "RHS213e"; ];
            
            extensive_filesToProcess(8:13,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "RHS212d"; "RHS212f"; "RHS222a";"RHS212h"; "RHS213g"; "RHS214a";];
            
        end
        
        outputs_xy_pairs = [1 1; 1 2; 1 3; 1 4; 1 5; 1 6; 1 7;
            2 1; 2 2; 2 3; 2 4; 2 5; 2 6;    ];
        
    case "AZ APC-KRAS-SLC7a5 Colon"
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            % Datasets
            
            data_folders = { 'X:\Beatson\SLC7a5 study\AZ data\APC_KRAS vs APC_KRAS_SLC7a5\' };
            
            dataset_name = '*colon*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = 0;
            smaller_masks_list = [];
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(1:5,:) = filesToProcess(1,:);
            smaller_masks_list = [ "RQAB82e"; "RQAF12a"; "RQAF23e"; "RQAF23f"; "RQAF13d"; ];
            
            extensive_filesToProcess(6:10,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "RQA412b"; "RQA412c"; "RQA441e"; "RQA452f"; "RQA472d";];
            
        end
        
        outputs_xy_pairs = [1 1; 1 2; 1 3; 1 4; 1 5;
            2 1; 2 2; 2 3; 2 4; 2 5; ];
        
    case "AZ APC-KRAS-SLC7a5 SI"
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            % Datasets
            
            data_folders = { 'X:\Beatson\SLC7a5 study\AZ data\APC_KRAS vs APC_KRAS_SLC7a5\' };
            
            dataset_name = '*SI*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = 0;
            smaller_masks_list = [];
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(1:5,:) = filesToProcess(1,:);
            smaller_masks_list = [ "RQAB82e"; "RQAF12a"; "RQAF23e"; "RQAF23f"; "RQAF13d"; ];
            
            extensive_filesToProcess(6:10,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "RQA412b"; "RQA412c"; "RQA441e"; "RQA452f"; "RQA472d";];
            
        end
        
        outputs_xy_pairs = [1 1; 1 2; 1 3; 1 4; 1 5;
            2 1; 2 2; 2 3; 2 4; 2 5; ];
        
    case "AZ APC-KRAS-SLC7a5 SI & Colon"
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            % Datasets
            
            data_folders = { 'X:\Beatson\SLC7a5 study\AZ data\APC_KRAS vs APC_KRAS_SLC7a5\' };
            
            dataset_name = '*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = 0;
            smaller_masks_list = [];
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(1:5,:) = filesToProcess(1,:);
            smaller_masks_list = [ "RQAB82e"; "RQAF12a"; "RQAF23e"; "RQAF23f"; "RQAF13d"; ];
            
            extensive_filesToProcess(6:10,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "RQA412b"; "RQA412c"; "RQA441e"; "RQA452f"; "RQA472d";];
            
            extensive_filesToProcess(11:15,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "RQAB82e"; "RQAF12a"; "RQAF23e"; "RQAF23f"; "RQAF13d"; ];
            
            extensive_filesToProcess(16:20,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "RQA412b"; "RQA412c"; "RQA441e"; "RQA452f"; "RQA472d";];
            
            
        end
        
        outputs_xy_pairs = [1 1; 1 2; 1 3; 1 4; 1 5;
            3 1; 3 2; 3 3; 3 4; 3 5
            2 1; 2 2; 2 3; 2 4; 2 5;
            4 1; 4 2; 4 3; 4 4; 4 5];
        
    case "positive AP MALDI tumour models"
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            % Intracolonic dataset
            
            data_folders = { 'X:\Beatson\Intracolonic tumour study\plasma-AP-MALDI MSI\2020_01_28 - intracolonic sicrit imaging\data\' };
            
            dataset_name = '*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = 0;
            smaller_masks_list = [];
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(1,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "IT-B-APC" ];
            
            extensive_filesToProcess(2,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "IT-C-APC" ];
            
            extensive_filesToProcess(3,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "IT-G-APC" ];
            
            extensive_filesToProcess(4,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "IT-A-APC-KRAS" ];
            
            extensive_filesToProcess(5,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "IT-D-APC-KRAS" ];
            
        end
        
        outputs_xy_pairs = [1 1; 1 2; 1 3; 2 1; 2 2 ];
        
    case "negative DESI pre-tumour & tumour models"
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            % Intracolonic dataset
            
            data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\' };
            
            dataset_name = '*slide9*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = 0;
            
            clear extensive_filesToProcess
            
            extensive_filesToProcess(delta+(1:4),:) = filesToProcess(1,:);
            smaller_masks_list = [ "IT9-C-APC"; "IT9-G-APC"; "IT9-A-APC-KRAS"; "IT9-D-APC-KRAS" ];
            
            % Tumour
            
            extensive_filesToProcess(delta+(5:8),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "IT9-C-APC-tumour"; "IT9-G-APC-tumour"; "IT9-A-APC-KRAS-tumour"; "IT9-D-APC-KRAS-tumour" ];
            
            extensive_filesToProcess(delta+(9:12),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "IT9-C-APC-normal"; "IT9-G-APC-normal"; "IT9-A-APC-KRAS-normal"; "IT9-D-APC-KRAS-normal" ];
            
            % Small intestine datasets
            
            data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
            
            dataset_name = '*SA*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:3),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-1-KRAS"; "SA1-1-APC"; "SA1-1-APC-KRAS" ];
            extensive_filesToProcess(delta+(4:7),:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            extensive_filesToProcess(delta+(8:9),:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-1-KRAS"; "SA2-1-APC-KRAS" ];
            extensive_filesToProcess(delta+(10:13),:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-2-WT"; "SA2-2-KRAS"; "SA2-2-APC"; "SA2-2-APC-KRAS" ];
            
            % Epitelium
            
            dataset_name = '*SA1-2*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:4),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT Epit"; "SA1-2-KRAS Epit"; "SA1-2-APC Epit"; "SA1-2-APC-KRAS Epit" ];
            extensive_filesToProcess(delta+(5:8),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT not Epit"; "SA1-2-KRAS not Epit"; "SA1-2-APC not Epit"; "SA1-2-APC-KRAS not Epit" ];
            
            % Colon datasets
            
            dataset_name = '*CB*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:4),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "CB1-1-WT"; "CB1-1-KRAS"; "CB1-1-APC"; "CB1-1-APC-KRAS" ];
            
            extensive_filesToProcess(delta+(5:7),:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "CB1-2-WT"; "CB1-2-APC"; "CB1-2-APC-KRAS" ];
            
            extensive_filesToProcess(delta+(8:11),:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-1-WT"; "CB2-1-KRAS"; "CB2-1-APC"; "CB2-1-APC-KRAS" ];
            
            extensive_filesToProcess(delta+(12:15),:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-2-WT"; "CB2-2-KRAS"; "CB2-2-APC"; "CB2-2-APC-KRAS" ];
            
            % Epitelium
            
            dataset_name = '*CB2-1*';
            
            filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:4),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-1-WT Epit"; "CB2-1-KRAS Epit"; "CB2-1-APC Epit"; "CB2-1-APC-KRAS Epit" ];
            
            extensive_filesToProcess(delta+(5:8),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-1-WT not Epit"; "CB2-1-KRAS not Epit"; "CB2-1-APC not Epit"; "CB2-1-APC-KRAS not Epit" ];
            
        end
        
        outputs_xy_pairs = [];
        
    case "negative DESI small intestine SA 1-2 epit and not epit"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*SA1-2*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-2-WT Epit"; "SA1-2-KRAS Epit"; "SA1-2-APC Epit"; "SA1-2-APC-KRAS Epit" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT not Epit"; "SA1-2-KRAS not Epit"; "SA1-2-APC not Epit"; "SA1-2-APC-KRAS not Epit" ];
            
        end
        
    case "negative DESI intracolonic tumour & normal tissues"
        
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\' };
        
        dataset_name = '*slide9*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            % Tumour
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "IT9-C-APC-tumour"; "IT9-G-APC-tumour"; "IT9-A-APC-KRAS-tumour"; "IT9-D-APC-KRAS-tumour" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "IT9-C-APC-normal"; "IT9-G-APC-normal"; "IT9-A-APC-KRAS-normal"; "IT9-D-APC-KRAS-normal" ];
            
        end
        
        outputs_xy_pairs = [
            1 1;
            1 2;
            2 1;
            2 2;
            1 4;
            1 5;
            2 4;
            2 5;
            ];
        
    case "negative DESI intracolonic tumours"
        
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\' };
        
        dataset_name = '*slide9*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = 0;
            
            extensive_filesToProcess(delta+(1:4),:) = filesToProcess(1,:);
            smaller_masks_list = [
                "IT9-C-APC";
                "IT9-G-APC";
                "IT9-A-APC-KRAS";
                "IT9-D-APC-KRAS";
                ];
            
        end
        
        outputs_xy_pairs = [
            1 1;
            1 2;
            2 1;
            2 2;
            ];
        
    case "negative DESI small intestine 2019-06"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\Second Round Samples\Synapt\' };
        
        dataset_name = '*20190605*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = 0;
            
            extensive_filesToProcess(delta+(1:8),:) = filesToProcess(1,:);
            smaller_masks_list = [
                "SI-B2-4-WT-1"; "SI-B2-4-KRAS-1"; "SI-B2-4-APC-1"; "SI-B2-4-APC-KRAS-1";
                "SI-B2-4-WT-2"; "SI-B2-4-APC-2"; "SI-B2-4-APC-KRAS-2";
                "SI-B2-4-WT-3";
                ];
            
        end
        
        %
        
        dataset_name = '*20190610*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:8),:) = filesToProcess(1,:);
            smaller_masks_list = [
                smaller_masks_list;
                "SI-B1-17-WT-1"; "SI-B1-17-KRAS-1"; "SI-B1-17-APC-1"; "SI-B1-17-APC-KRAS-1";
                "SI-B1-17-KRAS-2"; "SI-B1-17-APC-2"; "SI-B1-17-APC-KRAS-2";
                "SI-B1-17-KRAS-3";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1; 1 2; 3 2; 4 2; 1 3; 1 4; 2 4; 3 4; 4 4; 2 2; 3 3; 4 3; 2 3;
            ];
        
    case "negative DESI SI B2 7 2019 09 04"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\Second Round Samples\Xevo\' };
        
        dataset_name = '*20190904*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SI-B2-7-WT-1"; "SI-B2-7-KRAS-1"; "SI-B2-7-APC-1"; "SI-B2-7-APC-KRAS-1" ];
            
            extensive_filesToProcess(5:7,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B2-7-WT-2"; "SI-B2-7-APC-2"; "SI-B2-7-APC-KRAS-2" ];
            
            extensive_filesToProcess(8,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B2-7-WT-3" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 3 2; 4 2;
            1 3;
            ];
        
    case "negative DESI small intestine all ok"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*S*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-1-KRAS"; "SA1-1-APC"; "SA1-1-APC-KRAS" ];
            extensive_filesToProcess(4:7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            extensive_filesToProcess(8:9,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-1-KRAS"; "SA2-1-APC-KRAS" ];
            extensive_filesToProcess(10:13,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-2-WT"; "SA2-2-KRAS"; "SA2-2-APC"; "SA2-2-APC-KRAS" ];
            
        end
        
        %
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\Second Round Samples\Synapt\' };
        
        dataset_name = '*20190605*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:8),:) = filesToProcess(1,:);
            smaller_masks_list = [
                smaller_masks_list;
                "SI-B2-4-WT-1"; "SI-B2-4-KRAS-1"; "SI-B2-4-APC-1"; "SI-B2-4-APC-KRAS-1";
                "SI-B2-4-WT-2"; "SI-B2-4-APC-2"; "SI-B2-4-APC-KRAS-2";
                "SI-B2-4-WT-3";
                ];
            
        end
        
        %
        
        dataset_name = '*20190610*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:8),:) = filesToProcess(1,:);
            smaller_masks_list = [
                smaller_masks_list;
                "SI-B1-17-WT-1"; "SI-B1-17-KRAS-1"; "SI-B1-17-APC-1"; "SI-B1-17-APC-KRAS-1";
                "SI-B1-17-KRAS-2"; "SI-B1-17-APC-2"; "SI-B1-17-APC-KRAS-2";
                "SI-B1-17-KRAS-3";
                ];
            
        end
        
        %
        
        dataset_name = '*2019_07_10*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:8),:) = filesToProcess(1,:);
            smaller_masks_list = [
                smaller_masks_list;
                "SI-B1-20-WT-1"; "SI-B1-20-KRAS-1"; "SI-B1-20-APC-1"; "SI-B1-20-APC-KRAS-1";
                "SI-B1-20-KRAS-2"; "SI-B1-20-APC-2"; "SI-B1-20-APC-KRAS-2";
                "SI-B1-20-KRAS-3"
                ];
            
        end
        
        %
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\Second Round Samples\Xevo\' };
        
        dataset_name = '*20190904*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:8),:) = filesToProcess(1,:);
            smaller_masks_list = [
                smaller_masks_list;
                "SI-B2-7-WT-1"; "SI-B2-7-KRAS-1"; "SI-B2-7-APC-1"; "SI-B2-7-APC-KRAS-1";
                "SI-B2-7-WT-2"; "SI-B2-7-APC-2"; "SI-B2-7-APC-KRAS-2";
                "SI-B2-7-WT-3"
                ];
            
        end
        
        %
        
        dataset_name = '*20190513*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:8),:) = filesToProcess(1,:);
            smaller_masks_list = [
                smaller_masks_list;
                "SI-B2-1-WT-1"; "SI-B2-1-KRAS-1"; "SI-B2-1-APC-1"; "SI-B2-1-APC-KRAS-1";
                "SI-B2-1-WT-2"; "SI-B2-1-APC-2"; "SI-B2-1-APC-KRAS-2";
                "SI-B2-1-WT-3"
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 3 1; 4 1; 1 3; 2 3; 3 3; 4 3; 2 2; 4 2; 1 4; 2 4; 3 4; 4 4;
            1 5; 2 5; 3 5; 4 5; 1 6; 3 6; 4 6; 1 7; 1 8; 2 8; 3 8; 4 8; 2 6; 3 7; 4 7; 2 7; 1 9; 2 9; 3 9; 4 9; 2 10; 3 10; 4 10; 2 11;
            1 12; 2 12; 3 12; 4 12; 1 13; 3 13; 4 13; 1 14; 1 15; 2 15; 3 15; 4 15; 1 16; 3 16; 4 16; 1 17;
            ];
        
        
        
    case "neg DESI intracolonic apc vs apc kras"
        
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\' };
        
        dataset_name = '*slide9*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "c_apc_addbackground"; "g_apc_addbackground"; "a_apckras_addbackground"; "d_apckras_addbackground" ];
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "c_apc"; "g_apc"; "a_apckras"; "d_apckras" ];
            
        end
        
        outputs_xy_pairs = [
            1 1; 1 2;
            2 1; 2 2;
            ];
        
    case "neg DESI intracolonic"
        
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\' };
        
        dataset_name = '*slide9*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [
                "intracolonic-tissue-3";  "intracolonic-tissue-4"; "intracolonic-tissue-5";  "intracolonic-tissue-6";
                "intracolonic-tissue-1"; "intracolonic-tissue-2"; "intracolonic-tissue-7" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 3; 1 4;
            2 1; 2 2; 2 3;
            ];
        
    case "neg DESI intracolonic A G C D"
        
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\' };
        
        dataset_name = '*slide9*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [  "intracolonic-tissue-3"; "intracolonic-tissue-5"; "intracolonic-tissue-2"; "intracolonic-tissue-7" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2;
            2 1; 2 2;
            ];
        
    case "neg plasma-AP-MALDI 50um intracolonic"
        
        data_folders = { 'X:\Beatson\Intracolonic tumour study\plasma-AP-MALDI MSI\2019_08_30_intracolonic\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "tissue only 1"; "tissue only 2"; "tissue only 3" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 3
            ];
        
        
        
    case "negative DESI 2018 sm & 2019 ic (sa 1 2 epit)"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*S*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-1-KRAS"; "SA1-1-APC"; "SA1-1-APC-KRAS" ];
            
            extensive_filesToProcess(4:7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT Epit"; "SA1-2-KRAS Epit"; "SA1-2-APC Epit"; "SA1-2-APC-KRAS Epit" ];
            extensive_filesToProcess(8:11,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT not Epit"; "SA1-2-KRAS not Epit"; "SA1-2-APC not Epit"; "SA1-2-APC-KRAS not Epit" ];
            
            extensive_filesToProcess(12:13,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-1-KRAS"; "SA2-1-APC-KRAS" ];
            
            extensive_filesToProcess(14:17,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-2-WT"; "SA2-2-KRAS"; "SA2-2-APC"; "SA2-2-APC-KRAS" ];
            
        end
        
        %
        
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\' };
        
        dataset_name = '*slide9*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:7),:) = filesToProcess(1,:);
            smaller_masks_list = [
                smaller_masks_list;
                "intracolonic-tissue-1";
                "intracolonic-tissue-2";
                "intracolonic-tissue-3";
                "intracolonic-tissue-4";
                "intracolonic-tissue-5";
                "intracolonic-tissue-6";
                "intracolonic-tissue-7"
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 3 1; 4 1;
            
            1 3; 2 3; 3 3; 4 3;
            1 4; 2 4; 3 4; 4 4;
            
            2 2; 4 2;
            
            1 5; 2 5; 3 5; 4 5;
            
            1 5; 2 5; 3 5; 4 5; 5 5; 6 5; 7 5;
            ];
        
    case "negative DESI 2018 sm & 2019 ic"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*S*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-1-KRAS"; "SA1-1-APC"; "SA1-1-APC-KRAS" ];
            extensive_filesToProcess(4:7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            extensive_filesToProcess(8:9,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-1-KRAS"; "SA2-1-APC-KRAS" ];
            extensive_filesToProcess(10:13,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-2-WT"; "SA2-2-KRAS"; "SA2-2-APC"; "SA2-2-APC-KRAS" ];
            
        end
        
        %
        
        data_folders = { 'X:\Beatson\Intracolonic tumour study\Neg DESI Data\Xevo V3 Sprayer\' };
        
        dataset_name = '*slide9*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:7),:) = filesToProcess(1,:);
            smaller_masks_list = [
                smaller_masks_list;
                "intracolonic-tissue-1";
                "intracolonic-tissue-2";
                "intracolonic-tissue-3";
                "intracolonic-tissue-4";
                "intracolonic-tissue-5";
                "intracolonic-tissue-6";
                "intracolonic-tissue-7"
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 3 1; 4 1;
            1 3; 2 3; 3 3; 4 3;
            2 2; 4 2;
            1 4; 2 4; 3 4; 4 4;
            
            1 5; 2 5; 3 5; 4 5; 5 5; 6 5; 7 5;
            ];
        
    case "negative DESI SI 2018 03 & 2019 07"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*S*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-1-KRAS"; "SA1-1-APC"; "SA1-1-APC-KRAS" ];
            extensive_filesToProcess(4:7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            extensive_filesToProcess(8:9,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-1-KRAS"; "SA2-1-APC-KRAS" ];
            extensive_filesToProcess(10:13,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-2-WT"; "SA2-2-KRAS"; "SA2-2-APC"; "SA2-2-APC-KRAS" ];
            
        end
        
        %
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\Second Round Samples\Synapt\' };
        
        dataset_name = '*2019_07*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-20-WT-1" ];
            
            extensive_filesToProcess(delta+(2:4),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-20-Kras-1";  "SI-B1-20-Kras-2";  "SI-B1-20-Kras-3" ];
            
            extensive_filesToProcess(delta+(5:6),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-20-APC-1"; "SI-B1-20-APC-2" ];
            
            extensive_filesToProcess(delta+(7:8),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-20-APC-KRAS-1"; "SI-B1-20-APC-KRAS-2" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 3 1; 4 1;
            1 3; 2 3; 3 3; 4 3;
            2 2; 4 2;
            1 4; 2 4; 3 4; 4 4;
            
            1 5;
            2 5; 2 6; 2 7;
            3 5; 3 6;
            4 5; 4 6;
            ];
        
    case "negative DESI 2018 03 & 2019 06 & 07"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*S*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-1-KRAS"; "SA1-1-APC"; "SA1-1-APC-KRAS" ];
            extensive_filesToProcess(4:7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            extensive_filesToProcess(8:9,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-1-KRAS"; "SA2-1-APC-KRAS" ];
            extensive_filesToProcess(10:13,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-2-WT"; "SA2-2-KRAS"; "SA2-2-APC"; "SA2-2-APC-KRAS" ];
            
        end
        
        %
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\Second Round Samples\Synapt\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            delta = size(extensive_filesToProcess,1);
            
            extensive_filesToProcess(delta+(1:4),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B2-4-WT-1"; "SI-B2-4-KRAS-1"; "SI-B2-4-APC-1"; "SI-B2-4-APC-KRAS-1" ];
            
            extensive_filesToProcess(delta+(5:7),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B2-4-WT-2"; "SI-B2-4-APC-2"; "SI-B2-4-APC-KRAS-2" ];
            
            extensive_filesToProcess(delta+(8:11),:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-17-WT-1"; "SI-B1-17-KRAS-1"; "SI-B1-17-APC-1"; "SI-B1-17-APC-KRAS-1" ];
            
            extensive_filesToProcess(delta+(12:14),:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-17-KRAS-2"; "SI-B1-17-APC-2"; "SI-B1-17-APC-KRAS-2"; ];
            
            extensive_filesToProcess(delta+(15),:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B2-4-WT-3" ];
            
            extensive_filesToProcess(delta+(16),:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-17-KRAS-3" ];
            
            extensive_filesToProcess(delta+(17:20),:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-20-WT-1"; "SI-B1-20-KRAS-1"; "SI-B1-20-APC-1"; "SI-B1-20-APC-KRAS-1" ];
            
            extensive_filesToProcess(delta+(21:23),:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-20-KRAS-2"; "SI-B1-20-APC-2"; "SI-B1-20-APC-KRAS-2" ];
            
            extensive_filesToProcess(delta+(24),:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-20-KRAS-3" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 3 1; 4 1;
            1 3; 2 3; 3 3; 4 3;
            2 2; 4 2;
            1 4; 2 4; 3 4; 4 4;
            
            1 5; 2 5; 3 5; 4 5;
            1 6; 3 6; 4 6;
            1 7; 2 7; 3 7; 4 7;
            2 8; 3 8; 4 8;
            1 8;
            2 6;
            1 9; 2 9; 3 9; 4 9;
            2 10; 3 10; 4 10;
            2 11;
            ];
        
    case "negative DESI Synapt SLC7a5"
        
        data_folders = { 'X:\Beatson\SLC7a5 study\NPL data\negative DESI ibds and imzMLs\Synapt-old sprayer\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "V2C"; "V2B"; "V2I"; ];
            
            extensive_filesToProcess(4:6,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "R4J"; "R4G"; "R4H";  ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 3;
            2 1; 2 2; 2 3;
            ];
        
    case "ICL negative DESI SI - SA"
        
        data_folders = { 'X:\Beatson\data from ICL\2018_10_30_Beatson_(16-08-2018)_SA_neg_75umpixel_150um stage speed (slidelabel left)\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:7,:) = filesToProcess(1,:);
            smaller_masks_list = [ "WT-1"; "KRAS-1"; "KRAS-2";"APC-1";"APC-2";"APC-KRAS-1";"APC-KRAS-2" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1;
            2 1; 2 2
            3 1; 3 2;
            4 1; 4 2;
            ];
        
    case "negative DESI SI Second Batch Slides 4 and 17"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\Second Round Samples\Synapt\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SI-B1-4-WT-1"; "SI-B1-4-WT-2"; "SI-B1-4-WT-3" ];
            
            extensive_filesToProcess(4,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-17-WT-1"  ];
            
            extensive_filesToProcess(5,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-4-Kras-1" ];
            
            extensive_filesToProcess(6:8,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-17-Kras-1"; "SI-B1-17-Kras-2"; "SI-B1-17-Kras-3"; ];
            
            extensive_filesToProcess(9:10,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-4-APC-1"; "SI-B1-4-APC-2" ];
            
            extensive_filesToProcess(11:12,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-17-Apc-1"; "SI-B1-17-Apc-2" ];
            
            extensive_filesToProcess(13:14,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-4-ApcKras-1"; "SI-B1-4-ApcKras-2"];
            
            extensive_filesToProcess(15:16,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SI-B1-17-ApcKras-1"; "SI-B1-17-ApcKras-2"];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 3; 1 4;
            2 1; 2 2; 2 3; 2 4;
            3 1; 3 2; 3 3; 3 4;
            4 1; 4 2; 4 3; 4 4;
            ];
        
    case "negative REIMS"
        
        data_folders = { 'X:\Beatson\negative REIMS ibds and imzMLs\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
            extensive_filesToProcess(1:47,:) = filesToProcess(1,:);
            
            smaller_masks_list = [
                
            "S-RZP10.1F-F-WT-WT"
            "S-RZP10.1B-M-WT-WT"
            "S-RZP10.1C-M-WT-WT"
            
            "S-RZF27.3E-F-HOM-WT"
            "S-RZF27.3F-F-HOM-WT"
            "S-RZF23.6C-F-HOM-WT"
            "S-RZF29.1G-M-HOM-WT"
            "S-RZF27.2A-M-HOM-WT"
            "S-RZF27.2B-M-HOM-WT"
            "S-RZF27.3C-M-HOM-WT"
            "S-RZF24.5A-M-HOM-WT"
            "S-RZF24.5C-M-HOM-WT"
            "S-RZF23.6A-M-HOM-WT"
            "S-RZF23.6B-M-HOM-WT"
            
            "S-RZP10.1D-F-WT-HET"
            "S-RZP10.1E-F-WT-HET"
            "S-RZP10.1A-M-WT-HET"
            "S-RZP10.2A-M-WT-HET"
            
            "S-RZF33.2E-F-HOM-HET"
            "S-RZF31.3D-F-HOM-HET"
            "S-RZF27.4E-F-HOM-HET"
            "S-RZF31.2D-M-HOM-HET"
            
            "S-RCC32.1C-M-HOM-WT-HOM"
            "S-RCC32.1D-M-HOM-WT-HOM"
            
            "S-RCC31.1A-F-HOM-HET-HOM"
            "S-RCC32.2A-F-HOM-HET-HOM"
            "S-RCC31.2D-F-HOM-HET-HOM"
            "S-RCC31.1B-F-HOM-HET-HOM"
            "S-RCC31.2B-M-HOM-HET-HOM"
            
            "C-RZF27.3E-F-HOM-WT"
            "C-RZF27.3F-F-HOM-WT"
            "C-RZF23.6C-F-HOM-WT"
            "C-RZF29.1G-M-HOM-WT"
            "C-RZF27.2A-M-HOM-WT"
            "C-RZF27.2B-M-HOM-WT"
            "C-RZF27.3C-M-HOM-WT"
            "C-RZF24.5A-M-HOM-WT"
            "C-RZF24.5C-M-HOM-WT"
            "C-RZF23.6A-M-HOM-WT"
            "C-RZF23.6B-M-HOM-WT"
            
            "C-RCC32.1C-M-HOM-WT-HOM"
            "C-RCC32.1D-M-HOM-WT-HOM"
            
            "C-RCC31.1A-F-HOM-HET-HOM"
            "C-RCC31.1B-F-HOM-HET-HOM"
            "C-RCC32.2A-F-HOM-HET-HOM"
            "C-RCC31.2D-F-HOM-HET-HOM"
            "C-RCC31.2B-M-HOM-HET-HOM"
            
            ];
        
        end
        
        %
        
        outputs_xy_pairs = [
            (1:3)'      ones(3,1)
            (8:18)'     ones(11,1)
            (23:26)'    ones(4,1);
            (31:34)'    ones(4,1);
            (39:40)'    ones(2,1);
            (45:49)'    ones(5,1);
            
            (8:18)'     repmat(2,11,1);
            (39:40)'    repmat(2,2,1);
            (45:49)'    repmat(2,5,1);
            ];
        
    case "13C Glutamine APC and APC-KRAS"
        
        data_folders = { 'X:\Beatson\SLC7a5 study\NPL data\negative DESI ibds and imzMLs\Xevo V3 Sprayer\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:8,:) = filesToProcess(1,:);
            smaller_masks_list = [ "WT_503a"; "WT_503c"; "WT_503e"; "WT_503f"; "MT_473c"; "MT_483c"; "MT_483d"; "MT_493d" ];
            
        end
        
        %
        
        outputs_xy_pairs = [ 1 1; 1 2; 1 3; 1 4; 2 1; 2 2; 2 3; 2 4 ];
        
    case "SLC7a5 negative DESI"
        
        data_folders = { 'X:\Beatson\SLC7a5 study\NPL data\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:6,:) = filesToProcess(1,:);
            smaller_masks_list = [ "WT-1"; "WT-2"; "WT-3"; "APC-KRAS-SLC7a5-1"; "APC-KRAS-SLC7a5-2"; "APC-KRAS-SLC7a5-3" ];
            
        end
        
        %
        
        outputs_xy_pairs = [ 1 1; 1 2; 1 3; 2 1; 2 2; 2 3 ];
        
    case "SLC7a5 positive DESI"
        
        data_folders = { 'X:\Beatson\SLC7a5 study\NPL data\positive DESI ibds and imzMLs\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:6,:) = filesToProcess(1,:);
            smaller_masks_list = [ "WT-1"; "WT-2"; "WT-3"; "APC-KRAS-SLC7a5-1"; "APC-KRAS-SLC7a5-2"; "APC-KRAS-SLC7a5-3" ];
            
        end
        
        %
        
        outputs_xy_pairs = [ 1 1; 1 2; 1 3; 2 1; 2 2; 2 3 ];
        
        
    case "negative DESI colon"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*C*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "CB1-1-WT"; "CB1-1-KRAS"; "CB1-1-APC"; "CB1-1-APC-KRAS" ];
            
            extensive_filesToProcess(5:7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "CB1-2-WT"; "CB1-2-APC"; "CB1-2-APC-KRAS" ];
            
            extensive_filesToProcess(8:11,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-1-WT"; "CB2-1-KRAS"; "CB2-1-APC"; "CB2-1-APC-KRAS" ];
            
            extensive_filesToProcess(12:15,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-2-WT"; "CB2-2-KRAS"; "CB2-2-APC"; "CB2-2-APC-KRAS" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 3; 3 3; 4 3;
            1 2; 2 2; 3 2; 4 2;
            1 4; 2 4; 3 4; 4 4
            ];
        
    case "negative DESI colon epit musc"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*CB2-1*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "CB2-1-WT"; "CB2-1-KRAS"; "CB2-1-APC"; "CB2-1-APC-KRAS" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-1-WT Epit"; "CB2-1-KRAS Epit"; "CB2-1-APC Epit"; "CB2-1-APC-KRAS Epit" ];
            
            extensive_filesToProcess(9:12,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-1-WT Musc"; "CB2-1-KRAS Musc"; "CB2-1-APC Musc"; "CB2-1-APC-KRAS Musc" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 2 2; 3 2; 4 2;
            1 3; 2 3; 3 3; 4 3;
            ];
        
    case "negative DESI colon epit only"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*CB2-1*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "CB2-1-WT Epit"; "CB2-1-KRAS Epit"; "CB2-1-APC Epit"; "CB2-1-APC-KRAS Epit" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            ];
        
    case "negative DESI small intestine epit musc"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*SA1-2*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT Epit"; "SA1-2-KRAS Epit"; "SA1-2-APC Epit"; "SA1-2-APC-KRAS Epit" ];
            
            extensive_filesToProcess(9:12,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT Musc"; "SA1-2-KRAS Musc"; "SA1-2-APC Musc"; "SA1-2-APC-KRAS Musc" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 2 2; 3 2; 4 2;
            1 3; 2 3; 3 3; 4 3;
            ];
        
    case "negative DESI colon CB 2-1 epit and not epit"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*CB2-1*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "CB2-1-WT Epit"; "CB2-1-KRAS Epit"; "CB2-1-APC Epit"; "CB2-1-APC-KRAS Epit" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-1-WT not Epit"; "CB2-1-KRAS not Epit"; "CB2-1-APC not Epit"; "CB2-1-APC-KRAS not Epit" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 2 2; 3 2; 4 2;
            ];
        
    case "negative DESI small intestine SA 1-2 epit and not epit"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*SA1-2*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-2-WT Epit"; "SA1-2-KRAS Epit"; "SA1-2-APC Epit"; "SA1-2-APC-KRAS Epit" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT not Epit"; "SA1-2-KRAS not Epit"; "SA1-2-APC not Epit"; "SA1-2-APC-KRAS not Epit" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 2 2; 3 2; 4 2;
            ];
        
    case "negative DESI small intestine epit only"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*SA1-2*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-2-WT Epit"; "SA1-2-KRAS Epit"; "SA1-2-APC Epit"; "SA1-2-APC-KRAS Epit" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            ];
        
    case "negative DESI small intestine all"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative DESI ibds and imzMLs\' };
        
        dataset_name = '*S*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-1-KRAS"; "SA1-1-APC"; "SA1-1-APC-KRAS" ];
            extensive_filesToProcess(4:7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            extensive_filesToProcess(8:9,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-1-KRAS"; "SA2-1-APC-KRAS" ];
            extensive_filesToProcess(10:13,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-2-WT"; "SA2-2-KRAS"; "SA2-2-APC"; "SA2-2-APC-KRAS" ];
            extensive_filesToProcess(14:17,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "SB-2-WT"; "SB-2-KRAS"; "SB-2-APC"; "SB-2-APC-KRAS" ];
            extensive_filesToProcess(18:21,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "SB-1-WT"; "SB-1-KRAS"; "SB-1-APC"; "SB-1-APC-KRAS" ];
            extensive_filesToProcess(22:24,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "SA-1-KRAS"; "SA-1-APC"; "SA-1-APC-KRAS" ];
            extensive_filesToProcess(25:28,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "SA-2-WT"; "SA-2-KRAS"; "SA-2-APC"; "SA-2-APC-KRAS" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 3 1; 4 1;
            1 4; 2 4; 3 4; 4 4;
            2 2; 4 2;
            1 5; 2 5; 3 5; 4 5;
            1 8; 2 8; 3 8; 4 8;
            1 7; 2 7; 3 7; 4 7;
            2 3; 3 3; 4 3;
            1 6; 2 6; 3 6; 4 6
            ];
        
    case "negative DESI small intestine"
        
        data_folders = { 'X:\Beatson\Pre-tumour models study\negative DESI ibds and imzMLs\Round 1\' };
        
        dataset_name = '*S*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:3,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SA1-1-KRAS"; "SA1-1-APC"; "SA1-1-APC-KRAS" ];
            extensive_filesToProcess(4:7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            extensive_filesToProcess(8:9,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-1-KRAS"; "SA2-1-APC-KRAS" ];
            extensive_filesToProcess(10:13,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-2-WT"; "SA2-2-KRAS"; "SA2-2-APC"; "SA2-2-APC-KRAS" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 3 1; 4 1;
            1 3; 2 3; 3 3; 4 3;
            2 2; 4 2;
            1 4; 2 4; 3 4; 4 4;
            ];
        
    case "negative MALDI colon"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative MALDI ibds and imzMLs\' };
        
        dataset_name = '*C*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "tissue only";
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "CB1-1-WT-BACKGROUND"; "CB1-1-KRAS-BACKGROUND"; "CB1-1-APC-BACKGROUND"; "CB1-1-APC-KRAS-BACKGROUND" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "CB1-2-WT-BACKGROUND"; "CB1-2-KRAS-BACKGROUND"; "CB1-2-APC-BACKGROUND"; "CB1-2-APC-KRAS-BACKGROUND" ];
            
            extensive_filesToProcess(9:12,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-1-WT-BACKGROUND"; "CB2-1-KRAS-BACKGROUND"; "CB2-1-APC-BACKGROUND"; "CB2-1-APC-KRAS-BACKGROUND" ];
            
            extensive_filesToProcess(13:16,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-2-WT-BACKGROUND"; "CB2-2-KRAS-BACKGROUND"; "CB2-2-APC-BACKGROUND"; "CB2-2-APC-KRAS-BACKGROUND" ];
            
        elseif background == 0
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "CB1-1-WT"; "CB1-1-KRAS"; "CB1-1-APC"; "CB1-1-APC-KRAS" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "CB1-2-WT"; "CB1-2-KRAS"; "CB1-2-APC"; "CB1-2-APC-KRAS" ];
            
            extensive_filesToProcess(9:12,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-1-WT"; "CB2-1-KRAS"; "CB2-1-APC"; "CB2-1-APC-KRAS" ];
            
            extensive_filesToProcess(13:16,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "CB2-2-WT"; "CB2-2-KRAS"; "CB2-2-APC"; "CB2-2-APC-KRAS" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 3; 2 3; 3 3; 4 3;
            1 2; 2 2; 3 2; 4 2;
            1 4; 2 4; 3 4; 4 4
            ];
        
    case "negative MALDI small intestine"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\negative MALDI ibds and imzMLs\' };
        
        dataset_name = '*S*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SB1-2-WT"; "SB1-2-KRAS"; "SB1-2-APC"; "SB1-2-APC-KRAS" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SB2-1-WT"; "SB2-1-KRAS"; "SB2-1-APC"; "SB2-1-APC-KRAS" ];
            
            extensive_filesToProcess(9:12,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SB2-2-WT"; "SB2-2-KRAS"; "SB2-2-APC"; "SB2-2-APC-KRAS" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 2; 2 2; 3 2; 4 2;
            1 1; 2 1; 3 1; 4 1;
            1 3; 2 3; 3 3; 4 3;
            ];
        
    case "positive DESI colon"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\positive DESI ibds and imzMLs\' };
        
        dataset_name = '*20180213*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "CA2-1-WT"; "CA2-1-KRAS"; "CA2-1-APC"; "CA2-1-APC-KRAS" ];
            
            extensive_filesToProcess(5:7,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "CA2-2-WT"; "CA2-2-APC"; "CA2-2-APC-KRAS" ];
            
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 3 2; 4 2;
            ];
        
    case "positive DESI small intestine v1"
        
        data_folders = { 'X:\Beatson\positive DESI ibds and imzMLs\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ "SB1-1-WT"; "SB1-1-KRAS"; "SB1-1-APC"; "SB1-1-APC-KRAS" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "SB2-1-WT"; "SB2-1-KRAS"; "SB2-1-APC"; "SB2-1-APC-KRAS" ];
            
            extensive_filesToProcess(9:12,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SB1-2-WT"; "SB1-2-KRAS"; "SB1-2-APC"; "SB1-2-APC-KRAS" ];
            
            extensive_filesToProcess(13:16,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "SB2-2-WT"; "SB2-2-KRAS"; "SB2-2-APC"; "SB2-2-APC-KRAS" ];
            
            extensive_filesToProcess(17:19,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-1-WT"; "SA1-1-KRAS"; "SA1-1-APC" ];
            
            extensive_filesToProcess(20:23,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 2 2; 3 2; 4 2;
            1 3; 2 3; 3 3; 4 3;
            1 4; 2 4; 3 4; 4 4;
            1 5; 2 5; 3 5;
            1 6; 2 6; 3 6; 4 6;
            ];
        
    case "positive DESI small intestine v2"
        
        data_folders = { 'X:\Beatson\positive DESI ibds and imzMLs\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(2,:);
            smaller_masks_list = [ "SB1-2-WT"; "SB1-2-KRAS"; "SB1-2-APC"; "SB1-2-APC-KRAS" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "SB2-2-WT"; "SB2-2-KRAS"; "SB2-2-APC"; "SB2-2-APC-KRAS" ];
            
            extensive_filesToProcess(9:12,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "SB2-1-WT"; "SB2-1-KRAS"; "SB2-1-APC"; "SB2-1-APC-KRAS" ];
            
            extensive_filesToProcess(13:15,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-1-WT"; "SA1-1-KRAS"; "SA1-1-APC" ];
            
            extensive_filesToProcess(16:19,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            
        end
        
    case "positive DESI small intestine"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\positive DESI ibds and imzMLs\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,:) = filesToProcess(6,:);
            smaller_masks_list = [ "SB2-1-WT"; "SB2-1-KRAS"; "SB2-1-APC"; "SB2-1-APC-KRAS" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "SB2-2-WT"; "SB2-2-KRAS"; "SB2-2-APC"; "SB2-2-APC-KRAS" ];
            
            extensive_filesToProcess(9:12 ,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC"; "SA1-2-APC-KRAS" ];
            
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 2 2; 3 2; 4 2;
            1 3; 2 3; 3 3; 4 3;
            ];
        
    case "positive MALDI colon"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\positive MALDI ibds and imzMLs\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(1,:);
            smaller_masks_list = "CA1-1-WT";
            
            extensive_filesToProcess(2:4,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "CA1-1-KRAS"; "CA1-1-APC"; "CA1-1-APC-KRAS" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "CA2-1-WT"; "CA2-1-KRAS"; "CA2-1-APC"; "CA2-1-APC-KRAS" ];
            
            extensive_filesToProcess(9:11,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "CA1-2-KRAS"; "CA1-2-APC"; "CA1-2-APC-KRAS" ];
            
            extensive_filesToProcess(12:15,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "CA2-2-WT"; "CA2-2-KRAS"; "CA2-2-APC"; "CA2-2-APC-KRAS" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 2 2; 3 2; 4 2;
            2 3; 3 3; 4 3;
            1 4; 2 4; 3 4; 4 4;
            ];
        
    case "positive MALDI small intestine"
        
        data_folders = { 'X:\Beatson\pre-tumour models study\positive MALDI ibds and imzMLs\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(5,:);
            smaller_masks_list = "SA1-1-WT";
            
            extensive_filesToProcess(2:4,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-1-KRAS"; "SA1-1-APC"; "SA1-1-APC-KRAS" ];
            
            extensive_filesToProcess(5:8,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-1-WT"; "SA2-1-KRAS"; "SA2-1-APC"; "SA2-1-APC-KRAS" ];
            
            extensive_filesToProcess(9:11,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "SA1-2-WT"; "SA1-2-KRAS"; "SA1-2-APC-KRAS" ];
            
            extensive_filesToProcess(12:15,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "SA2-2-WT"; "SA2-2-KRAS"; "SA2-2-APC"; "SA2-2-APC-KRAS" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 2 2; 3 2; 4 2;
            1 3; 2 3; 4 3;
            1 4; 2 4; 3 4; 4 4;
            ];
        
end

filesToProcess = f_unique_extensive_filesToProcess(extensive_filesToProcess); % This function collects all files that need to have a common axis.

if check_datacubes_size==1
    
    for file_index = 1:length(filesToProcess)
        
        disp(filesToProcess(file_index).name(1,1:end-6))
        
        csv_inputs = [ filesToProcess(file_index).folder '\inputs_file' ];
        
        [ ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, ~, outputs_path ] = f_reading_inputs(csv_inputs);
        
        spectra_details_path    = [ char(outputs_path) '\spectra details\' ];
        
        load([ spectra_details_path filesToProcess(file_index).name(1,1:end-6) '\' char(main_mask_list) '\datacubeonly_peakDetails' ])
        
        if file_index==1
            
            old_datacubeonly_peakDetails = datacubeonly_peakDetails;
            
        elseif ~isequal(old_datacubeonly_peakDetails, datacubeonly_peakDetails)
            
            disp('!!! ISSUE !!! Datasets do NOT have a compatible mz axis. Please check and make sure that all datasets to be combined have a commom list of peaks and matches.')
            
        end
        
    end
    
end