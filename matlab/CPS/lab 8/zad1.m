clear;
close all;

load('lab08_am.mat');

fs = 1000; % [Hz]
fc = 200; % [Hz]

N = length(s9);

bh = firpm(20,[0.05 0.95],[1 1],'h');   % Bandpass Hilbert
fvtool(bh,1)

%d = fdesign.hilbert('TW,Ap',10,0.1,fs);
%hd = design(d,'equiripple','SystemObject',true);
%[bh, ~] = tf(hd);
%fvtool(bh,1)

s1h = filtfilt(bh, 1, s9);

%s1h = hilbert(s1);

s1d = sqrt(s9.^2 + s1h.^2);

t = 0:1/fs:1-1/fs;
A1 = 1;
A2 = 1;
A3 = 1;
f1 = 50;
f2 = 200;
f3 = 400;
m = 1 + A1*cos(2*pi*t*f1) + A2*cos(2*pi*t*f2) + A3*cos(2*pi*t*f3);

figure;
plot(0:N-1, s9,'b');
hold on;
plot(0:N-1, s1d,'r-*');
%hold on;
%plot(0:N-1, m,'m');

S1d = fft(s1d);

figure;
plot((0:N-1)/N*fs,abs(S1d)/N*2);
xlim([0 500]);
grid;
