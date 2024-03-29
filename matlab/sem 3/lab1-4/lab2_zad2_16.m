clear all;
close all;
%a=input("Podaj a: ");
%b=input("Podaj b: ");
%c=input("Podaj c: ");
a=0.5;
b=1;
c=0.5;


cond_1=b/(sqrt((b^2)-4*a*c));


x1=-b-sqrt((b^2)-4*a*c);


wyr=(b/x1)*((-1/(2*a)-(b/(2*a*sqrt((b^2)-4*a*c))))/x1);

cond_2=norm(wyr);

disp("cond1: " + cond_1);
disp("cond2: " + cond_2);

a=0.5;
c=0.491;
b=1+0.001*rand(1,1000);
for j=1:3
    
    for i=1:1000
        x1=-b(1,i)-sqrt(((b(1,i))^2)-4*a*(c+0.01*j));
        Vec(i)=x1;
    end


    MEAN(j) = mean(Vec);
    STD(j)= std(Vec);
end

disp(MEAN);
disp(STD);