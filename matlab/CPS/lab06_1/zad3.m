clear all
close all
[a,b] = audioread('s.wav');
spectrogram(a, 1000, [], [697 770 852 941 1209 1336 1477 1600], b);
A = [697 770 852 941];
B = [1209 1336 1477];
C = ['1' '2' '3'; '4' '5' '6'; '7' '8' '9'; '*' '0' '#'];
f = [A B]; % Original frequencies
Nt = 1000;
Fs = b; %Czestotliwosc probkowania naszego sygnalu
k = round(f/Fs*Nt);
k = round(f/Fs*Nt) + 1;
figure(1)
plot(abs(a))

for i=1:length(a)
    if (a(i)<0.05)
        a(i) = 0;
    end
end


data = a;
figure(2)
plot(data);
dft_data = goertzel(data,k)


