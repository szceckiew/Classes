clear all; close all;
syms x;
funcos = @(x) cos(x);
funsin = @(x) sin(x);
field_corrcos = integral(funcos, -pi/2, pi/2),
field_corrsin = integral(funsin, 0,pi),
nodes = [-sqrt(3/5), 0, sqrt(3/5)];
wages = [5/9, 8/9, 5/9]; 
%wagi i węzły mają być zgodne z tymi wyprowadzonymi dla kwadratury Gaussa-Legendra
a = -pi/2;
b = pi/2;
N = 3;
fieldcos = 0;
for k=1:N
    fieldcos = fieldcos + wages(k)*funcos( (a+b)/2 + ((b-a)/2)*nodes(k));
end

fieldsin = 0;
for k=1:N
    fieldsin = fieldsin + wages(k)*funcos( (a+b)/2 + ((b-a)/2)*nodes(k));
end

fieldcos = fieldcos * (b-a)/2,
errcos = abs(fieldcos - field_corrcos),

fieldsin = fieldsin * (b-a)/2,
errsin = abs(fieldsin - field_corrsin),