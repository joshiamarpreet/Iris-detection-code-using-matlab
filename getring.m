%Function to cut the iris ring from the localised eye image. Ci and Cp are
% 2 element vectors denoting the centres of the iris and the pupil respectively
% rl is the radius of the pupil (lower radius) rh is the iris radius (higher radius).
%INPUT:
%I:Image to be processed
%Ci(x,y) and Cp(x,y) :Centre coordinates of the iris and the pupil
%Coordinate system :
%origin of coordinates is at the top left corner
%positive x axis points vertically down
%and positive y axis horizontally and to the right
%n:number of sides
%r:radius of circumcircle
%
%OUTPUT:
%O:Image with circle

%function [y1,...,yN] = myfun(x1,...,xM) declares a function named myfun that accepts
%  inputs x1,...,xM and returns outputs y1,...,yN. This declaration statement must be the 
%  first executable line of the function. Valid function names begin with an alphabetic character, and can contain letters, numbers, or underscores.
function [O]=getring(I,Cp,Ci,rl,rh,n)
if nargin==5    %nargin(fun) returns the number of input arguments that appear in the fun function definition. 
    n=600;
end
theta=(pi/2)/n;
% angle subtended at the centre by the sides
%orient one of the radii to lie along the y axis
%positive angle ic ccw

rows=size(I,1); %length of the 1st dimension of image
cols=size(I,2); %length of the 2nd dimension of image

%Get the left 'wing'

angle=7*pi/4:theta:9*pi/4;   %to improve contrast and help in detection
                             %3*pi/4:theta:5*pi/4 for right 'wing' Measured in A.C. Direction

            %x = j:i:k creates a regularly-spaced vector x using i as the increment between elements. The vector
            %elements are roughly equal to [j,j+i,j+2*i,...,j+m*i] where m = fix((k-j)/i). However, if i is not an 
            %integer, then floating point arithmetic plays a role in determining whether colon includes the endpoint
            % k in the vector, since k might not be exactly equal to j+m*i. If you specify nonscalar arrays, then MATLAB 
            % interprets j:i:k as j(1):i(1):k(1).



%extract iris ring.
for r=0:rh
    x=Ci(2)-r*sin(angle);%the negative sign occurs because of the particular choice of coordinate system
    y=Ci(1)+r*cos(angle);
    if any(x>=rows) || any(y>=cols) || any(x<=1) || any(y<=1)%if circle is out of bounds return image
        ringi=I;
        return
    end
    for i=1:n
        ringi(round(x(i)),round(y(i)))=I(round(x(i)),round(y(i)));
    end
end

ringp=ringi;  %iris ring & pupil ring

%make the pupil ring black
% for r=0:rl
%     x=Cp(2)-r*sin(angle);%the negative sign occurs because of the particular choice of coordinate system
%     y=Cp(1)+r*cos(angle);
%     if any(x>=rows) || any(y>=cols) || any(x<=1) || any(y<=1)%if circle is out of bounds return image itself
%         ringp=ringi;
%         return
%     end
%     for i=1:n
%         ringp(round(x(i)),round(y(i)))=0;
%     end
% end

%AND both the rings and put it into O
for i=1:size(ringi,1)
    for j=1:size(ringi,2)
        if ringp(i,j) ==0
            if ringi(i,j) ~=0
                O(i,j)=0;
            else
            end
        else
            O(i,j)=ringp(i,j);
        end
    end
end


%Repeat the above for getting the left 'wing'
angle=3*pi/4:theta:5*pi/4;
%extract iris ring.
for r=0:rh
    x=Ci(2)-r*sin(angle);%the negative sign occurs because of the particular choice of coordinate system
    y=Ci(1)+r*cos(angle);
    if any(x>=rows)||any(y>=cols)||any(x<=1)||any(y<=1)%if circle is out of bounds return image
        ringi1=I;
        return
    end
    for i=1:n
        ringi1(round(x(i)),round(y(i)))=I(round(x(i)),round(y(i)));
    end
end

ringp1=ringi1;

%make the pupil ring black
% for r=0:rl
%     x=Cp(2)-r*sin(angle);%the negative sign occurs because of the particular choice of coordinate system
%     y=Cp(1)+r*cos(angle);
%     if any(x>=rows)||any(y>=cols)||any(x<=1)||any(y<=1)%if circle is out of bounds return image itself
%         ringp1=ringi1;
%         return
%     end
%     for i=1:n
%         ringp1(round(x(i)),round(y(i)))=0;
%     end
% end

%AND both the rings and put it into O
for i=1:size(ringi1,1)
    for j=1:size(ringi1,2)
        if ringp1(i,j) ==0
            if ringi1(i,j) ~=0
                O(i,j)=0;
            else
            end
        else
            O(i,j)=ringp1(i,j);
        end
    end
end

end
