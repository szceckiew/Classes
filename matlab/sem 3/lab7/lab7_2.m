clear all; close all;
syms x;
ysin = @(x) sin(x);
y = @(x) 3*x.^3+2*x.^2 + x + 1/2;
h = pi/4;
x0 = pi/4;
xs = [x0-h, x0, x0+h],
xfunc = [1,2,3];

ys = [y(x0-h), y(x0), y(x0+h)],
yssin = [ysin(xfunc(1)), ysin(xfunc(2)), ysin(xfunc(3))],
ys_diff_from_func = [eval( (subs(diff(y,x,1),x,x0-h)) ), eval((subs(diff(y,x,1),x,x0)) ), eval( (subs(diff(y,x,1),x,x0+h)) )], 
ys_diff_from_sin = [eval( (subs(diff(ysin,x,1),x,x0-h)) ), eval((subs(diff(ysin,x,1),x,x0)) ), eval( (subs(diff(ysin,x,1),x,x0+h)) )], 


%to dokładne wartości pochodnych
fp_1 = 1/(2*h) * (-3*ys(1) + 4*ys(2) - ys(3)),
fp_2 = 1/(2*h) * (ys(3) - ys(1)),
fp_3 = 1/(2*h) * (ys(1) - 4*ys(2) +3*ys(3)),

fp_1sin = 1/(2*h) * (-3*yssin(1) + 4*yssin(2) - yssin(3)),
fp_2sin = 1/(2*h) * (yssin(3) - yssin(1)),
fp_3sin = 1/(2*h) * (yssin(1) - 4*yssin(2) +3*yssin(3)),
%to wartości z wzorów 7.16-7.18
errors = [abs(fp_1 - ys_diff_from_func(1)), abs(fp_2 - ys_diff_from_func(2)),abs(fp_3 - ys_diff_from_func(3))],
errorssin = [abs(fp_1sin - ys_diff_from_sin(1)), abs(fp_2sin - ys_diff_from_sin(2)),abs(fp_3sin - ys_diff_from_sin(3))],