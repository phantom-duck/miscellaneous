I0_original = imread('cv18_lab1_parts1&2_material\edgetest_18.png');
I0 = im2double(I0_original);

figure(1);
imshow(I0);

var20db = 0.01;
var10db = 0.1;

I1 = imnoise(I0, 'gaussian', 0, var20db);
figure(2);
imshow(I1);

I2 = imnoise(I0, 'gaussian', 0, var10db);
figure(3);
imshow(I2);

