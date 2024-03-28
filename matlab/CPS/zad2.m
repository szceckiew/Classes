clear;

nr_indeksu = 291689;
x = 8;

[s8, fs] = audioread('s/s1.wav');

figure(1);
spectrogram(s8, 4096, 4096-512, [0:5:2000], fs);

%s8_filtered = bpf_1(s8, 4, 1189, 1229);
%figure(2);
%spectrogram(s8_filtered, 4096, 4096-512, [0:5:2000], fs);

%%%

[s8_filtered, b, a] = butresp(s8, 1, 60, 1189, 1229,fs);
figure(2);
spectrogram(s8_filtered, 4096, 4096-512, [0:5:2000], fs);
grid;
title('Sygna³ s8.wav filtrowany');

%%%

% GOERTZEL ALGORITHM - Implementacja i sprawdzenie

N = 2*4096 ; % Wielkoœæ okna
Fs = fs;
f_l = [697 770 852 941 1209 1336 1477]; % Czêstotliwoœci szukane
freq_indices = round(f_l/Fs*N) + 1;
no_inters = 10;

figure;
for iter = 1:no_inters
    data = s8(4000+N*(iter-1)+1:N*iter+4000);
    dft_data = goertzelTZ(data, freq_indices);
    %figure;
    stem(f_l, abs(dft_data));
    ax = gca;
    ax.XTick = f_l;
    xlabel('Frequency (Hz)');
    nr = int2str(iter);
    tit = strcat("DFT Magnitude ", nr);
    tit = strcat(tit, " Frame");
    title(tit);
    pause;
end
