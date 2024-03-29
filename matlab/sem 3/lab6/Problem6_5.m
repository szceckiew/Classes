%Każdy punkt z rybiego oka dostaje odpowiednik. Musimy jakoś wyłapać jak
%wyciągnąc wektor przesunięcia dla danego punktu, i pokazać wektorem, jak
%punkt jest przesunięty. Wektor nanosimy na obrazek. Wyłapać, jaki wektor
%trzeba dać do danego puntu, żeby uzyskać obraz wyprostowany. Zrozumieć
%program, macierz zniekształceń beczkowych, wykorzystując odpowiednio,
%wyprostujemy obraz. Z macierzy przekształceń dostajemy macierz wektórow.
%Tą macierzą wektorów dostajemy jak przenieść. Klikamy na obraz i tam
%gdzieś można zobaczyć koordynaty piksela.

% approx_krata.m
close all; clear all;
% Generacja/wczytanie obrazka
N = 512; Nstep = 32;
[img, cmap] = imread('Lena512.bmp'); img = double(img); % Lena
%img = zeros(N,N);
% czarny kwadrat
if(1) % opcjonalna biala siatka
for i=Nstep:Nstep:N-Nstep, img(i-1:i+1,1:N) = 255*ones(3,N); end %poziome linie -1 i +1 zeby byla szerekosc paska 3
for j=Nstep:Nstep:N-Nstep, img(1:N,j-1:j+1) = 255*ones(N,3); end %pionowe linie
end
imshow(img,cmap); pause
% Dodawanie znieksztalcen beczkowych
a = [ 1.06, -0.0002, 0.000005 ]; % wspolczynniki wielomianu znieksztalcen
x=1:N; y=1:N; cx = N/2+0.5; cy = N/2+0.5;
[X,Y] = meshgrid( x, y );
% wszystkie x,y
r = sqrt( (X-cx).^2 + (Y-cy).^2 ); %Dla każdej wspolrzednej, kazdego piksela, obliczamy odleglosc od centrum.
% wszystkie odleglosci od srodka
R = a(1)*r.^1 + a(2)*r.^2 + a(3)*r.^3; % zmiana odleglosci od srodka
Rn = R ./ r;

% normowanie
imgR = interp2( img, (X-cx).*Rn+cx, (Y-cy).*Rn+cy );

% interploacja
figure;
subplot(1,2,1),imshow(img,cmap); title('Oryginal');
subplot(1,2,2),imshow(imgR,cmap); title('Rybie oko'); pause

% Estymacja znieksztalcen beczkowych
i = Nstep : Nstep : N-Nstep; j=i;   % polozenie linii w pionie i poziomie
[I,J] = meshgrid( i, j );   % wszystkie (x,y) punktow przeciec, jest 15lini x 15 linii
r = sqrt( (I-cx).^2 + (J-cy).^2 ); % wszystkie promienie od srodka dla przeciec linii.
R = a(1)*r + a(2)*r.^2 + a(3)*r.^3; % odpowiadajace punkty obrazu znieksztalconego
%Mimo, że używamy tutaj macierzy współczynników, to równie dobrze możemy
%wpisać tutaj Rki ręcznie, i tak trzeba zrobić jak nie znamy tej macierzy.

r = sort( r(:) );
% sortowanie
R = sort( R(:) );
% sortowanie

aest1 = pinv([ r.^1, r.^2, r.^3 ])*R; aest1 = [ aest1(end:-1:1); 0]; % rozw.1 odwracamy, ze bylo od wsp. wys do nisk.
aest2 = polyfit( r, R, 3)'; % rozw.2
[ aest1, aest2 ], pause % porownanie

aest = aest1; % wybor rozwiazania w ten sposób znajdujemy wspolczynniki wielomianu.

% Wielomian R=f(r) i odwrotny r=g(R)
%r = 0:N; % wybrane promienie
%R = polyval( aest, r); %Każde r staje się argumentem wielomianu o wspołczynnikach z aest, wynik do R.

% R=f(r) wielomianu znieksztalcen
figure; subplot(121); plot(r,R), title('R=f(r)');

ainv = polyfit( R, r, 3), % wspolczynniki wielomiany odwrotnego

subplot(122); plot(R,r), title('r=g(R)'); pause

% Korekta znieksztalcen beczkowych
[X,Y] = meshgrid( x, y ); % wszystkie punkty (x,y) znieksztalconego
R = sqrt( (X-cx).^2 + (Y-cy).^2 ); % wszystkie zle promienie
Rr = polyval( ainv, R ); % wszystkie dobre promienie
Rn = Rr./R;
% normowanie
imgRR=interp2( imgR, (X-cx).*Rn+cx, (Y-cy).*Rn+cy ); % interpolacja
%Punkt 1============================================================
P1 = [100,100];
RP1 = sqrt((P1(1)-cx).^2 + (P1(2)-cy).^2);
RP1r = polyval(ainv,RP1);
RP1n = RP1./RP1r;
P1fix = [(P1(1)-cx).*RP1n+cx, (P1(2)-cy).*RP1n+cy];
%Punkt 2 ===========================================================
P2 = [400,400];
RP2 = sqrt((P2(1)-cx).^2 + (P2(2)-cy).^2);
RP2r = polyval(ainv,RP2);
RP2n = RP2./RP2r;
P2fix = [(P2(1)-cx).*RP2n+cx, (P2(2)-cy).*RP2n+cy];
%Punkt 3 ===========================================================
P3 = [cx,cy];
RP3 = sqrt((P3(1)-cx).^2 + (P3(2)-cy).^2);
RP3r = polyval(ainv,RP3);
RP3n = RP3./RP3r;
P3fix = [(P3(1)-cx).*RP3n+cx, (P3(2)-cy).*RP3n+cy];
%===================================================================
figure;
subplot(1,2,1),
imshow(imgR,cmap); title('Wejscie - efekt rybie oko');
rectangle('Position',[P1 10 10],'EdgeColor','g');
rectangle('Position',[P2 10 10],'EdgeColor','r');
rectangle('Position',[P3 10 10],'EdgeColor','cyan')
subplot(1,2,2),imshow(imgRR,cmap); title('Wyjscie - po korekcie');
rectangle('Position',[P1fix 10 10],'EdgeColor','g');
rectangle('Position',[P2fix 10 10],'EdgeColor','r');
rectangle('Position',[P3fix 10 10],'EdgeColor','cyan')
colormap gray
pause
%}