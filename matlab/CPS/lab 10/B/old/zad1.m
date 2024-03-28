% ----------------------------------------------------------
% Tabela 19-4 (str. 567)
% �wiczenie: Kompresja sygna�u mowy wed�ug standardu LPC-10
% ----------------------------------------------------------

 clear all; 
 close all;
 
% 
% Hs=spectrum.welch('Hamming',2048);
[x,fpr,Nbits]=wavread('mowa1.wav');	      % wczytaj sygna� mowy (ca�y)
oryginalny = x;
bezdzw = 3.95e4: 4.05e4; %g�oska bezdzwieczna
dzw = 3.85e4:3.95e4; %gloska dzwieczna (troche zaszumione y)

%wyswietl na wykresie
hold on;
plot((1:length(x))/fpr, x); title('sygna� mowy');
plot(bezdzw/fpr, x(bezdzw), 'r');
plot(dzw/fpr, x(dzw), 'g');
hold off;
% pause;

%widma gestosci mocy
hpsdd1=dspdata.psd(abs(x(dzw)),'Fs',fpr);
% plot(hpsd); pause
hpsdb1=dspdata.psd(abs(x(bezdzw)),'Fs',fpr);
% plot(hpsd); pause

% soundsc(x,fpr);								% oraz odtw�rz na g�o�nikach (s�uchawkach)

N=length(x);	  % d�ugo�� sygna�u
Mlen=240;		  % d�ugo�� okna Hamminga (liczba pr�bek)
Mstep=180;		  % przesuni�cie okna w czasie (liczba pr�bek)
Np=10;			  % rz�d filtra predykcji
gdzie=Mstep+1;	  % pocz�tkowe polo�enie pobudzenia d�wi�cznego

lpc=[];								   % tablica na wsp�czynniki modelu sygna�u mowy
s=[];									   % ca�a mowa zsyntezowana
ss=[];								   % fragment sygna�u mowy zsyntezowany
bs=zeros(1,Np);					   % bufor na fragment sygna�u mowy
Nramek=floor((N-Mlen)/Mstep+1);	% ile fragment�w (ramek) jest do przetworzenia

x=filter([1 -0.9735], 1, x);	% filtracja wst�pna (preemfaza) - opcjonalna

%Podpunkt a
hpsdd2=dspdata.psd(abs(x(dzw)),'Fs',fpr);
hpsdb2=dspdata.psd(abs(x(bezdzw)),'Fs',fpr);
plot(dzw, oryginalny(dzw), dzw, x(dzw));
% pause
plot(bezdzw, oryginalny(bezdzw), bezdzw, x(bezdzw));
% pause
plot((0:length(hpsdd1.DATA)-1)/(length(hpsdd1.DATA)-1)*fpr, hpsdd1.DATA, (0:length(hpsdd2.DATA)-1)/(length(hpsdd2.DATA)-1)*fpr, hpsdd2.DATA);
% pause
plot((0:length(hpsdb1.DATA)-1)/(length(hpsdb1.DATA)-1)*fpr, hpsdb1.DATA, (0:length(hpsdb2.DATA)-1)/(length(hpsdb2.DATA)-1)*fpr, hpsdb2.DATA);

%Kwantyzacje
quant8 = -1.9:3.8/(2^8-1):1.9;
quant6 = -1.2:2.4/(2^8-1):1.2;
quant4 = -0.6:1.2/(2^8-1):0.6;

for  nr = 1 : Nramek
    
    % pobierz kolejny fragment sygna�u
    n = 1+(nr-1)*Mstep : Mlen + (nr-1)*Mstep;
    bx = x(n);
    
    %Progowanie - str. 554 (570 z PDF'a)
    P = 0.3 * max (bx);
    for iii=1:length(bx)
       if(bx(iii) >= P)
           bx(iii) = bx(iii) - P;
       elseif bx(iii) <= -P
           bx(iii) = bx(iii) + P;
       else
           bx(iii) = 0;
       end
    end
    
    % ANALIZA - wyznacz parametry modelu ---------------------------------------------------
    bx = bx - mean(bx);  % usu� warto�� �redni�
    for k = 0 : Mlen-1
        r(k+1) = sum( bx(1 : Mlen-k) .* bx(1+k : Mlen) ); % funkcja autokorelacji
    end
    % subplot(411); plot(n,bx); title('fragment sygna�u mowy');
    % subplot(412); plot(r); title('jego funkcja autokorelacji');
    
    offset=20; rmax=max( r(offset : Mlen) );	   % znajd� maksimum funkcji autokorelacji
    imax=find(r==rmax);								   % znajd� indeks tego maksimum
    if ( rmax > 0.35*r(1) ) T=imax; else T=0; end % g�oska d�wi�czna/bezd�wi�czna?
    % if (T>80) T=round(T/2); end							% znaleziono
    % drug� podharmoniczn�
%     if(T>0)
%         [T, rmax]
%     else
%         T
%     end
    rr(1:Np,1)=(r(2:Np+1))';
    for m=1:Np
        R(m,1:Np)=[r(m:-1:2) r(1:Np-(m-1))];			% zbuduj macierz autokorelacji
    end
    a=-inv(R)*rr;											% oblicz wsp�czynniki filtra predykcji
    wzm=r(1)+r(2:Np+1)*a;									% oblicz wzmocnienie
    H=freqz(1,[1;a]);										% oblicz jego odp. cz�stotliwo�ciow�
%     plot(abs(H)); title('widmo filtra traktu g�osowego');
%     pause(0.1);
    % lpc=[lpc; T; wzm; a; ];								% zapami�taj warto�ci parametr�w
    
    % SYNTEZA - odtw�rz na podstawie parametr�w ----------------------------------------------------------------------
    % T = 0;                                        % usu� pierwszy znak '%' i ustaw: T = 80, 50, 30, 0 (w celach testowych)
    aa(1, 1) = quant8(quantiz(a(1), quant8));
    aa(2, 1) = quant8(quantiz(a(2), quant8));
    aa(3, 1) = quant6(quantiz(a(3), quant6));
    aa(4, 1) = quant6(quantiz(a(4), quant6));
    aa(5, 1) = quant6(quantiz(a(5), quant6));
    aa(6, 1) = quant6(quantiz(a(6), quant6));
    aa(7, 1) = quant4(quantiz(a(7), quant4));
    aa(8, 1) = quant4(quantiz(a(8), quant4));
    aa(9, 1) = quant4(quantiz(a(9), quant4));
    aa(10, 1) = quant4(quantiz(a(10), quant4));
    
%     plot(aa-a), pause
    if (T~=0) gdzie=gdzie-Mstep; end					% 'przenie�' pobudzenie dxwi�czne
    for n=1:Mstep
        % T = 70; % 0 lub > 25 - w celach testowych
        if( T==0)
            pob=2*(rand(1,1)-0.5); gdzie=(3/2)*Mstep+1;			% pobudzenie szumowe
        else
            if (n==gdzie) pob=1; gdzie=gdzie+T;	   % pobudzenie d�wi�czne
            else pob=0; end
        end
        ss(n)=wzm*pob-bs*aa;		% filtracja 'syntetycznego' pobudzenia
        
        bs=[ss(n) bs(1:Np-1) ];	% przesuni�cie bufora wyj�ciowego
    end
    % subplot(414); plot(ss); title('zsyntezowany fragment sygna�u mowy'); pause
    s = [s ss];						% zapami�tanie zsyntezowanego fragmentu mowy
end

s=filter(1,[1 -0.9735],s); % filtracja (deemfaza) - filtr odwrotny - opcjonalny

plot(s); title('mowa zsyntezowana'); %pause
soundsc(s, fpr)

