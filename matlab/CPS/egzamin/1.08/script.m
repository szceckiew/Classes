close all; clear all;

%time domain

%Splash
[y1, Fs1] = audioread("splash1a.wav");
player1 = audioplayer(y1,Fs1);
play(player1);

t1 = linspace(0,length(y1)/Fs1,length(y1));

figure(1)
plot(t1,y1);
title("splash1a.wav")
xlabel('time')
ylabel('amplitude')
pause

%Boat Air Horn
[y2, Fs2] = audioread("boatairhorn.wav");
player2 = audioplayer(y2,Fs2);
play(player2);

t2 = linspace(0,length(y2)/Fs2,length(y2));

figure(2)
plot(t2,y2);
title("boatairhorn.wav")
xlabel('time')
ylabel('amplitude')
pause

%Cicadas
[y3, Fs3] = audioread("minicic1.wav");
player3 = audioplayer(y3,Fs3);
play(player3);

t3 = linspace(0,length(y3)/Fs3,length(y3));

figure(3)
plot(t3,y3);
title("minicic1.wav")
xlabel('time')
ylabel('amplitude')
pause

%Tractor
[y4, Fs4] = audioread("tractor.wav");
player4 = audioplayer(y4,Fs4);
play(player4);

t4 = linspace(0,length(y4)/Fs4,length(y4));

figure(4)
plot(t4,y4);
xlabel('time')
ylabel('amplitude')
title("tractor.wav")