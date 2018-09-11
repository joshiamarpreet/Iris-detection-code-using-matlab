function [sum] = chisqdist(image1,image2)

siz1 = size(image1);
siz2 = size(image2);
if(siz1(1) == siz2(1))
    sum = 0;
for i=1:siz1(1)
    A = (abs(image1(i,1) - image2(i,1)))^2;
    B = (image1(i,1)+image2(i,1))/2;
    sum = sum + (A/(B+eps));
    
end
%disp(sum);
else
    disp('resize the images');
end




