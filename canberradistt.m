function sum = canberradistt(image1,image2)
siz1 = size(image1);
siz2 = size(image2);

if(siz1(1) == siz2(1))
% uh1 and uh2
uh1 = 0;
uh2 = 0;
for i=1:siz1(1)
    uh1 = uh1 + image1(i,1)/siz1(1);
    uh2 = uh2 + image2(i,2)/siz2(1);
    
end
sum = 0;
for i=1:siz1(1)
    A = abs(image1(i,1) - image2(i,2));
    B = abs(image1(i,1) + uh1) + abs(image2(i,2) + uh2);
    
    sum = sum + A/(eps+B);
end

end
 disp('Canberra ditance:');
 disp(sum);
end


