function [dist] = euclidist(image1,image2)
% function to calculate eucledian distance
h = imhist(image1); % this will have default bins 256
% now second image
h1 = imhist(image2); % this will have default bins 256 
dist = sqrt(sum((h-h1).^2));
disp(dist)

