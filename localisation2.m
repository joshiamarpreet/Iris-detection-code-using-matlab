
%getting a closer look up localising the eye

% INPUTS:
% I:image to be segmented
% rmin ,rmax:the minimum and maximum values of the iris radius
% OUTPUTS:
% cp:the parametrs[xc,yc,r] of the pupilary boundary
% ci:the parametrs[xc,yc,r] of the limbic boundary
% out:the segmented image
function [out xc yc time]=localisation2(img,scale);
%for localising the iris based on black hole search.
tic;  %tic, by itself, saves the current time that TOC uses later to measure the time elapsed between the two.
x=0;
y=0;
scalewin=10*scale
xmin=255*scalewin;
%b=rgb2gray(img);
b=imresize(img,scale);   
% B = imresize(img, SCALE) returns an image that is SCALE times the
%     size of img, which is a grayscale, RGB, or binary image.
b=double(b);
%arithmetic operations are not defined on uint8(unsigned integer)
%hence the image is converted to double

p=size(b,1);        %p's max value is 240
q=size(b,2);        %q's max value is 320
for i=2:p-1
    for j=1:q-scalewin
        ssum=sum(b(i,j:j+scalewin));
        if(xmin>ssum)
            xmin=ssum;
            x=i;
        end
    end
end
ymin=255*scalewin;

ssum=0;
for i=2:q-1
    for j=2:p-scalewin
        ssum=sum(b(j:j+scalewin,i));
        if(ssum<ymin)
            ymin=ssum;
            y=i;
        end
    end
end
%m=1;n=1;

%error checking start
x=round((x * (1/scale)));
y=round((y * (1/scale)));
disp x;
disp y;
xc=x ;
yc=y ;

%b=rgb2gray(img);
b=(img);
p=size(b,1);        %p's max value is 240
q=size(b,2);        %q's max value is 320

if(x+75>p)
    ux=p;
else
    ux=x+75;%if 75 is made less or more(indices will increase matrix dimension i.e out of fig bound) then the pic zoomes.
end

if(y+75>q)
    uy=q;
else
    uy=y+75;
end

if(x-75<0)
    lx=1;
else
    lx=abs(x-75);
end
if(y-75<0)
    ly=1;
else
    ly=abs(y-75);
end
%error check end

if uy<ly
    temp=uy;
    uy=ly;
    ly=temp;
end

if ux<lx
    temp=ux;
    ux=lx;
    lx=temp;
end


c=b(lx:ux,ly:uy);
out=c;
disp('LOCAL');
time=toc;

end