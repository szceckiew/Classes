%1b

clear all;
close all;
N = 8;
x = randn( N, 1 );
X1 = fft(x); % oryginalne DFT
X2 = dit(x); % DFT ,,sklejane'' z dwóch połówek
error_przyklad=mean( abs(X1-X2) ) % błąd


%DFT z klejane z p połówek
% a=x(1:N/2,1);
% adit=dit(a);
% 
% b=x(N/2:N,1);
% bdit=dit(b);
% 
% X3=dit()


X3=FFT_DIT_R2(x);

error_prog=mean(abs(X1-X3));
