clear;
close all;

[x, fs1] = audioread('mowa8000.wav');
x1 = x';
x2 = fliplr(x1);

tmax = length(x1)/fs1;

fs = 400e3;
fc1 = 100e3;
fc2 = 110e3;
dA = 0.25;

t = 0:1/fs:tmax-1/fs;

xr1 = resample(x1, fs, fs1);
xr2 = resample(x2, fs, fs1);

y_dsb_c_a = (1+xr1).*cos(2*pi*fc1*t);
y_dsb_c_b = (1+xr2).*cos(2*pi*fc2*t);
y_dsb_c = dA*(y_dsb_c_a + y_dsb_c_b);

y_dsb_sc_a = xr1.*(cos(2*pi*fc1*t));
y_dsb_sc_b = xr2.*(cos(2*pi*fc2*t));
y_dsb_sc = dA*(y_dsb_sc_a + y_dsb_sc_b);

y_ssb_sc1_a = 0.5*xr1.*cos(2*pi*fc1*t) + 0.5*xr1.*sin(2*pi*fc1*t);
y_ssb_sc1_b = 0.5*xr2.*cos(2*pi*fc2*t) + 0.5*xr2.*sin(2*pi*fc2*t);
y_ssb_sc1 = dA*(y_ssb_sc1_a + y_ssb_sc1_b);

y_ssb_sc2_a = 0.5*xr1.*cos(2*pi*fc1*t) - 0.5*xr1.*sin(2*pi*fc1*t);
y_ssb_sc2_b = 0.5*xr2.*cos(2*pi*fc2*t) - 0.5*xr2.*sin(2*pi*fc2*t);
y_ssb_sc2 = dA*(y_ssb_sc2_a + y_ssb_sc2_b);

Y_dsb_c = fft(y_dsb_c);
Y_dsb_sc = fft(y_dsb_sc);
Y_ssb_sc1 = fft(y_ssb_sc1);
Y_ssb_sc2 = fft(y_ssb_sc2);

f = (0:length(Y_dsb_c)-1)/length(Y_dsb_c)*fs;

if(1)
    figure;
    subplot(2,2,1);
    plot(f, abs(Y_dsb_c));
    title('Transformata DSB-C');
    xlim([90e3 120e3]);
    subplot(2,2,2);
    plot(f, abs(Y_dsb_sc));
    title('Transformata DSB-SC');
    xlim([90e3 120e3]);
    subplot(2,2,3);
    plot(f, abs(Y_ssb_sc1));
    title('Transformata SSB-SC (+)');
    xlim([90e3 120e3]);
    subplot(2,2,4);
    plot(f, abs(Y_ssb_sc2));
    title('Transformata SSB-SC (-)');
    xlim([90e3 120e3]);
end

bb = firpm(20,[0.05 0.95],[1 1],'h'); 

x1_1 = sqrt(y_dsb_c_a.^2 + filter(bb,1,y_dsb_c_a).^2);
x1_2 = sqrt(y_dsb_sc_a.^2 + filter(bb,1,y_dsb_sc_a).^2);
x1_3 = sqrt(y_ssb_sc1_a.^2 + filter(bb,1,y_ssb_sc1_a).^2);
x1_4 = sqrt(y_ssb_sc2_a.^2 + filter(bb,1,y_ssb_sc2_a).^2);

x2_1 = sqrt(y_dsb_c_b.^2 + filter(bb,1,y_dsb_c_b).^2);
x2_2 = sqrt(y_dsb_sc_b.^2 + filter(bb,1,y_dsb_sc_b).^2);
x2_3 = sqrt(y_ssb_sc1_b.^2 + filter(bb,1,y_ssb_sc1_b).^2);
x2_4 = sqrt(y_ssb_sc1_b.^2 + filter(bb,1,y_ssb_sc2_b).^2);

x1_1dr = resample(x1_1,fs1,fs);
x1_2dr = resample(x1_2,fs1,fs);
x1_3dr = resample(x1_3,fs1,fs);
x1_4dr = resample(x1_4,fs1,fs);

x2_1dr = resample(x2_1,fs1,fs);
x2_2dr = resample(x2_2,fs1,fs);
x2_3dr = resample(x2_3,fs1,fs);
x2_4dr = resample(x2_4,fs1,fs);


fdown = 108e3;
fup = 112e3;

fdown = 98e3;
fup = 102e3;

N = 128;
b1 = fir1(N,[fdown/fs*2 fup/fs*2],hamming(N+1));

kek = filtfilt(b1,1,y_dsb_c);
kek = sqrt(kek.^2 + filter(bb,1,kek).^2);
kek = resample(kek,fs1,fs);
sound(kek,8000);
