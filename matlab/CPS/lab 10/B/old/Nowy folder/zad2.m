% ----------------------------------------------------------
% Tabela 19-4 (str. 567)
% æwiczenie: Kompresja sygna³u mowy wed³ug standardu LPC-10
% ----------------------------------------------------------

clear all; clf;

[x,fpr,Nbits]=wavread('mowa1.wav');	      % wczytaj sygna³ mowy (ca³y)
%plot(x); title('sygnaï¿½ mowy'); pause	% poka¿ go
%soundsc(x,fpr);								% oraz odtwórz na g³oœnikach (s³uchawkach)
[x2,fpr2,Nbits2]=wavread('coldvox.wav');
N=length(x);	  % d³ugoœæ sygna³u
Mlen=240;		  % d³ugoœæ okna Hamminga (liczba próbek)
Mstep=180;		  % przesuniêcie okna w czasie (liczba próbek)
Np=10;			  % rz¹d filtra predykcji
gdzie=Mstep+1;	  % pocz¹tkowe po³o¿enie pobudzenia dŸwiêcznego
f = (1:Mlen)./fpr;
TT=[];

temp=0;
lpc=[];								   % tablica na wspó³czynniki modelu sygna³u mowy
s=[];									   % ca³a mowa zsyntezowana
ss=[];								   % fragment sygna³u mowy zsyntezowany
bs=zeros(1,Np);					   % bufor na fragment sygna³u mowy
Nramek=floor((N-Mlen)/Mstep+1);	% ile fragmentów (ramek) jest do przetworzenia
bz11=ones(1,240);
bz1=ones(1,240);

 x=filter([1 -0.9735], 1, x);	% filtracja wstïêpna (preemfaza) - opcjonalna

for  nr = 1 : Nramek
    
    % pobierz kolejny fragment sygna³u
    n = 1+(nr-1)*Mstep : Mlen + (nr-1)*Mstep;
    bx = x(n);
    
    % ANALIZA - wyznacz parametry modelu ---------------------------------------------------
     bx = bx - mean(bx);  % usuñ wartoœæ œredni¹
     P = 0.3*max(bx);
     bx = progowanie(bx,P);
    for k = 0 : Mlen-1
        r(k+1) = sum( bx(1 : Mlen-k) .* bx(1+k : Mlen) ); % funkcja autokorelacji
    end
    % subplot(411); plot(n,bx); title('fragment sygna³u mowy');
    % subplot(412); plot(r); title('jego funkcja autokorelacji');
    
    offset=20; rmax=max( r(offset : Mlen) );	   % znajdŸ maksimum funkcji autokorelacji
    imax=find(r==rmax);								   % znajdŸ indeks tego maksimum
    if ( rmax > 0.35*r(1) ) 
        T=imax; 
    else
        T=0; 
    end % g³oska dŸwiêczna/bezdŸwiêczna?
    if (T>80) T=round(T/2); end							% znaleziono drug¹ podharmoniczn¹
    %T							   							% wyœwietl wartoœæ T
    rr(1:Np,1)=(r(2:Np+1))';
    for m=1:Np
        R(m,1:Np)=[r(m:-1:2) r(1:Np-(m-1))];			% zbuduj macierz autokorelacji
    end
    a=-inv(R)*rr;											% oblicz wspó³czynniki filtra predykcji
    wzm=r(1)+r(2:Np+1)*a;									% oblicz wzmocnienie
    H=freqz(1,[1;a]);										% oblicz jego odp. czêstotliwoœciow¹
    H2 = 1./H;
    if (temp==0 && T>0)
        bz = conv(bx,H2);
        bz1 = abs(bz(512:end))' + bz1; 
        bz1 = bz1./2;
        temp=1;
    end
    % subplot(413); plot(abs(H)); title('widmo filtra traktu g³osowego');
    
    lpc=[lpc; T; wzm; a; ];								% zapamiêtaj wartoœci parametrów
    
    % SYNTEZA - odtwórz na podstawie parametrów ----------------------------------------------------------------------
    % T = 0;                                        % usuó pierwszy znak % i ustaw: T = 80, 50, 30, 0 (w celach testowych)
    if (T~=0) gdzie=gdzie-Mstep; end					% przenieœæ pobudzenie dŸwiêczne
    for n=1:Mstep
        % T = 70; % 0 lub > 25 - w celach testowych
        if( T==0)
            pob=2*x2(randi(length(x2))); gdzie=(3/2)*Mstep+1;			% pobudzenie szumowe
        else
            if (n==gdzie)                                
                pob = bz1(n);
                gdzie=gdzie+T;	   % pobudzenie dŸwiêczne
            else
                pob=0; 
            end
        end
        ss(n)=wzm*pob-bs*a;		% filtracja  syntetycznego  pobudzenia
        bs=[ss(n) bs(1:Np-1) ];	% przesuniêcie bufora wyjœciowego
    end
    % subplot(414); plot(ss); title('zsyntezowany fragment sygna³u mowy'); pause
    s = [s ss];						% zapamiêtanie zsyntezowanego fragmentu mowy
     
end

  s=filter(1,[1 -0.9735],s); % filtracja (deemfaza) - filtr odwrotny - opcjonalny
plot(bz1);
%plot(s); title('mowa zsyntezowana')
soundsc(s, fpr)
