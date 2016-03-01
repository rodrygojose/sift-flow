%%

addpath('C:\Users\rortizca\workspace\ibr-common\src\utilities\scripts\scripts_plane_estimation\readwrite');

%%
%DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\hugo1-24\big_spixels';
%DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\hugo1-24\IBR_data_VSFM-CMPMVS';

%DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\hugo2-25\big_spixels';
%DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\hugo2-25\IBR_data_VSFM-CMPMVS';

%DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\yellow_house\big_spixels';

%DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\beausoleil-9\big_spixels';
DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\beausoleil-9\IBR_data_VSFM-CMPMVS';

IDs         = [0, 8];

for id = IDs(1):IDs(end)
    create_maskedImgs4siftFlow( DATASET, id);
end