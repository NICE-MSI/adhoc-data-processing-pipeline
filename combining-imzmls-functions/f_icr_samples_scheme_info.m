
function [ extensive_filesToProcess, main_mask_list, smaller_masks_list, outputs_xy_pairs ] = f_icr_samples_scheme_info( dataset_name )

% This function is used to define "new" datasets for the ICR project,
% which are built by combining multiple imzmls and using small masks.


background = 0;

switch dataset_name
    
    case "cell pellets"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = {'*pdx*','*35_1*','*35_2*','*35_3*','*35_e*','*23_1*','*23_2*'};
        
        filesToProcess = []; for i = 1:length(data_folders); for ii = 1:length(dataset_name); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name{ii} '.imzML']) ]; end; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:21,1) = filesToProcess([3:7 9:24],1);
            smaller_masks_list = [
                "cp-1458-2";
                "cp-1282-4";
                "cp-1282-5";
                "cp-1458-4";
                "cp-1458-3";
                "cp-1458-5";
                "cp-1282-2";
                "cp-JOOO100674";
                "cp-TMO099";
                "cp-TMO112";
                "cp-JOOO104720";
                "cp-TMO098";
                "cp-TMO1273";
                "cp-TMO0091";
                "cp-TMO1117";
                "cp-35-1";
                "cp-35-2";
                "cp-35-3";
                "cp-35-e";
                "cp-23-1";
                "cp-23-2";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 14-13; 2 16-13; 2 17-13; 1 16-13; 1 15-13; 1 17-13; 2 14-13; 1 18-13; 1 19-13; 2 18-13; 1 20-13; 1 21-13; 2 19-13; 1 22-13; 2 20-13;
            3 14-13; 3 15-13; 3 16-13;
            4 14-13;
            5 14-13;
            6 14-13;
            ];
                
    case "neg desi 3d mt pdx only"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = '*1282*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess(2:end,:);
            smaller_masks_list = [
                "t-1282-4";
                "t-1282-5";
                "t-1282-3";
                "t-1282-2";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 3; 1 4; 1 2; 1 1;
            ];
        
        
    case "neg desi 3d wt pdx only"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = '*1458*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess(2:end,:);
            smaller_masks_list = [
                "t-1458-2";
                "t-1458-4";
                "t-1458-3";
                "t-1458-5";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 3; 1 2; 1 4;
            ];
        
    case "neg desi wt & mt pair"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = {'*pdx*'};
        
        filesToProcess = []; for i = 1:length(data_folders); for ii = 1:length(dataset_name); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name{ii} '.imzML']) ]; end; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess([5 9],:);
            smaller_masks_list = [
                "t-1282-5";
                "t-1458-5";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 2; 1 1;
            ];
        
    case "neg desi pdx & primary + cell pellets"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = {'*pdx*','*35_1*','*35_2*','*35_3*','*35_e*','*23_1*','*23_2*'};
        
        filesToProcess = []; for i = 1:length(data_folders); for ii = 1:length(dataset_name); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name{ii} '.imzML']) ]; end; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess(3:18,:);
            smaller_masks_list = [
                "t-1458-2";
                "t-1282-4";
                "t-1282-5";
                "t-1458-4";
                "t-1458-3";
                "t-1282-3";
                "t-1458-5";
                "t-1282-2";
                "pdx-JOOO100674";
                "pdx-TMO099";
                "pdx-TMO112";
                "pdx-JOOO104720";
                "pdx-TMO098";
                "pdx-TMO1273";
                "pdx-TMO0091";
                "pdx-TMO1117";
                ];
            extensive_filesToProcess(16+(1:4),1) = filesToProcess(19,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-1-18";
                "pt-35-1-20";
                "pt-35-1-28";
                "pt-35-1-33";
                ];
            extensive_filesToProcess(20+(1:5),1) = filesToProcess(20,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-2-25";
                "pt-35-2-32";
                "pt-35-2-55";
                "pt-35-2-80";
                "pt-35-2-81";
                ];
            extensive_filesToProcess(25+(1:4),1) = filesToProcess(21,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-3-12";
                "pt-35-3-36";
                "pt-35-3-70";
                "pt-35-3-78";
                ];
            extensive_filesToProcess(29+(1:11),1) = filesToProcess(22,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-e-4";
                "pt-35-e-6";
                "pt-35-e-7";
                "pt-35-e-8";
                "pt-35-e-9";
                "pt-35-e-11";
                "pt-35-e-12";
                "pt-35-e-17";
                "pt-35-e-18";
                "pt-35-e-19";
                "pt-35-e-21";
                ];
            extensive_filesToProcess(40+(1:13),1) = filesToProcess(23,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-1-1";
                "pt-23-1-2";
                "pt-23-1-3";
                "pt-23-1-4";
                "pt-23-1-6";
                "pt-23-1-7";
                "pt-23-1-8";
                "pt-23-1-9";
                "pt-23-1-10";
                "pt-23-1-11";
                "pt-23-1-12";
                "pt-23-1-13";
                "pt-23-1-14";
                ];
            extensive_filesToProcess(53+(1:5),1) = filesToProcess(24,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-2-15";
                "pt-23-2-18";
                "pt-23-2-19";
                "pt-23-2-21";
                "pt-23-2-22";
                ];
            
            extensive_filesToProcess(58+(1:21),1) = filesToProcess([3:7 9:24],1);
            smaller_masks_list = [
                smaller_masks_list;
                "cp-1458-2";
                "cp-1282-4";
                "cp-1282-5";
                "cp-1458-4";
                "cp-1458-3";
                "cp-1458-5";
                "cp-1282-2";
                "cp-JOOO100674";
                "cp-TMO099";
                "cp-TMO112";
                "cp-JOOO104720";
                "cp-TMO098";
                "cp-TMO1273";
                "cp-TMO0091";
                "cp-TMO1117";
                "cp-35-1";
                "cp-35-2";
                "cp-35-3";
                "cp-35-e";
                "cp-23-1";
                "cp-23-2";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 3; 2 4; 1 3; 1 2; 2 2; 1 4; 2 1; 1 5; 1 6; 2 5; 1 7; 1 8; 2 6; 1 9; 2 7;
            3 1; 3 2; 3 3; 3 4; 3 5; 3 6; 3 7; 3 8; 3 9; 3 10; 3 11; 3 12; 3 13;
            4 1; 4 2; 4 3; 4 4; 4 5; 4 6; 4 7; 4 8; 4 9; 4 10; 4 11;
            5 1; 5 2; 5 3; 5 4; 5 5; 5 6; 5 7; 5 8; 5 9; 5 10; 5 11; 5 12; 5 13;
            6 1; 6 2; 6 3; 6 4; 6 5;
            1+6 14-13; 2+6 16-13; 2+6 17-13; 1+6 16-13; 1+6 15-13; 1+6 17-13; 2+6 14-13; 1+6 18-13; 1+6 19-13; 2+6 18-13; 1+6 20-13; 1+6 21-13; 2+6 19-13; 1+6 22-13; 2+6 20-13;
            3+6 14-13; 3+6 15-13; 3+6 16-13;
            4+6 14-13;
            5+6 14-13;
            6+6 14-13;
            ];
        
    case "neg desi 3d pdx & primary"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = {'*pdx_br*','*35_1*','*35_2*','*35_3*','*35_e*','*23_1*','*23_2*'};
        
        filesToProcess = []; for i = 1:length(data_folders); for ii = 1:length(dataset_name); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name{ii} '.imzML']) ]; end; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess(3:10,:);
            smaller_masks_list = [
                "t-1458-2";
                "t-1282-4";
                "t-1282-5";
                "t-1458-4";
                "t-1458-3";
                "t-1282-3";
                "t-1458-5";
                "t-1282-2";
                ];
            extensive_filesToProcess(8+(1:4),1) = filesToProcess(11,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-1-18";
                "pt-35-1-20";
                "pt-35-1-28";
                "pt-35-1-33";
                ];
            extensive_filesToProcess(8+4+(1:5),1) = filesToProcess(12,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-2-25";
                "pt-35-2-32";
                "pt-35-2-55";
                "pt-35-2-80";
                "pt-35-2-81";
                ];
            extensive_filesToProcess(8+4+5+(1:4),1) = filesToProcess(13,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-3-12";
                "pt-35-3-36";
                "pt-35-3-70";
                "pt-35-3-78";
                ];
            extensive_filesToProcess(8+4+5+4+(1:11),1) = filesToProcess(14,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-e-4";
                "pt-35-e-6";
                "pt-35-e-7";
                "pt-35-e-8";
                "pt-35-e-9";
                "pt-35-e-11";
                "pt-35-e-12";
                "pt-35-e-17";
                "pt-35-e-18";
                "pt-35-e-19";
                "pt-35-e-21";
                ];
            extensive_filesToProcess(8+4+5+4+11+(1:13),1) = filesToProcess(15,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-1-1";
                "pt-23-1-2";
                "pt-23-1-3";
                "pt-23-1-4";
                "pt-23-1-6";
                "pt-23-1-7";
                "pt-23-1-8";
                "pt-23-1-9";
                "pt-23-1-10";
                "pt-23-1-11";
                "pt-23-1-12";
                "pt-23-1-13";
                "pt-23-1-14";
                ];
            extensive_filesToProcess(8+4+5+4+11+13+(1:5),1) = filesToProcess(16,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-2-15";
                "pt-23-2-18";
                "pt-23-2-19";
                "pt-23-2-21";
                "pt-23-2-22";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 3; 2 4; 1 3; 1 2; 2 2; 1 4; 2 1;
            3 1; 3 2; 3 3; 3 4; 3 5; 3 6; 3 7; 3 8; 3 9; 3 10; 3 11; 3 12; 3 13;
            4 1; 4 2; 4 3; 4 4; 4 5; 4 6; 4 7; 4 8; 4 9; 4 10; 4 11;
            5 1; 5 2; 5 3; 5 4; 5 5; 5 6; 5 7; 5 8; 5 9; 5 10; 5 11; 5 12; 5 13;
            6 1; 6 2; 6 3; 6 4; 6 5;
            ];
        
    case "pos desi pdx & primary"
        
        data_folders = { 'X:\ICR Breast PDX\Data\pos DESI\' };
        
        dataset_name = {'*pdx*','*35_1*','*35_2*','*35_3*','*35_e*','*23_1*','*23_2*'};
        
        filesToProcess = []; for i = 1:length(data_folders); for ii = 1:length(dataset_name); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name{ii} '.imzML']) ]; end; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:8,:) = filesToProcess(1:8,:);
            smaller_masks_list = [
                "pdx-JOOO104720";
                "pdx-TMO1273";
                "pdx-TMO098";
                "pdx-TMO1117";
                "pdx-TMO0091";
                "pdx-TMO112";
                "pdx-JOOO100674";
                "pdx-TMO099";
                ];
            extensive_filesToProcess(8+(1:2)) = filesToProcess(9,:);
            smaller_masks_list = [
                smaller_masks_list;
                "t-1458-1";
                "t-1282-1";
                ];
            extensive_filesToProcess(10+(1:4),1) = filesToProcess(10,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-1-18";
                "pt-35-1-20";
                "pt-35-1-28";
                "pt-35-1-33";
                ];
            extensive_filesToProcess(14+(1:5),1) = filesToProcess(11,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-2-25";
                "pt-35-2-32";
                "pt-35-2-55";
                "pt-35-2-80";
                "pt-35-2-81";
                ];
            extensive_filesToProcess(19+(1:3),1) = filesToProcess(12,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-3-36";
                "pt-35-3-70";
                "pt-35-3-78";
                ];
            extensive_filesToProcess(22+(1:19),1) = filesToProcess(13,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-e-4";
                "pt-35-e-6";
                "pt-35-e-7";
                "pt-35-e-8";
                "pt-35-e-9";
                "pt-35-e-11";
                "pt-35-e-12";
                "pt-35-e-17";
                "pt-35-e-18";
                "pt-35-e-19";
                "pt-35-e-21";
                "pt-35-e-2";
                "pt-35-e-3";
                "pt-35-e-5";
                "pt-35-e-10";
                "pt-35-e-13";
                "pt-35-e-14";
                "pt-35-e-15";
                "pt-35-e-16";
                ];
            extensive_filesToProcess(41+(1:11),1) = filesToProcess(14,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-1-1";
                "pt-23-1-3";
                "pt-23-1-4";
                "pt-23-1-6";
                "pt-23-1-7";
                "pt-23-1-8";
                "pt-23-1-9";
                "pt-23-1-10";
                "pt-23-1-11";
                "pt-23-1-12";
                "pt-23-1-13";
                ];
            extensive_filesToProcess(52+(1:8),1) = filesToProcess(15,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-2-15";
                "pt-23-2-18";
                "pt-23-2-19";
                "pt-23-2-21";
                "pt-23-2-22";
                "pt-23-2-16";
                "pt-23-2-17";
                "pt-23-2-20";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 4; 2 3; 1 5; 2 4; 1 6; 2 2; 1 2; 1 3; 1 1; 2 1;
            3 1; 3 2; 3 3; 3 4; 3 5; 3 6; 3 7; 3 8; 3 9; 3 10; 3 11; 3 12;
            4 1; 4 2; 4 3; 4 4; 4 5; 4 6; 4 7; 4 8; 4 9; 4 10;
            5 1; 5 2; 5 3; 5 4; 5 5; 5 6; 5 7; 5 8; 5 9;
            6 1; 6 2; 6 3; 6 4; 6 5; 6 6; 6 7; 6 8; 6 9; 6 10; 6 11;
            7 1; 7 2; 7 3; 7 4; 7 5; 7 6; 7 7; 7 8;
            ];
        
    case "neg desi pdx & primary"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = {'*pdx*','*35_1*','*35_2*','*35_3*','*35_e*','*23_1*','*23_2*'};
        
        filesToProcess = []; for i = 1:length(data_folders); for ii = 1:length(dataset_name); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name{ii} '.imzML']) ]; end; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess(3:18,:);
            smaller_masks_list = [
                "t-1458-2";
                "t-1282-4";
                "t-1282-5";
                "t-1458-4";
                "t-1458-3";
                "t-1282-3";
                "t-1458-5";
                "t-1282-2";
                "pdx-JOOO100674";
                "pdx-TMO099";
                "pdx-TMO112";
                "pdx-JOOO104720";
                "pdx-TMO098";
                "pdx-TMO1273";
                "pdx-TMO0091";
                "pdx-TMO1117";
                ];
            extensive_filesToProcess(16+(1:4),1) = filesToProcess(19,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-1-18";
                "pt-35-1-20";
                "pt-35-1-28";
                "pt-35-1-33";
                ];
            extensive_filesToProcess(20+(1:5),1) = filesToProcess(20,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-2-25";
                "pt-35-2-32";
                "pt-35-2-55";
                "pt-35-2-80";
                "pt-35-2-81";
                ];
            extensive_filesToProcess(25+(1:4),1) = filesToProcess(21,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-3-12";
                "pt-35-3-36";
                "pt-35-3-70";
                "pt-35-3-78";
                ];
            extensive_filesToProcess(29+(1:11),1) = filesToProcess(22,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-e-4";
                "pt-35-e-6";
                "pt-35-e-7";
                "pt-35-e-8";
                "pt-35-e-9";
                "pt-35-e-11";
                "pt-35-e-12";
                "pt-35-e-17";
                "pt-35-e-18";
                "pt-35-e-19";
                "pt-35-e-21";
                ];
            extensive_filesToProcess(40+(1:13),1) = filesToProcess(23,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-1-1";
                "pt-23-1-2";
                "pt-23-1-3";
                "pt-23-1-4";
                "pt-23-1-6";
                "pt-23-1-7";
                "pt-23-1-8";
                "pt-23-1-9";
                "pt-23-1-10";
                "pt-23-1-11";
                "pt-23-1-12";
                "pt-23-1-13";
                "pt-23-1-14";
                ];
            extensive_filesToProcess(53+(1:5),1) = filesToProcess(24,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-2-15";
                "pt-23-2-18";
                "pt-23-2-19";
                "pt-23-2-21";
                "pt-23-2-22";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 2 2; 1 2; 1 3; 2 3; 1 4; 2 4; 1 5; 1 6; 2 5; 1 7; 1 8; 2 6; 1 9; 2 7;
            3 1; 3 2; 3 3; 3 4; 3 5; 3 6; 3 7; 3 8; 3 9; 3 10; 3 11; 3 12; 3 13;
            4 1; 4 2; 4 3; 4 4; 4 5; 4 6; 4 7; 4 8; 4 9; 4 10; 4 11;
            5 1; 5 2; 5 3; 5 4; 5 5; 5 6; 5 7; 5 8; 5 9; 5 10; 5 11; 5 12; 5 13;
            6 1; 6 2; 6 3; 6 4; 6 5;
            ];
        
    case "neg desi br pdx"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = { '*1282_2*', '*112*', '*1273*', '*1117*', '*1458_5*', '*674*', '*099*', '*104720*', '*098*', '*0091*'};
        
        filesToProcess = []; for i = 1:length(data_folders); for ii = 1:length(dataset_name); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name{ii} '.imzML']) ]; end; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess(1:end,:);
            smaller_masks_list = [
                "t-1282-2";
                "pdx-TMO112";
                "pdx-TMO1273";
                "pdx-TMO1117";
                "t-1458-5";
                "pdx-JOOO100674";
                "pdx-TMO099";
                "pdx-JOOO104720";
                "pdx-TMO098";
                "pdx-TMO0091";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 2 2; 2 3; 2 4;
            1 1; 1 2; 1 3; 1 4; 1 5; 1 6;
            ];
        
    case "pos desi all pdx"
        
        data_folders = { 'X:\ICR Breast PDX\Data\pos DESI\' };
        
        dataset_name = '*pdx*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess([end end 1:end-1],:);
            smaller_masks_list = [
                "t-1458-1";
                "t-1282-1";
                "pdx-JOOO104720";
                "pdx-TMO1273";
                "pdx-TMO098";
                "pdx-TMO1117";
                "pdx-TMO0091";
                "pdx-TMO112";
                "pdx-JOOO100674";
                "pdx-TMO099";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 3;
            1 1;
            1 4;
            1 2;
            2 4;
            2 2;
            3 4;
            3 2;
            4 4;
            5 4;
            ];
        
    case "neg desi all pdx"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = '*pdx*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess(3:end,:);
            smaller_masks_list = [
                "t-1458-2";
                "t-1282-4";
                "t-1282-5";
                "t-1458-4";
                "t-1458-3";
                "t-1282-3";
                "t-1458-5";
                "t-1282-2";
                "pdx-JOOO100674";
                "pdx-TMO099";
                "pdx-TMO112";
                "pdx-JOOO104720";
                "pdx-TMO098";
                "pdx-TMO1273";
                "pdx-TMO0091";
                "pdx-TMO1117";
                ];
            
        end
        
        
        
        %
        
        outputs_xy_pairs = [
            1 3;
            3 1;
            4 1;
            3 3;
            2 3;
            2 1;
            4 3;
            1 1;
            1 4;
            2 4;
            1 2;
            3 4;
            4 4;
            2 2;
            5 4;
            3 2;
            ];
        
    case "pos desi primary tumours"
        
        data_folders = { 'X:\ICR Breast PDX\Data\pos DESI\' };
        
        filesToProcess = [];
        for i = 1:length(data_folders)
            dataset_name = '*bc_35*';
            filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ];
            dataset_name = '*bc_23*';
            filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ];
        end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,1) = filesToProcess(4,1);
            smaller_masks_list = [
                "pt-35-1-18";
                "pt-35-1-20";
                "pt-35-1-28";
                "pt-35-1-33";
                ];
            extensive_filesToProcess(5:9,1) = filesToProcess(3,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-2-25";
                "pt-35-2-32";
                "pt-35-2-55";
                "pt-35-2-80";
                "pt-35-2-81";
                ];
            extensive_filesToProcess(10:12,1) = filesToProcess(2,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-3-36";
                "pt-35-3-70";
                "pt-35-3-78";
                ];
            extensive_filesToProcess(13:31,1) = filesToProcess(1,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-e-4";
                "pt-35-e-6";
                "pt-35-e-7";
                "pt-35-e-8";
                
                "pt-35-e-9";
                "pt-35-e-11";
                "pt-35-e-12";
                "pt-35-e-17";
                
                "pt-35-e-18";
                "pt-35-e-19";
                "pt-35-e-21";
                
                "pt-35-e-2";
                "pt-35-e-3";
                "pt-35-e-5";
                "pt-35-e-10";
                
                "pt-35-e-13";
                "pt-35-e-14";
                "pt-35-e-15";
                "pt-35-e-16";
                ];
            extensive_filesToProcess(32:42,1) = filesToProcess(5,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-1-1";
                "pt-23-1-3";
                "pt-23-1-4";
                
                "pt-23-1-6";
                "pt-23-1-7";
                "pt-23-1-8";
                "pt-23-1-9";
                
                "pt-23-1-10";
                "pt-23-1-11";
                "pt-23-1-12";
                "pt-23-1-13";
                ];
            extensive_filesToProcess(43:50,1) = filesToProcess(6,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-2-15";
                "pt-23-2-18";
                "pt-23-2-19";
                "pt-23-2-21";
                "pt-23-2-22";
                
                "pt-23-2-16";
                "pt-23-2-17";
                "pt-23-2-20";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1; %  35-1
            
            1 2; 2 2; 3 2; 4 2; 5 2; %  35-2
            
            2 3; 3 3; 4 3; %  35-3
            
            1 4; 2 4; 3 4; 4 4; % 35-e
            1 5; 2 5; 3 5; 4 5;
            1 6; 2 6; 3 6;
            1 7; 2 7; 3 7; 4 7;
            1 8; 2 8; 3 8; 4 8;
            
            1 9;    2 9;    3 9;    % 23-1
            1 10;   2 10;   3 10;   4 10;
            1 11;   2 11;   3 11;   4 11;
            
            1 12;   2 12;   3 12;   4 12;   5 12; % 23-2
            1 13;   2 13;   3 13;
            ];
        
    case "neg desi primary tumours"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        filesToProcess = [];
        for i = 1:length(data_folders)
            dataset_name = '*bc_35*';
            filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ];
            dataset_name = '*bc_23*';
            filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ];
        end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:4,1) = filesToProcess(1,1);
            smaller_masks_list = [
                "pt-35-1-18";
                "pt-35-1-20";
                "pt-35-1-28";
                "pt-35-1-33";
                ];
            
            extensive_filesToProcess(5:9,1) = filesToProcess(2,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-2-25";
                "pt-35-2-32";
                "pt-35-2-55";
                "pt-35-2-80";
                "pt-35-2-81";
                ];
            extensive_filesToProcess(10:13,1) = filesToProcess(3,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-3-12";
                "pt-35-3-36";
                "pt-35-3-70";
                "pt-35-3-78";
                ];
            extensive_filesToProcess(14:24,1) = filesToProcess(4,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-e-4";
                "pt-35-e-6";
                "pt-35-e-7";
                "pt-35-e-8";
                "pt-35-e-9";
                "pt-35-e-11";
                "pt-35-e-12";
                "pt-35-e-17";
                "pt-35-e-18";
                "pt-35-e-19";
                "pt-35-e-21";
                ];
            extensive_filesToProcess(25:37,1) = filesToProcess(5,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-1-1";
                "pt-23-1-2";
                "pt-23-1-3";
                "pt-23-1-4";
                "pt-23-1-6";
                "pt-23-1-7";
                "pt-23-1-8";
                "pt-23-1-9";
                "pt-23-1-10";
                "pt-23-1-11";
                "pt-23-1-12";
                "pt-23-1-13";
                "pt-23-1-14";
                ];
            extensive_filesToProcess(38:42,1) = filesToProcess(6,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-23-2-15";
                "pt-23-2-18";
                "pt-23-2-19";
                "pt-23-2-21";
                "pt-23-2-22";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 3 1; 4 1;
            1 2; 2 2; 3 2; 4 2; 5 2;
            1 3; 2 3; 3 3; 4 3;
            
            1 4; 2 4; 3 4; 4 4;
            1 5; 2 5; 3 5; 4 5;
            1 6; 2 6; 3 6;
            
            1 7; 2 7; 3 7; 4 7;
            1 8; 2 8; 3 8; 4 8;
            1 9; 2 9; 3 9; 4 9; 5 9;
            
            1 10; 2 10; 3 10; 4 10; 5 10;
            ];
        
    case "pos desi original 3d pdx pilot"
        
        data_folders = { 'X:\ICR Breast PDX\Data\pos DESI\' };
        
        dataset_name = '*pdx_br*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:2,:) = filesToProcess(1,:);
            smaller_masks_list = [
                "t-1458-1";
                "t-1282-1";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1;
            ];
        
    case "pos desi 3d pdx pilot"
        
        data_folders = { 'X:\ICR Breast PDX\Data\pos DESI\' };
        
        dataset_name = '*pdx_br*';
        
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
                "t-1458-1-half-1";
                "t-1282-1-half-1";
                "t-1458-1-half-2";
                "t-1282-1-half-2";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 1 2; 2 2;
            ];
        
    case "neg desi 3d pdx pilot"
        
        data_folders = { 'X:\ICR Breast PDX\Data\neg DESI\' };
        
        dataset_name = '*pdx_br*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess(3:end,:);
            smaller_masks_list = [
                "t-1458-2";
                "t-1282-4";
                "t-1282-5";
                "t-1458-4";
                "t-1458-3";
                "t-1282-3";
                "t-1458-5";
                "t-1282-2"
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 3; 2 4; 1 3; 1 2; 2 2; 1 4; 2 1
            ];
        
    case "icl neg desi 1458 and 1282 pdx & primary"
        
        data_folders = { 'X:\ICR Breast PDX\Data\ICL neg DESI\' };
        
        filesToProcess = [];
        for i = 1:length(data_folders)
            dataset_name = '*pdx*';
            filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ];
            dataset_name = '*bc_35*';
            filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ];
        end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1:10,1) = filesToProcess(1:10,1);
            smaller_masks_list = [
                "t-1282-1";
                "t-1458-1";
                "t-1458-2";
                "t-1282-4";
                "t-1282-5";
                "t-1458-4";
                "t-1458-3";
                "t-1282-3";
                "t-1458-5";
                "t-1282-2";
                ];
            
            extensive_filesToProcess(11:14,1) = filesToProcess(11,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-1-18";
                "pt-35-1-20";
                "pt-35-1-28";
                "pt-35-1-33";
                ];
            
            extensive_filesToProcess(15:19,1) = filesToProcess(12,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-2-25";
                "pt-35-2-32";
                "pt-35-2-55";
                "pt-35-2-80";
                "pt-35-2-81";
                ];
            extensive_filesToProcess(20:23,1) = filesToProcess(13,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-3-12";
                "pt-35-3-36";
                "pt-35-3-70";
                "pt-35-3-78";
                ];
            extensive_filesToProcess(24:34,1) = filesToProcess(14,1);
            smaller_masks_list = [
                smaller_masks_list;
                "pt-35-e-4";
                "pt-35-e-6";
                "pt-35-e-7";
                "pt-35-e-8";
                "pt-35-e-9";
                "pt-35-e-11";
                "pt-35-e-12";
                "pt-35-e-17";
                "pt-35-e-18";
                "pt-35-e-19";
                "pt-35-e-21";
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 2 2; 4 1; 5 1; 4 2; 3 2; 3 1; 5 2; 2 1;
            1 3; 2 3; 3 3; 4 3;
            1 4; 2 4; 3 4; 4 4; 5 4;
            1 5; 2 5; 3 5; 4 5;
            1 6; 2 6; 3 6; 4 6;
            1 7; 2 7; 3 7; 4 7;
            1 8; 2 8; 3 8;
            ];
        
    case "icl neg desi 1458 and 1282 pdx only (s245 only)"
        
        data_folders = { 'X:\ICR Breast PDX\Data\ICL neg DESI\' };
        
        dataset_name = '*pdx*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess([3:6 9:10],:);
            smaller_masks_list = [
                "t-1458-2";
                "t-1282-4";
                "t-1282-5";
                "t-1458-4";
                "t-1458-5";
                "t-1282-2"
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 1 2; 1 3; 2 2; 2 3; 1 1
            ];
        
        
    case "icl neg desi 1458 and 1282 pdx only (s2-5 only)"
        
        data_folders = { 'X:\ICR Breast PDX\Data\ICL neg DESI\' };
        
        dataset_name = '*pdx*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess(3:end,:);
            smaller_masks_list = [
                "t-1458-2";
                "t-1282-4";
                "t-1282-5";
                "t-1458-4";
                "t-1458-3";
                "t-1282-3";
                "t-1458-5";
                "t-1282-2"
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 1 3; 1 4; 2 3; 2 2; 1 2; 2 4; 1 1
            ];
        
    case "icl neg desi 1458 and 1282 pdx only"
        
        data_folders = { 'X:\ICR Breast PDX\Data\ICL neg DESI\' };
        
        dataset_name = '*pdx*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess = filesToProcess;
            smaller_masks_list = [
                "t-1282-1";
                "t-1458-1";
                "t-1458-2";
                "t-1282-4";
                "t-1282-5";
                "t-1458-4";
                "t-1458-3";
                "t-1282-3";
                "t-1458-5";
                "t-1282-2"
                ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 2 1; 2 2; 1 4; 1 5; 2 4; 2 3; 1 3; 2 5; 1 2
            ];
        
    case "maldi pos cell pellets only"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Neg\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(3,:);
            smaller_masks_list = [ "tissue only" ];
            extensive_filesToProcess(2,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(3,:) = filesToProcess(15,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(4,:) = filesToProcess(11,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(5,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(6,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(7,:) = filesToProcess(13,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(8,:) = filesToProcess(9,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 3; 1 4;
            2 1; 2 2; 2 3; 2 4;
            ];
        
    case "maldi pos BR1282 PDX"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Neg\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(2,:);
            smaller_masks_list = [ "tissue only" ];
            extensive_filesToProcess(2,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(3,:) = filesToProcess(10,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(4,:) = filesToProcess(14,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 4; 1 3;
            
            ];
        
    case "maldi pos BR1458 PDX"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Neg\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(4,:);
            smaller_masks_list = [ "tissue only" ];
            extensive_filesToProcess(2,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(3,:) = filesToProcess(12,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(4,:) = filesToProcess(16,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 4; 1 3;
            
            ];
        
    case "maldi pos BR1458 BR1282 PDX and Cell Pellets"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Neg\' };
        
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
            smaller_masks_list = [ "tissue only" ];
            extensive_filesToProcess(2,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(3,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(4,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(5,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(6,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(7,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(8,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(9,:) = filesToProcess(9,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(10,:) = filesToProcess(10,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(11,:) = filesToProcess(11,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(12,:) = filesToProcess(12,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(13,:) = filesToProcess(13,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(14,:) = filesToProcess(14,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(15,:) = filesToProcess(15,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(16,:) = filesToProcess(16,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 4 1; 1 1; 3 1;
            2 2; 4 2; 1 2; 3 2;
            2 4; 4 4; 1 4; 3 4;
            2 3; 4 3; 1 3; 3 3;
            ];
        
    case "maldi pos BR1458 BR1282 pdx only"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Pos\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue 2";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(4,:);
            smaller_masks_list = [ "BR1458 S1 PDX" ];
            
            extensive_filesToProcess(2,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "BR1458 S2 PDX" ];
            
            extensive_filesToProcess(3,:) = filesToProcess(10,:);
            smaller_masks_list = [ smaller_masks_list; "BR1458 S3 PDX" ];
            
            extensive_filesToProcess(4,:) = filesToProcess(13,:);
            smaller_masks_list = [ smaller_masks_list; "BR1458 S4 PDX" ];
            
            extensive_filesToProcess(5,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "BR1282 S1 PDX" ];
            
            extensive_filesToProcess(6,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "BR1282 S2 PDX" ];
            
            extensive_filesToProcess(7,:) = filesToProcess(9,:);
            smaller_masks_list = [ smaller_masks_list; "BR1282 S3 PDX" ];
            
            extensive_filesToProcess(8,:) = filesToProcess(11,:);
            smaller_masks_list = [ smaller_masks_list; "BR1282 S4 PDX" ];
            
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 3; 1 4;
            2 1; 2 2; 2 3; 2 4;
            ];
        
    case "maldi neg cell pellets only"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Neg\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(3,:);
            smaller_masks_list = [ "tissue only" ];
            extensive_filesToProcess(2,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(3,:) = filesToProcess(15,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(4,:) = filesToProcess(11,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(5,:) = filesToProcess(1,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(6,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(7,:) = filesToProcess(13,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(8,:) = filesToProcess(9,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 3; 1 4;
            2 1; 2 2; 2 3; 2 4;
            ];
        
    case "maldi neg 1282"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Neg\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(2,:);
            smaller_masks_list = [ "tissue only" ];
            extensive_filesToProcess(2,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(3,:) = filesToProcess(10,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(4,:) = filesToProcess(14,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 4; 1 3;
            
            ];
        
    case "maldi neg 1458"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Neg\' };
        
        dataset_name = '*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(4,:);
            smaller_masks_list = [ "tissue only" ];
            extensive_filesToProcess(2,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(3,:) = filesToProcess(12,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            extensive_filesToProcess(4,:) = filesToProcess(16,:);
            smaller_masks_list = [ smaller_masks_list; "tissue only" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            1 1; 1 2; 1 4; 1 3;
            
            ];
        
    case "maldi neg 1458 1282"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Neg\' };
        
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
            smaller_masks_list = [ "cell-pellet-1-1282" ];
            extensive_filesToProcess(2,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "pdx-1-1282" ];
            extensive_filesToProcess(3,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "cell-pellet-1-1458" ];
            extensive_filesToProcess(4,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "pdx-1-1458" ];
            extensive_filesToProcess(5,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "cell-pellet-2-1282" ];
            extensive_filesToProcess(6,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "pdx-2-1282" ];
            extensive_filesToProcess(7,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "cell-pellet-2-1458" ];
            extensive_filesToProcess(8,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "pdx-2-1458" ];
            extensive_filesToProcess(9,:) = filesToProcess(9,:);
            smaller_masks_list = [ smaller_masks_list; "cell-pellet-4-1282" ];
            extensive_filesToProcess(10,:) = filesToProcess(10,:);
            smaller_masks_list = [ smaller_masks_list; "pdx-4-1282" ];
            extensive_filesToProcess(11,:) = filesToProcess(11,:);
            smaller_masks_list = [ smaller_masks_list; "cell-pellet-4-1458" ];
            extensive_filesToProcess(12,:) = filesToProcess(12,:);
            smaller_masks_list = [ smaller_masks_list; "pdx-4-1458" ];
            extensive_filesToProcess(13,:) = filesToProcess(13,:);
            smaller_masks_list = [ smaller_masks_list; "cell-pellet-3-1282" ];
            extensive_filesToProcess(14,:) = filesToProcess(14,:);
            smaller_masks_list = [ smaller_masks_list; "pdx-3-1282" ];
            extensive_filesToProcess(15,:) = filesToProcess(15,:);
            smaller_masks_list = [ smaller_masks_list; "cell-pellet-3-1458" ];
            extensive_filesToProcess(16,:) = filesToProcess(16,:);
            smaller_masks_list = [ smaller_masks_list; "pdx-3-1458" ];
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 4 1; 1 1; 3 1;
            2 2; 4 2; 1 2; 3 2;
            2 4; 4 4; 1 4; 3 4;
            2 3; 4 3; 1 3; 3 3;
            ];
        
    case "maldi neg 1458 1282 pdx only"
        
        data_folders = { 'X:\ICR Breast PDX\Data\uMALDI\Neg\' };
        
        dataset_name = '*pdx*';
        
        filesToProcess = []; for i = 1:length(data_folders); filesToProcess = [ filesToProcess; dir([data_folders{i} dataset_name '.imzML']) ]; end
        
        if background == 1
            
            % with background
            
            main_mask_list = "no mask";
            
        else
            
            % tissue only
            
            main_mask_list = "tissue only";
            
            %
            
            extensive_filesToProcess(1,:) = filesToProcess(1,:);
            smaller_masks_list = [ "BR1282-1-pdx" ];
            extensive_filesToProcess(2,:) = filesToProcess(2,:);
            smaller_masks_list = [ smaller_masks_list; "BR1458-1-pdx" ];
            extensive_filesToProcess(3,:) = filesToProcess(3,:);
            smaller_masks_list = [ smaller_masks_list; "BR1282-2-pdx" ];
            extensive_filesToProcess(4,:) = filesToProcess(4,:);
            smaller_masks_list = [ smaller_masks_list; "BR1458-2-pdx" ];
            extensive_filesToProcess(7,:) = filesToProcess(5,:);
            smaller_masks_list = [ smaller_masks_list; "BR1282-3-pdx" ];
            extensive_filesToProcess(8,:) = filesToProcess(6,:);
            smaller_masks_list = [ smaller_masks_list; "BR1458-3-pdx" ];
            extensive_filesToProcess(5,:) = filesToProcess(7,:);
            smaller_masks_list = [ smaller_masks_list; "BR1282-4-pdx" ];
            extensive_filesToProcess(6,:) = filesToProcess(8,:);
            smaller_masks_list = [ smaller_masks_list; "BR1458-4-pdx" ];
            
            
        end
        
        %
        
        outputs_xy_pairs = [
            2 1; 1 1; 2 2; 1 2;
            2 4; 1 4; 2 3; 1 3;
            ];
        
end