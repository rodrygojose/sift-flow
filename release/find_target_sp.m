function [target_sp, img_mask] = find_target_sp(spimg, sdepth, GET_MASK )

min_mvs_points  = 10;         % no depth propagation on these spixels with more MVS points
%min_mvs_density = 1/100;      % no depth propagation on these spixels with higher density

%%
n           = max(max(spimg));
mvs_pxl     = zeros(n,3);                       % no. of pixels and mvs points in superpixel

for k = 1:n
    sp_mask   = spimg == k;    
    num_mvs   = nnz( sdepth( sp_mask )  );    
    num_pxl   = nnz( sp_mask );                          % pixel indices for this spixel    
    mvs_pxl(k,:) = [num_mvs, num_pxl, num_mvs/num_pxl];
end

%target_sp   = find( (mvs_pxl(:,1)<min_mvs_points | mvs_pxl(:,3)<min_mvs_density)); % spixels to propagate into
target_sp   = find( mvs_pxl(:,1)<min_mvs_points); % spixels to propagate into

if GET_MASK
    img_mask = get_mask_from_target(target_sp, spimg);
end

end