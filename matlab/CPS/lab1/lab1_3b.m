clear all; close all;
% Wczytanie sygnału z pliku
signal = load('adsl_x.mat');
signal=signal.x;

% Długość prefiksu i bloku
M = 32;
N = 512;
corrmax=0;

for i = 1:length(signal)-M
    for j=i:length(signal)-M
        if i~=j
            if signal(j:j+31)==signal(i:i+31)
                display(i);
                display(j);
            end
        end
    end
end


