clear;
close all;

load('lab08_fm.mat');

fc = 200e3;
fs = 2e6;

f = 0:2e6;

f1 = 150e3;
f2 = 280e3;

N = 128;

%%% z obiektu bandpass
d = fdesign.differentiator('N,Fp,Fst',50,f1,f2,fs);
Hd = design(d,'equiripple','SystemObject',true);
[b,~] = tf(Hd);
%x1 = filtfilt(b,1,x); % filtr z obiektu
fvtool(Hd);

%%% FIR diff, bp
bbp = fir1(4*N,[150e3/fs*2 280e3/fs*2],blackmanharris(4*N+1));
%fvtool(bp,1);
DF = dsp.Differentiator;
[bdf,~] = tf(DF);

[hbp,~] = freqz(bbp,1,f,fs);
[hdf,~] = freqz(bdf,1,f,fs);

% filtr trywialny
x1 = filtfilt([-1,1],1,x); 


% odzyskanie sygna³u

x2 = x1.^2;
b1 = fir1(N,80e3/fs*2,hamming(N+1)); % lowpass
x3 = abs(filtfilt(b1,1,x2));
x4 = sqrt(x3);
x5 = decimate(x4,125);
sound(x5,16e3);


