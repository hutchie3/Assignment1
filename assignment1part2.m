close all;
clear all;
clc;

StartingFrame = 2;
EndingFrame = 442;

Xcentroid = [];
Ycentroid = [];

pos1 = imread('ant/img001.jpg');

for k = StartingFrame:(EndingFrame - 1)
    
    pos2 = imread(['ant/img', sprintf('%2.3d',k),'.jpg']);
    %     imshow(rgb);
    %     pause;
    rgb = abs(pos1 - pos2);
    
    Ihsv = rgb2hsv(rgb);
    
    Isub = Ihsv(:,:,3);
    
    %     imhist(Isub);
    Ithresh = Isub > 0.04;
    
    SE = strel('disk',2,0);
    Iopen = imopen(Ithresh,SE);
    
    SE = strel('disk',1,0);
    Iclose = imclose(Iopen, SE);
    
    [labels, number] = bwlabel(Iclose, 8);
    
    
    if number > 0
        
        Istats = regionprops(labels, 'basic', 'Centroid');
        
        [values, index] = sort([Istats.Area],'descend');
        [maxVal, maxIndex] = max([Istats.Area]);
        
        hold on;
        
        Xcentroid(k - 1) = Istats(maxIndex).Centroid(1);
        Ycentroid(k - 1) = Istats(maxIndex).Centroid(2);
        
        %         Xcentroid = [Xcentroid Istats(maxIndex).Centroid(1)];
        %         Ycentroid = [Ycentroid Istats(maxIndex).Centroid(2)];
        
    end
    
    pos1 = pos2;
end

imshow('img448.jpg')
hold on;
scatter( Xcentroid, Ycentroid, 'ro');
hold on;
plot( Xcentroid(435), Ycentroid(435), 'co');
