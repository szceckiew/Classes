clear all; close all;

fs = 8000;
T = 0.5;
dt = 1/fs; N = round(T/dt); t = dt*(0:N-1);
damp=exp(-t/(T/2));

freqs=[261.6, 293.7, 329.6, 249.6, 391.9, 440.0, 493.9];
kb = [freqs; 2*freqs];
temp = kb'; f = temp(:);

gama = [];
for k = 1: length(f)
    x = damp .* sin(2*pi*f(k)*t);
    gama = [gama x];
end

%soundsc(gama,fs)

myfreqs = [ kb(1,5) kb(1,5) kb(1,6) kb(1,5) kb(2,1) kb(1,7) ...
            kb(1,5) kb(1,5) kb(1,6) kb(1,5) kb(2,2) kb(1,2) ...
            kb(1,5) kb(1,5) kb(2,5) kb(2,3) kb(2,1) kb(1,7) kb(1,6) ...
            kb(2,4) kb(2,4) kb(2,3) kb(2,1) kb(2,2) kb(2,1)];

mysong = [];
for k = 1: length(myfreqs)
    x = damp .* sin(2*pi*myfreqs(k)*t);
    mysong = [mysong x];
end

soundsc(mysong,fs);
