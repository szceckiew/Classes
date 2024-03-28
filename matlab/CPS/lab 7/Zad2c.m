
clear all; close all;

fs = 3.2e6;         % sampling frequency
N  = 32e6;         % number of samples (IQ)
fc = 0.39e6;        % central frequency of MF station

bwSERV = 80e3;     % bandwidth of an FM service (bandwidth ~= sampling frequency!)
bwAUDIO = 16e3;     % bandwidth of an FM audio (bandwidth == 1/2 * sampling frequency!)

f = fopen('samples_100MHz_fs3200kHz.raw');
s = fread(f, 2*N, 'uint8');
fclose(f);

s = s-127;

% IQ --> complex
wideband_signal = s(1:2:end) + sqrt(-1)*s(2:2:end); clear s;
%figure(1);
%psd(spectrum.welch('Hamming',1024), wideband_signal(1:N),'Fs',fs);

% Extract carrier of selected service, then shift in frequency the selected service to the baseband
%figure(2);
wideband_signal_shifted = wideband_signal .* exp(-sqrt(-1)*2*pi*fc/fs*[0:N-1]');
%psd(spectrum.welch('Hamming',1024), wideband_signal_shifted(1:N),'Fs',fs);

% % Filter out the service from the wide-band signal
[b,a] = butter(4, bwSERV/fs);

wideband_signal_filtered = filter( b, a, wideband_signal_shifted );
%figure(3);
%psd(spectrum.welch('Hamming',1024), wideband_signal_filtered(1:N),'Fs',fs);

% Down-sample to service bandwidth - bwSERV = new sampling rate
x = wideband_signal_filtered( 1:fs/(bwSERV*2):end );
%figure(4);
%psd(spectrum.welch('Hamming',1024), x,'Fs',(bwSERV*2)); % fs/(fs/(bwSERV*2))

% FM demodulation
dx = x(2:end).*conj(x(1:end-1));
y = atan2( imag(dx), real(dx) );
figure(5);
psd(spectrum.welch('Hamming',1024), y,'Fs',(bwSERV*2));

% Decimate to audio signal bandwidth bwAUDIO
%[b_down,a_down] = butter(4, bwAUDIO/(bwSERV*2));
Wn_down = (15e3*2)/(bwSERV*2);
b_down = fir1(128, Wn_down, blackmanharris(128+1));
a_down = 1;
figure(6);
freqz(b_down, a_down, 512, (bwSERV*2));
y_audio = filter( b_down, a_down, y ); % antyaliasing filter
figure(7);
psd(spectrum.welch('Hamming',1024), y_audio,'Fs',bwAUDIO);
% ym = y(bwSERV/bwAUDIO);  % decimate (1/5)
ym = y_audio(1:5:end);

% PILOT
Wn_pilot = [(18.95e3*2)/(bwSERV*2) (19.05e3*2)/(bwSERV*2)];
b_pilot = fir1(128, Wn_pilot, blackmanharris(128+1));
a_pilot = 1;
figure(8);
freqz(b_pilot, a_pilot, 512, bwSERV*2);
y_pilot = filter( b_pilot, a_pilot, y );
figure(9)
spectrogram(y_pilot, 4096, 4096-512, [18e3:1:20e3], bwSERV*2);
figure(10);
%psd(spectrum.welch('Hamming',1024), y_pilot,'Fs',bwSERV);
pwelch(y_pilot, 4096, 4096-512, [18e3:1:20e3], bwSERV*2);
% Listen to the final result
ym = ym-mean(ym);
ym = ym/(1.001*max(abs(ym)));
figure(11);
plot(ym)
soundsc( ym, bwAUDIO*2);