close all; clear all;
a=[1 2 3 4 5 6 7 8 9];
b=[3 4 5];

[lags,x]=xcorr(a,b);
stem(lags,x)