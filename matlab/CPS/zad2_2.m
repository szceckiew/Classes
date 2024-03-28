close all;
clear all;

nr_indeksu=413399;
x=0;

[s0, fs]= audioread("s/s9.wav");

figure(1);
spectrogram(s0,4096,4096-512, [0:5:2000],fs);

% s0 PIN: 12439
% s9 PIN: 91520

%%filtracja
load('butter.mat');
[ba,aa]=zp2tf(z,p,k);
s0_filt = filter(ba,1,s0);

figure(2)
spectrogram(s0_filt, 4096, 4096-512, [0:5:2000], fs);