% ----------------------------------------------------------
% Tabela 19-4 (str. 567)
% �wiczenie: Kompresja sygna�u mowy wed�ug standardu LPC-10
% ----------------------------------------------------------

clear all; clf;

[x,fpr,Nbits]=wavread('mowa1.wav');	      % wczytaj sygna� mowy (ca�y)
%plot(x); title('sygna� mowy'); pause	% poka� go
%soundsc(x,fpr);								% oraz odtw�rz na g�o�nikach (s�uchawkach)
[x2,fpr2,Nbits2]=wavread('coldvox.wav');
N=length(x);	  % d�ugo�� sygna�u
Mlen=240;		  % d�ugo�� okna Hamminga (liczba pr�bek)
Mstep=180;		  % przesuni�cie okna w czasie (liczba pr�bek)
Np=10;			  % rz�d filtra predykcji
gdzie=Mstep+1;	  % pocz�tkowe po�o�enie pobudzenia d�wi�cznego
f = (1:Mlen)./fpr;
TT=[];

temp=0;
lpc=[];								   % tablica na wsp�czynniki modelu sygna�u mowy
s=[];									   % ca�a mowa zsyntezowana
ss=[];								   % fragment sygna�u mowy zsyntezowany
bs=zeros(1,Np);					   % bufor na fragment sygna�u mowy
Nramek=floor((N-Mlen)/Mstep+1);	% ile fragment�w (ramek) jest do przetworzenia
bz11=ones(1,240);
bz1=ones(1,240);

 x=filter([1 -0.9735], 1, x);	% filtracja wst��pna (preemfaza) - opcjonalna

for  nr = 1 : Nramek
    
    % pobierz kolejny fragment sygna�u
    n = 1+(nr-1)*Mstep : Mlen + (nr-1)*Mstep;
    bx = x(n);
    
    % ANALIZA - wyznacz parametry modelu ---------------------------------------------------
     bx = bx - mean(bx);  % usu� warto�� �redni�
     P = 0.3*max(bx);
     bx = progowanie(bx,P);
    for k = 0 : Mlen-1
        r(k+1) = sum( bx(1 : Mlen-k) .* bx(1+k : Mlen) ); % funkcja autokorelacji
    end
    % subplot(411); plot(n,bx); title('fragment sygna�u mowy');
    % subplot(412); plot(r); title('jego funkcja autokorelacji');
    
    offset=20; rmax=max( r(offset : Mlen) );	   % znajd� maksimum funkcji autokorelacji
    imax=find(r==rmax);								   % znajd� indeks tego maksimum
    if ( rmax > 0.35*r(1) ) 
        T=imax; 
    else
        T=0; 
    end % g�oska d�wi�czna/bezd�wi�czna?
    if (T>80) T=round(T/2); end							% znaleziono drug� podharmoniczn�
    %T							   							% wy�wietl warto�� T
    rr(1:Np,1)=(r(2:Np+1))';
    for m=1:Np
        R(m,1:Np)=[r(m:-1:2) r(1:Np-(m-1))];			% zbuduj macierz autokorelacji
    end
    a=-inv(R)*rr;											% oblicz wsp�czynniki filtra predykcji
    wzm=r(1)+r(2:Np+1)*a;									% oblicz wzmocnienie
    H=freqz(1,[1;a]);										% oblicz jego odp. cz�stotliwo�ciow�
    H2 = 1./H;
    if (temp==0 && T>0)
        bz = conv(bx,H2);
        bz1 = abs(bz(512:end))' + bz1; 
        bz1 = bz1./2;
        temp=1;
    end
    % subplot(413); plot(abs(H)); title('widmo filtra traktu g�osowego');
    
    lpc=[lpc; T; wzm; a; ];								% zapami�taj warto�ci parametr�w
    
    % SYNTEZA - odtw�rz na podstawie parametr�w ----------------------------------------------------------------------
    % T = 0;                                        % usu� pierwszy znak % i ustaw: T = 80, 50, 30, 0 (w celach testowych)
    if (T~=0) gdzie=gdzie-Mstep; end					% przenie�� pobudzenie d�wi�czne
    for n=1:Mstep
        % T = 70; % 0 lub > 25 - w celach testowych
        if( T==0)
            pob=2*x2(randi(length(x2))); gdzie=(3/2)*Mstep+1;			% pobudzenie szumowe
        else
            if (n==gdzie)                                
                pob = bz1(n);
                gdzie=gdzie+T;	   % pobudzenie d�wi�czne
            else
                pob=0; 
            end
        end
        ss(n)=wzm*pob-bs*a;		% filtracja  syntetycznego  pobudzenia
        bs=[ss(n) bs(1:Np-1) ];	% przesuni�cie bufora wyj�ciowego
    end
    % subplot(414); plot(ss); title('zsyntezowany fragment sygna�u mowy'); pause
    s = [s ss];						% zapami�tanie zsyntezowanego fragmentu mowy
     
end

  s=filter(1,[1 -0.9735],s); % filtracja (deemfaza) - filtr odwrotny - opcjonalny
plot(bz1);
%plot(s); title('mowa zsyntezowana')
soundsc(s, fpr)
