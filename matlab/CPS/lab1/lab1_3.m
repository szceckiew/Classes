clear all; close all;
% Wczytanie sygnału z pliku
signal = load('adsl_x.mat');
signal=signal.x;

% Długość prefiksu i bloku
M = 32;
N = 512;

% Autokorelacja sygnału
corr_signal = xcorr(signal, M);

% Indeksy początków prefiksów
prefix_starts = find(corr_signal == max(corr_signal)) + M;

% Wyświetlenie wyniku
disp('Początki pierwszych próbek prefiksów:');
disp(prefix_starts);


