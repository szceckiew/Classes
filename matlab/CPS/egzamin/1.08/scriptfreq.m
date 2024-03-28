close all; clear all;

%frequency domain
nfft= 1024; %number of samples

%Splash
[y1, Fs1] = audioread("splash1a.wav");

f1 = linspace(0,Fs1,nfft); 
Y1 = abs(fft(y1,nfft));

figure(1)
plot(f1(1:nfft/2), Y1(1:nfft/2));
title("Splash1a.wav")
xlabel('frequency')
ylabel('abs')
pause

%Boat Air Horn
[y2, Fs2] = audioread("boatairhorn.wav");
f2 = linspace(0,Fs2,nfft); 
Y2 = abs(fft(y2,nfft));

figure(2)
plot(f2(1:nfft/2), Y2(1:nfft/2));
title("boatairhorn.wav")
xlabel('frequency')
ylabel('abs')
pause

%Cicadas
[y3, Fs3] = audioread("minicic1.wav");
f3 = linspace(0,Fs3,nfft); 
Y3 = abs(fft(y3,nfft));

figure(3)
plot(f3(1:nfft/2), Y3(1:nfft/2));
title("minicic1.wav")
xlabel('frequency')
ylabel('abs')
pause

%Tractor
[y4, Fs4] = audioread("tractor.wav");
f4 = linspace(0,Fs4,nfft); 
Y4 = abs(fft(y4,nfft));

figure(4)
plot(f4(1:nfft/2), Y4(1:nfft/2));
title("tractor.wav")
xlabel('frequency')
ylabel('abs')