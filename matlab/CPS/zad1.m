
%%% dane rozruchowe

fp1 = 1189;                 % [Hz]
fp2 = 1229;                 % [Hz]
N = 16000;
bw = fp2-fp1;               % [Hz]
fcenter = (fp2+fp1)/2;      % [Hz]
fs= 16e3;                   % [Hz]


A1 = 1;
A2 = 1;
f1 = 1209;                  % [Hz]
f2 = 1272;                  % [Hz]

%f = 0:1:N;
f = linspace(0,N,N);
w = f*2*pi;

%%% obliczenie charakterystyki filtru danego w pliku

load('butter.mat');

[ba, aa] = zp2tf(z, p, k); 
[Ha, Wa] = freqs(ba, aa, w);

%%% przygotowanie filtru bez wykorzystania pre-warp

[bx,ax] = bilinear(ba,aa,fs);
[Hx,Wx] = freqz(bx,ax,f,fs);

%%% przygotowanie filtru z wykorzystaniem pre-warp

Nlpf= 4; %%% dla 4 wykresy identyczne        
[bc,ac,F1,F2] = bp_synth(Nlpf,fcenter,bw,fs);
[Hc,Wc] = freqz(bc,ac,f,fs);

%%% prototyp analogowy bandpass pre-warp

[bA,aA] = butter(4,1,'s');
[bt,at] = lp2bp(bA,aA,(F2+F1)*pi,(F2-F1)*2*pi);
[hA, wA] = freqs(bt, at, w);

%%% zmienne pomocnicze

x3dB = [1000 1500]; y3dB = [-3 -3];
xfp1 = [1189 1189]; yfp1 = [0 -6];
xfp2 = [1229 1229]; yfp2 = [0 -6];

%%% wyœwietlenie wyniku

Ha_abs = abs(Ha);
Hc_abs = abs(Hc);
Hx_abs = abs(Hx);
hA_abs = abs(hA);

Ha_dB = 20*log10(Ha_abs);
Hc_dB = 20*log10(Hc_abs);
Hx_dB = 20*log10(Hx_abs);
hA_dB = 20*log10(hA_abs);

figure(1);
plot(f,Ha_dB,'r-');
hold on;
plot(f,Hc_dB,'b.-');
hold on;
plot(f,Hx_dB,'m*-');
hold on;
plot(f,hA_dB,'x-k');
hold on;
plot(x3dB,y3dB,'g',xfp2,yfp2,'g',xfp1,yfp1,'g');
    %%% opis i ograniczenia
        title('Transmitancja filtrów:');
        xlabel('Czêstotliwoœæ [Hz]');
        ylabel('T³umienie [dB]');
        legend('analogowego','cyfrowego z prewarpingiem','cyfrowego bez prewarpingu','analogowego prototypu pre-warp');
        xlim([1160 1270]);
        ylim([-6 0]);
        
%%% filtracja przez iloczyn w czêstotliwoœci

t = 1/fs:1/fs:1;
%t = 0:1/fs:1;
xsig = A1*sin(2*pi*f1*t) + A2*sin(2*pi*f2*t);

Xsig = fft(xsig)/(N/2);
Xsig_abs = abs(Xsig);
Xsig_dB = 20*log10(Xsig_abs);

Ya = Ha .* Xsig;
Yc = Hc .* Xsig; 
YA = hA .* Xsig;

Ya_abs = abs(Ya);
Yc_abs = abs(Yc);
YA_abs = abs(YA);

Ya_dB = 20*log10(Ya_abs);
Yc_dB = 20*log10(Yc_abs);
YA_dB = 20*log10(YA_abs);

ya = ifft(Ya);
yc = ifft(Yc);
yA = ifft(YA);

%%% filtracja z uzyciem filter()

yy = filter(bc,ac,xsig);
YY = 20*log10(abs(fft(yy)/(N/2)));

%%% sygna³y w dziedzinie czêstotliwoœci

figure(2)
plot(f,Xsig_dB,'kx');
hold on;
plot(f,Ya_dB,'r-*');
hold on;
plot(f,Yc_dB,'b-o');
hold on;
plot(f,YY,'m-*');
    %%% opis i ograniczenia
        title('Widmo sygna³u:');
        xlabel('Czêstotliwoœæ [Hz]');
        ylabel('T³umienie [dB]');
        legend('orginalny sygna³','filtrowany analogowo','filtrowany cyfrowo','cyfrowo funkcj¹ filter()');
        xlim([1150 1300]);
        ylim([-100 0]);

%%% sygna³y w dziedzinie czasu
        
figure(3)
plot(t,xsig,'k-x');
hold on;
plot(t,N*real(ya),'r-*');
hold on;
plot(t,N/2*real(yc),'b-o');
hold on;
plot(t,yy,'m-*');
    %%% opis i ograniczenia
        title('Widmo sygna³u:');
        xlabel('Czas [s]');
        ylabel('Amplituda');
        legend('orginalny sygna³','filtrowany analogowo','filtrowany cyfrowo','cyfrowo funkcj¹ filter()');
        
        %%% w filtracji analogowej (ba,aa) filter() wysypuje siê (NaN)
        %%% w cyfrowej mo¿emy zauwa¿yæ odpowiedŸ impulsow¹ :O ???? sygna³u
        
        %%% przesuniecie = 0 rozpêdzanie siê ?? funkcji filter()
        %%% przesuniecie wieksze zbieznosc z iloczynem i ifft()
        
        przesuniecie = 0.5; %%%  przesuniecie wykresu
        
        xlim([0+przesuniecie 0.015+przesuniecie]);
        

    

