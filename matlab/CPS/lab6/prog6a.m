% Lab. 6 - filtry cyfrowe IIR
clear all; close all;

fpr = 8000;
Nx = 8000;

if(0) % Pierwszy test
   b = [ 1, 0.5, 0.25 ];
   a = [ 1, 0.25, 0.1];
end
if(0) % Metoda zer i bigunów
   z = exp( j*2*pi*[500, 1000]/fpr); z = [ z, conj(z) ];  % zara H(z) usuwają
   p = 0.999*exp( j*2*pi*[100]/fpr); p = [ p, conj(p) ];  % bieguny H(z) wzmacniają
   b = poly(z);
   a = poly(p);
end
if(1) % Profesjonalny projekt
   K = 8;
   f1 = 250; f2 = 750;
    [ b, a ] = butter( K, [ 100 ]/(fpr/2) );
  % [ b, a ] = butter( K, [f1,f2]/(fpr/2), 'bandpass' );
  % [ b, a ] = cheby1( K, 3, [f1,f2]/(fpr/2), 'bandpass' );
  % [ b, a ] = cheby2( K, 100, [f1,f2]/(fpr/2), 'bandpass' );
  % [ b, a ] = ellip( K, 3,100, [f1,f2]/(fpr/2), 'bandpass' );
   z = roots(b);
   p = roots(a);
end    

% Położenie zer i biegunów
  fi = 0 : pi/1000 : 2*pi; c = cos(fi); s=sin(fi);
  figure;
  plot(c,s,'k-',real(z),imag(z),'bo',real(p),imag(p),'r*'); title('ZP'); pause

% Transmitacja H(z) i ch-ka częstotliwosciowa H(f)
f = 0 : (fpr/2) / 1000 : fpr/2;
z = exp( j*2*pi*f/fpr);

H = polyval( b(end:-1:1), z ) ./ polyval( a(end:-1:1), z );

figure
subplot(211); plot(f,20*log10(abs(H)),'.-'); xlabel('f [Hz]'); title('|H(f)| [dB]'); grid;
axis([0,fpr/2,-120,20]);
subplot(212); plot(f,unwrap(angle(H)),'.-'); xlabel('f [Hz]'); title(' kat H(f) [rad]'); grid; pause

figure
subplot(111); semilogx(f,20*log10(abs(H)),'.-'); xlabel('f [Hz]'); title('|H(f)| [dB]'); grid;
axis([0,fpr/2,-160,20]); pause

% Sygnał
dt = 1/fpr;
t = dt*(0:Nx-1);
x = sin(2*pi*100*t) + sin(2*pi*500*t) + sin(2*pi*1000*t);
figure;
plot(t,x,'.-'); xlabel('t [s]'); title('x(t)'); grid; pause

% Filtracja
Nb = length(b);
Na = length(a);
a = a(2:Na); Na = Na-1;
bx = zeros(1,Nb);
by = zeros(1,Na);
for n = 1 : Nx
    bx = [ x(n), bx(1:Nb-1)];
    y(n) = sum( bx .* b ) -  sum( by .* a );
    by = [ y(n), by(1:Na-1)];
end 

i = 1 : 1000;
figure
subplot(211); plot(t(i),x(i),'.-'); xlabel('t [s]'); title('x(t)'); grid;
subplot(212); plot(t(i),y(i),'.-'); xlabel('t [s]'); title('y(t)'); grid; pause

x = x(Nx/2+1:Nx);
y = y(Nx/2+1:Nx);
Nx = Nx/2;
X = fft(x)/Nx;
Y = fft(y)/Nx;
f0 = fpr/Nx;
f = f0*(0:Nx-1);
figure
subplot(211); plot(f,20*log10(abs(X)),'.-'); xlabel('f [Hz]'); title('|X(f)| [dB]'); grid;
subplot(212); plot(f,20*log10(abs(Y)),'.-'); xlabel('f [Hz]'); title('|Y(f)| [dB]'); grid; pause
