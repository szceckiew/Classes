clear all;
close all;

A=[1, 100, 3];
mean(A);
std(A);

b=1+0.001*rand(1,1000);

dod=0;
for j=1:3
    disp(dod+1);
    disp(dod+2);
    
    dod=dod+2;
end

if 2~=5
    disp("prawda");
end