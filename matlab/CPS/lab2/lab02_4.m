clear all;
close all;
[x, fs] = audioread('mowa.wav');

figure(1);
plot(1:length(x),x);


% stwórz macierz
N=256;
macierz_analizy=zeros(N,N);
for k=0:(N-1)
    if k==0
        s=sqrt(1/N);
    else
        s=sqrt(2/N);
    end
    for n=0:(N-1)
        macierz_analizy(k+1,n+1)=s*cos(pi*(k/N)*(n+0.5));
    end
end



%1300-
%27800
%17250
%6500
%800
M=[100,800,1300,3000,6500,10000,17250,27800,30000,31000];
poz=1:256;


for i=1:10
    figure(i+1)
    subplot(2,1,1)
    plot(poz,x(poz+M(i)-1),'-b');
    subplot(2,1,2)
    y=(x(poz+M(i)-1)')*macierz_analizy;
    plot(poz,y,'-r')
end


% test=x(poz+799)';
% y=test*macierz_analizy;








