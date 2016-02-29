I_1     = lab2rgb(gphs{1}.img);
I_2     = lab2rgb(gphs{2}.img);

mask_1  = gphs{1}.mask;
mask_2  = gphs{2}.mask;

Inew_1  = I_1.*repmat(mask_1, [1,1,3]);
Inew_2  = I_2.*repmat(mask_2, [1,1,3]);

imwrite(Inew_1, 'im1.jpg')
imwrite(Inew_2, 'im2.jpg')

