% close all;
% clear all;
% 
% load('butter.mat');

%% Dane %%
fp1 = 1189; % czestotliwosc graniczna dolna
fp2 = 1229; % czestotliwosc graniczna gorna
N = 16000;  % ilosc probek gdy 1s i 16khz
bw = fp2-fp1; % szerokosc pasma
fcenter = (fp2+fp1)/2;
fs= 16000; % czestotliwosc probkowania


A1 = 1;
A2 = 1;
f1 = 1209; % sygna³ cyfrowy z sumy dwóch harmonicznych
f2 = 1272; %

%f = 0:1:N;
f = linspace(0,N,N);
w = f*2*pi; %omega

%% charakterystyka zadanego filtru 
[ba, aa] = zp2tf(z, p, k); 
[Ha, Wa] = freqs(ba, aa, w); %odpowiedz impulsowa % ba -> z, aa -> p

%% transformata biliniowa konwersja s->z
[bx,ax] = bilinear(ba,aa,fs);
[Hx,Wx] = freqz(bx,ax,f,fs);
save('f_cyfrowy.mat','Hx');

%% zamiana na log
Ha_abs = abs(Ha);
Hx_abs = abs(Hx);
Ha_dB = 20*log10(Ha_abs);
Hx_dB = 20*log10(Hx_abs);

%% wykresy
x3dB = [1000 1500];
y3dB = [-3 -3];

figure(1);
hold all;
plot(f,Ha_dB,'r-');
plot(f,Hx_dB,'m*-');
plot(x3dB,y3dB,'k');
title('Transmitancja filtrów:');
xlabel('Czêstotliwoœæ [Hz]');
ylabel('T³umienie [dB]');
legend('analogowy','cyfrowy');
xlim([1160 1270]);
ylim([-6 0]);

%% sygnal cyfrowy
t = 1/fs:1/fs:1;
%t = 0:1/fs:1;
xsig = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);

Xsig = fft(xsig)/(N/2); % przejscie na dziedzine czestotliwosc
Xsig_abs = abs(Xsig);
Xsig_dB = 20*log10(Xsig_abs);

%% filtracja z uzyciem filter()

yy = filter(bc,ac,xsig);
YY = 20*log10(abs(fft(yy)/(N/2)));