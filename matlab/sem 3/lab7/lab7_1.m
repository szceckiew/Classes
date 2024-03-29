clear all; close all;
syms x;
y = @(x) sin(x);
h = pi/8;
x0 = pi/8;
xs = [x0-h, x0, x0+h],
ys = [y(x0-h), y(x0), y(x0+h)],
a=1/3; b=4/3; c=1/3;
calka = h*(a*ys(1) + b*ys(2) + c*ys(3)),
calkadok=integral(y,0,pi/4);
errcalk=calkadok-calka;

a=-1; b=0; c=1;
pochodna=(1/(2*h))*(a*ys(1) + b*ys(2) + c*ys(3)),
a=1; b=-2; c=1;
drPochodna=(1/(h*h))*(a*ys(1) + b*ys(2) + c*ys(3)),


