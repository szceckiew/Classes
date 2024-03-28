clear all; close all;
% Wczytanie sygnału z pliku
signal = load('adsl_x.mat');
signal=signal.x;

% Długość prefiksu i bloku
M = 32;
N = 512;
corrmax=0;
corrmaxidx=0;

for i = 1:length(signal)-M   
    %display(max(xcorr(signal,signal(i:i+31))))
    if max(xcorr(signal,signal(i:i+31))) > corrmax
        corrmax= max(xcorr(signal,signal(i:i+31)));
        corrmaxidx=i;
    end
end


