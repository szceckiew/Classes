clear;
close all;

f1 = 1001.2;
fs1 = 8e3;

f2 = 303.1;
fs2 = 32e3;

f3 = 2110.4;
fs3 = 48e3;

t1 = 0:1/fs1:1-1/fs1;
t2 = 0:1/fs2:1-1/fs2;
t3 = 0:1/fs3:1-1/fs3;

x1 = sin(2*pi*f1*t1);
x2 = sin(2*pi*f2*t2);
x3 = sin(2*pi*f3*t3);

%%% x4 analitycznie

x4 = sin(2*pi*f1*t3) + sin(2*pi*f2*t3) + sin(2*pi*f3*t3);

if(1)
    figure;
    plot(t1,x1,'r');
    hold on;
    plot(t2,x2,'m');
    hold on;
    plot(t3,x3,'g');
    xlabel('czas [s]');
    ylabel('amplituda');
    legend('1001.2 [Hz]','303.1 [Hz]','2110.4 [Hz]');
    xlim([0 1/f3]);
end

%%% nadpróbkowanie sygnału i decymacja

% NWW 8 [kHz] i 32 [kHz] to 96 [kHz]
% potem decymacja co drugiej próbki

x1_1 = upsample(x1, 6);
x2_1 = decimate(upsample(x2, 3), 2);

x4_1 = x1_1 + x2_1 + x3;


if(0)
    sound(x4, fs3);
    pause(2);
    sound(x4_1, fs3);
end


if(1)
    figure;
    subplot(2,1,1);
    spectrogram(x4, 4096, 4096-512, [0:3000], fs3);
    title('idealny');
    subplot(2,1,2);
    spectrogram(x4_1, 4096, 4096-512, [0:3000], fs3);
    title('zwielokrotniony i decymowany');
end

[kek1, kek1_fs] = audioread('x1.wav');
[kek2, kek2_fs] = audioread('x2.wav');

kek1 = kek1(:,1)';
kek2 = kek2';

kek1_1 = decimate(upsample(kek1, 3), 2);
vector1 = linspace(1, length(kek1), 1.5*length(kek1));
kek1_2 = interp1(kek1, vector1);

kek2_1 = upsample(kek2, 6);
vector2 = linspace(1, length(kek2), 6*length(kek2));
kek2_2 = interp1(kek2, vector2);

miks = kek1_2;

miks(1:length(kek2_2)) = miks(1:length(kek2_2)) + kek2_2;

sound(miks(1:length(kek1_2)), fs3);

miks = miks-mean(miks);
miks = miks/(1.001*max(abs(miks)));
audiowrite('miks.wav', miks(1:length(kek1_2)), fs3);

