clc;
clear; 
close all;
% data_dir = 'C:\Users\mink\Desktop\Conference\'; % data folder
 data_dir = 'C:\Users\mink\Desktop\data(bottles)\';
data = zeros(128,256,37); % assume known sizes

for i = 1:37
%     load(sprintf('%sCorrectedDataProj%g.mat',data_dir,i));
 load(sprintf('%s160920_Phantom_Proj_%g.mat',data_dir,i))
    A(isnan(A)) = 0;
    A(isinf(A)) = 0;
    data(:,:,i) = A;
end


[fan_data1, loc, angles] = fan2para(squeeze(data(10,:,:)),2059,...
    'FanCoverage','cycle',...
    'FanRotationIncrement',deg2rad(360/37),...
    'FanSensorGeometry','line',...
    'FanSensorSpacing', 1);
fbp=iradon(fan_data1,angles,length(loc));
output_size = max(size(squeeze(data(50,:,:))));
%  figure,
% subplot(1,2,1), imagesc(angles,loc,fan_data1), colorbar, title('Fan 2 Para sinogram')
%  subplot(1,2,2), imagesc(fbp), colorbar, title('FBP Reconstruction')
figure;imagesc(fbp), colorbar, title('FBP Reconstruction')
ph = ifanbeam(squeeze(data(50,:,:)),2059,... 
                           'FanSensorSpacing',1,...
                           'Filter','Hamming',...
                           'FanCoverage','cycle',...
                            'FanSensorGeometry','line',...,
                            'OutputSize',output_size,... 
                           'FanRotationIncrement',deg2rad(360/37)),...
                       'Interpolation','v5cubic'
figure;imagesc(ph)


