% Wczytanie sygnałów
real_signal = readtable('DAB_real_2.048MHz_IQ_float.dat');
synt_signal = readtable('DAB_synt_2.048MHz_IQ_float.dat');

% Parametry
fs = 2048000; % częstotliwość próbkowania
Tnull = 2656/fs; % czas trwania bloku NullSymbol w sekundach
Tblock = 76*2552/fs; % czas trwania bloku danych w sekundach
M = round(Tnull/Tblock*76); % liczba bloków NullSymbol przed sygnałem PhaseReference Symbol
L = round(Tblock*76*fs); % długość jednego bloku danych
N = length(synt_signal); % długość sygnału


% Generowanie sygnału PhaseReference Symbol
sigPhaseRefSymb = PhaseRefSymbGen(1);

% Korelacja wzajemna sygnałów
corr_signal = xcorr(real_signal, sigPhaseRefSymb);
[~, index] = max(abs(corr_signal)); % indeks początku PhaseReference Symbol

% Obliczenie początku sygnału
%start_signal =
