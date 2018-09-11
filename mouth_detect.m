MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',100);
I=imread('abcd.jpg');
BB=step(MouthDetect,I);

figure,
imshow(I); hold on
for i = 1:size(BB,1)
 rectangle('Position',BB(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
end
title('Mouth Detection');
hold off;