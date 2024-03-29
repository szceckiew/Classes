clear all;
close all;
%A=input("Podaj A: ");
%B=input("Podaj B: ");
%C=input("Podaj C: ");

A=1;
B=9999999;
C=1;

x1=(-B - sqrt((B^2) - 4*A*C)) / (2*A);
x2=(-B + sqrt((B^2) - 4*A*C)) / (2*A);
disp("Wersja źle uwarunkowana obliczeniowo")
disp("x1= " + x1);
disp("x2= " + x2);

if(abs(x1)>=abs(x2))
    x2=C/A/x1;
else
    x1=C/A/x2;
end
disp("Wersja poprawna")
disp("x1= " + x1);
disp("x2= " + x2);




