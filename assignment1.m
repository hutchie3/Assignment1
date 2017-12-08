clear all;
close all;
clc;

%% Input Sequence

pos1 = imread('ant/img008.jpg');
pos2 = imread('ant/img009.jpg');

%% Object Motion and MM

diff1 = abs(pos1 - pos2);
imshow(diff1)

Ihsv = rgb2hsv(diff1);

Isub = Ihsv(:,:,3);

imhist(Isub)
Ithresh = Isub > 0.04;
imshow(Ithresh)

SE = strel('disk',2,0);
Iopen = imopen(Ithresh,SE);
imshow(Iopen)

SE = strel('disk',1,0);
Iclose = imclose(Iopen, SE);

imshow(Iclose)

%% Obtaining Object Stats

[labels, number] = bwlabel(Iclose, 8);
Istats = regionprops(labels, 'basic', 'Centroid');

[values, index] = sort([Istats.Area],'descend');
[maxVal, maxIndex] = max([Istats.Area]);

hold on;

rectangle('Position', [Istats(maxIndex).BoundingBox], 'LineWidth', 2, 'EdgeColor','g');

hold on;

plot(Istats(maxIndex).Centroid(1), Istats(maxIndex).Centroid(2), 'r*');
text(Istats(maxIndex).Centroid(1) + 10, Istats(maxIndex).Centroid(2) + 10, 'Object', 'fontsize', 8, 'color', 'r', 'fontweight','bold');


