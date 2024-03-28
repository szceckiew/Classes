% ----------------------------------------------------------
% Tabela 19-4 (str. 567)
% �wiczenie: Kompresja sygna�u mowy wed�ug standardu LPC-10
% ----------------------------------------------------------

clear all; clf;

[x,fpr,Nbits]=wavread('mowa1.wav');	      % wczytaj sygna� mowy (ca�y)
%[x2,fpr2,Nbits2]=wavread('coldvox.wav');
x = x(3000:3700); %gloska dzwieczna
%x = x(80700:81400); %gloska bezdzwieczna
do_wykresu = (0:length(x)-1)*fpr/(length(x)); %czestotliwosci
%soundsc(x,fpr);								% oraz odtw�rz na g�o�nikach (s�uchawkach)

N=length(x);	  % d�ugo�� sygna�u
Mlen=240;		  % d�ugo�� okna Hamminga (liczba pr�bek)
Mstep=180;		  % przesuni�cie okna w czasie (liczba pr�bek)
Np=10;			  % rz�d filtra predykcji
gdzie=Mstep+1;	  % pocz�tkowe po�o�enie pobudzenia d�wi�cznego

lpc=[];								   % tablica na wsp�czynniki modelu sygna�u mowy
s=[];									   % ca�a mowa zsyntezowana
ss=[];								   % fragment sygna�u mowy zsyntezowany
bs=zeros(1,Np);					   % bufor na fragment sygna�u mowy
Nramek=floor((N-Mlen)/Mstep+1);	% ile fragment�w (ramek) jest do przetworzenia

%Punkt 1a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
subplot(2,1,1)
plot(x); title('sygnal mowy przed preemfaza'); 	% poka� go
subplot(2,1,2)
[ psdx,freq] = widmo_gestosci_mocy(x,fpr);
plot(freq,10*log10(psdx)); title('widmo przed preemfaza'); 

x=filter([1 -0.9735], 1, x);	% filtracja wstepna (preemfaza) - opcjonalna

figure(2)
subplot(2,1,1)
plot(x); title('sygnal mowy po preemfaza'); 
subplot(2,1,2)
[ psdx,freq] = widmo_gestosci_mocy(x,fpr);
plot(freq,10*log10(psdx)); title('widmo po preemfaza'); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for  nr = 1 : Nramek
    
    % pobierz kolejny fragment sygnalu
    n = 1+(nr-1)*Mstep : Mlen + (nr-1)*Mstep;
    bx = x(n);
    % ANALIZA - wyznacz parametry modelu ---------------------------------------------------
   % bx = bx - mean(bx);  % usun warto�� �redni�
   P = 0.3*max(bx);
   bx = progowanie(bx,P);
    for k = 0 : Mlen-1
        r(k+1) = sum( bx(1 : Mlen-k) .* bx(1+k : Mlen) ); % funkcja autokorelacji
    end
    figure(4)
    subplot(411); plot(n,x(n)); title('fragment sygnalu mowy przed progowaniem');
    subplot(412); plot(n,bx); title('fragment sygnalu mowy po progowaniu');
    subplot(413); plot(1:length(r),r,1:0.1:length(r),P,'r'); title('jego funkcja autokorelacji');
    
    offset=20; rmax=max( r(offset : Mlen) );	   % znajd� maksimum funkcji autokorelacji
    imax=find(r==rmax);								   % znajd� indeks tego maksimum
    if ( rmax > 0.35*r(1) ) T=imax; else T=0; end % g�oska d�wi�czna/bezd�wi�czna?
    % if (T>80) T=round(T/2); end							% znaleziono drug� podharmoniczn�
    %T							   							% wy�wietl warto�� T
    rr(1:Np,1)=(r(2:Np+1))';
    for m=1:Np
        R(m,1:Np)=[r(m:-1:2) r(1:Np-(m-1))];			% zbuduj macierz autokorelacji
    end
    a=-inv(R)*rr;	% oblicz wsp�czynniki filtra predykcji
    %a = kwantuj(a);
    
    wzm=r(1)+r(2:Np+1)*a;									% oblicz wzmocnienie
    H=freqz(1,[1;a]);										% oblicz jego odp. cz�stotliwo�ciow�
     figure(3); plot(abs(H)); title('widmo filtra traktu glosowego');
    
    % lpc=[lpc; T; wzm; a; ];								% zapami�taj warto�ci parametr�w
    
    % SYNTEZA - odtworz na podstawie parametrow ----------------------------------------------------------------------
     %T = 0;                                        % usu� pierwszy znak �%� i ustaw: T = 80, 50, 30, 0 (w celach testowych)
    if (T~=0) 
        gdzie=gdzie-Mstep; 
        czestotliwosc_tonu_podstawowego = 1/(T/fpr)
    end					% �przenie�� pobudzenie d�wi�czne
    for n=1:Mstep
        % T = 70; % 0 lub > 25 - w celach testowych
        if( T==0)
                     
            pob=2*(rand(1,1)-0.5); gdzie=(3/2)*Mstep+1;			% pobudzenie szumowe
        else
            %T=T*2; % onizenie tonu podstawowego dwukrotnie?        
           
            if (n==gdzie) pob=1; gdzie=gdzie+T;	   % pobudzenie d�wi�czne
            else pob=0; end
        end
        ss(n)=wzm*pob-bs*a;		% filtracja �syntetycznego� pobudzenia
        bs=[ss(n) bs(1:Np-1) ];	% przesun�cie bufora wyj�ciowego
    end
    figure(4)
    subplot(414); plot(ss); title('zsyntezowany fragment sygna�u mowy');
    s = [s ss];						% zapami�tanie zsyntezowanego fragmentu mowy
end

s=filter(1,[1 -0.9735],s); % filtracja (deemfaza) - filtr odwrotny - opcjonalny
figure(5)
plot(s); title('mowa zsyntezowana'); 
soundsc(s, fpr)
