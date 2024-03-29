% matrix_transform.m
clear all; close all;
% Dane wejsciowe
[x,fpr]=audioread('beep.wav',[1,2^14]);
N = length(x);
figure; plot(x); title('x(n)');
% Transformacja liniowa/ortogonalna - ANALIZA
n=0:N-1; k=0:N-1;
A = sqrt(2/N)*cos( pi/N *(k'*n));
%x = A(500,:) + A(1000,:); x = x';
y = A*x;
figure; plot(y); title('y(k)');
% Modyfikacja wyniku
w1=-0.6;
w2=0.8;
for i=1:N
    if y(i,1)<w2 && y(i,1)>w1
        
    else
        y(i,1) = 0;
    end
end
y(1000)=0;
figure; plot(y); title('y(k)');
% Transformacja odwrotna - SYNTEZA
xback = A'*y;

figure; plot(xback); title('xback(n)');
soundsc(x,fpr); pause
soundsc(xback,fpr);