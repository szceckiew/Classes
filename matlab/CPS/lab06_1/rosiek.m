clc;
clear all;
close all;


%Spectogram na oko :)
plik = 's.wav';
[a, b] = wavread(plik);
%spectrogram(a, chebwin(8000, 40), [], [697 770 852 941 1209 1336 1477 1600], b);

%http://www.mathworks.com/help/signal/examples/dft-estimation-with-the-goertzel-algorithm.html
%Zauwazylem ze ten skrypt jest strasznie czuly na jakiekolwiek zmiany
%parametrow :/
A = [697 770 852 941];
B = [1209 1336 1477];
C = ['1' '2' '3'; '4' '5' '6'; '7' '8' '9'; '*' '0' '#'];
f = [A B]; % Original frequencies

Nt = 1000;205;%205; %Nie wiem czemu jast tak nisko, ale niech zostanie
Fs = b; %Czestotliwosc probkowania naszego sygnalu
k = round(f/Fs*Nt); % Indices of the DFT

% estim_f = round(k*Fs/Nt); % Frequencies at which the DFT is estimated
% data = sum(sin(2*pi*[697;1209]*(0:N-1)/Fs));
% data = a(40000: 40000 + Nt);  
%Compute DFT using Goertzel algorithm
%Na razie tak, pozniej bede rokminial wzorki :P
% dft_data = goertzel(data,k+1); 

% result = abs(dft_data);

%Algorytm decyzyjny
% [val1, max1] = max(result(1:4));
% [val2, max2] = max(result(5:end));
% A(max1)
% B(max2)
% C(max1,max2)
%Plot the DFT magnitudes
% stem(f,abs(dft_data)); 
% set(gca,'xtick',f); xlabel('Hz');
% ylabel('Magnitude');

check = a>0.05
zero = 0;
jeden = 0;
start = 0;
wyniki = [];
wynikic = 1;
offset = 500;
for i=1:length(check)
   if(check(i) == 0)
       if i-jeden > offset
          zero = 1;
       end
%       [jeden i]
      if(start ~= 0 && i-jeden > offset)
          wyniki(wynikic, 1:2) = [start jeden-offset];
          wynikic = wynikic + 1;
          start = 0;
      end
   else
       jeden = i;
       if(zero)
           start = i;
           zero = 0;
       end
   end
end
PIN = '';
PIN2 = '';
x = 1;


for i=1:length(wyniki)
    start = round((wyniki(i,1) + wyniki(i,2))/2);
    data = a(start: start+Nt);
    dft_data = goertzel(data,k+1); 

    result = abs(dft_data);
    
    %Algorytm decyzyjny
    [val1, max1] = max(result(1:4));
    [val2, max2] = max(result(5:end));
    PIN(x) = C(max1,max2);
    AA = [];
    for j=1:length(f)
%         [f j];
        [d,c] = butter(1,[f(j)*2-11 f(j)*2+11]/b, 'bandpass');%butter(n,Wn)
        H=filter(d,c,data);
        Hm=abs(H); HmdB2=20*log10(Hm);
        plot(Hm)
%         pause
        AA(j) = mean(Hm);
    end
%     AA
    [g h] = max(AA(1:4));
    [gg hh] = max(AA(5:7));
    [x h hh];
    PIN2(x) = C(h,hh);
    x = x + 1;
end
close all;
PIN
PIN2


%     for j=1:7
%         j
% %         [f j];
%         [d,c] = butter(1,[f(j)*2-11 f(j)*2+11]/b, 'bandpass');%butter(n,Wn)
%         H=filter(d,c,a);
%         Hm=abs(H); HmdB2=20*log10(Hm);
%         plot(Hm)
% %         AA(j) = mean(Hm);
% pause
%     end