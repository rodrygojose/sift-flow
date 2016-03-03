function img_mask = get_mask_from_target(target_sp, spimg)

img_mask  = zeros(size(spimg), 'uint8');
for k=1:numel(target_sp)
    curr_sp = target_sp( k );
    pxl_ind = spimg == curr_sp;
    img_mask(pxl_ind) = 1;
end

end