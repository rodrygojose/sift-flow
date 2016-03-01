function create_maskedImgs4siftFlow( DATASET, id )

min_mvs_points  = 10;         % no depth propagation on these spixels with more MVS points
%min_mvs_density = 1/100;      % no depth propagation on these spixels with higher density

%% Load data

spimg_name  = sprintf('%s/superpixels/%08d.sp', DATASET, id );
spimg       = 1 + read_spixels( spimg_name );       % spixel index start in 1
n           = max(max(spimg));

sdepth_name = sprintf('%s/depth/%08d.sdepth', DATASET, id );
sdepth      = read_sdepth( sdepth_name );
mvs_pxl     = zeros(n,3);                       % no. of pixels and mvs points in superpixel

img_name    = sprintf('%s/half_size/%08d.jpg', DATASET, id );
img         = imread( img_name);

%% Decide target superpixels and compute mean color vector

for k = 1:n
    curr_sp   = spimg == k;
    pxl_ind   = find( curr_sp );                          % pixel indices for this spixel
    mvs_ind   = find( curr_sp & sdepth>0);                 % available depth samples
    num_pxl   = numel(pxl_ind);
    num_mvs   = numel(mvs_ind);
    mvs_pxl(k,:) = [num_mvs, num_pxl, num_mvs/num_pxl];        
end
    
%target_sp   = find( (mvs_pxl(:,1)<min_mvs_points | mvs_pxl(:,3)<min_mvs_density)); % spixels to propagate into
target_sp   = find( mvs_pxl(:,1)<min_mvs_points); % spixels to propagate into

%% mask out reconstructed spixels

img_mask  = zeros(size(spimg), 'uint8');
for k=1:numel(target_sp)
    curr_sp = target_sp( k );
    pxl_ind = spimg == curr_sp;
    img_mask(pxl_ind) = 1;
end

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