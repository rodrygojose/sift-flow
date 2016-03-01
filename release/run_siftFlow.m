function [warpI2, flow_color] = run_siftFlow( im1, im2 )

%% data parameters

im1=imresize(imfilter(im1,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');
im2=imresize(imfilter(im2,fspecial('gaussian',7,1.),'same','replicate'),0.5,'bicubic');

im1=im2double(im1);
im2=im2double(im2);

cellsize=3;
gridspacing=1;

sift1 = mexDenseSIFT(im1,cellsize,gridspacing);
sift2 = mexDenseSIFT(im2,cellsize,gridspacing);

SIFTflowpara.alpha=2*255;
SIFTflowpara.d=40*255;
SIFTflowpara.gamma=0.005*255;
SIFTflowpara.nlevels=4;
SIFTflowpara.wsize=2;
SIFTflowpara.topwsize=10;
SIFTflowpara.nTopIterations = 60;
SIFTflowpara.nIterations= 30;

%% sift flow

tic;
%[vx,vy,energylist] = SIFTflowc2f(sift1,sift2,SIFTflowpara);
[vx,vy,~] = SIFTflowc2f(sift1,sift2,SIFTflowpara);
toc

%% warp

warpI2 = warpImage(im2,vx,vy);

%% display flow
clear flow;
flow(:,:,1)=vx;
flow(:,:,2)=vy;
%figure;
%imshow(flowToColor(flow));
flow_color = flowToColor(flow);

%%

% this is the code doing the brute force matching
% tic;[flow2,energylist2]=mexDiscreteFlow(Sift1,Sift2,[alpha,alpha*20,60,30]);toc
% figure;imshow(flowToColor(flow2));

end