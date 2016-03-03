function create_maskedImgs4siftFlow( DATASET, id )

%% Load data

spimg_name  = sprintf('%s/superpixels/%08d.sp', DATASET, id );
spimg       = 1 + read_spixels( spimg_name );       % spixel index start in 1

sdepth_name = sprintf('%s/depth/%08d.sdepth', DATASET, id );
sdepth      = read_sdepth( sdepth_name );

img_name    = sprintf('%s/half_size/%08d.jpg', DATASET, id );
img         = imread( img_name);

%% Decide target superpixels 

[~, img_mask] = find_target_sp(spimg, sdepth, 1 );

%% mask out reconstructed spixels

img_new = img.*repmat(img_mask, [1,1,3]);

%%
disk_size = 10;
se = strel('disk', disk_size );        
mask_dil = imdilate(img_mask,se);
img_new_dil = img.*repmat(mask_dil, [1,1,3]);

Iblur = imgaussfilt(img_new_dil, disk_size/2);

img_extra = Iblur.*repmat(uint8(~img_mask), [1,1,3]);

img_final = img_new + img_extra;

%% save new image

folder2save = sprintf('%s/images/0_nonRec_img', DATASET);
if ~exist(folder2save, 'dir')
    mkdir(folder2save)
end

img_name_new = sprintf( '%s/%08d.jpg', folder2save, id );

imwrite(img_final, img_name_new);

end