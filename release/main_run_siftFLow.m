%%

addpath('C:\Users\rortizca\workspace\ibr-common\src\utilities\scripts\scripts_plane_estimation\readwrite');
addpath(fullfile(pwd,'mexDenseSIFT'));
addpath(fullfile(pwd,'mexDiscreteFlow'));

%%

DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\hugo1-24\IBR_data_VSFM-CMPMVS';
%DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\hugo2-25\IBR_data_VSFM-CMPMVS';
%DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\yellow_house\IBR_data_VSFM-CMPMVS';
%DATASET = 'D:\D_workspace\datasets\0_debuging\0_2labels\beausoleil-9\IBR_data_VSFM-CMPMVS';

IDs     = [0, 11];

%%

for id = IDs(1):IDs(2)-1
        
    img1        = imread( sprintf('%s/images/0_nonRec_img/%08d.jpg', DATASET, id ) );
    img2        = imread( sprintf('%s/images/0_nonRec_img/%08d.jpg', DATASET, id+1 ));
    
    [warpI2, ~]  = run_siftFlow(img1, img2);
    
    figure(1);
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

    subplot(2,2,1)
    imshow(img1);
    title( sprintf('img %u', id) ) 
    
    subplot(2,2,2)
    imshow(img2);
    title( sprintf('img %u', id+1) ) 
    
    subplot(2,2,3)
    imshow(warpI2);
    title( sprintf('img %u to %u', id+1, id) ) 
    
    subplot(2,2,4)
    imshow( imfuse(img1, imresize(warpI2,2)) );
    title( 'flow visualization' ) 
    
    pause;
    
end
