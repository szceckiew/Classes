N = 100;
fp = 1000;
f1 = 50; % częstotliwość pierwszej sinusoidy
f2 = 100; % częstotliwość drugiej sinusoidy
f3 = 150; % częstotliwość trzeciej sinusoidy
A1 = 50; % amplituda pierwszej sinusoidy
A2 = 100; % amplituda drugiej sinusoidy
A3 = 150; % amplituda trzeciej sinusoidy

t=0:1/fp:(N-1)/fp,

x1 = A1 * sin(2*pi*f1*t);
x2 = A2 * sin(2*pi*f2*t);
x3 = A3 * sin(2*pi*f3*t);

x=x1+x2+x3;


A = zeros(N,N);

s0=sqrt(1/N)
s1=sqrt(2/N);

for k=0:N-1
   for n=0:N-1
      if(k==0)
          A(k+1, n+1) = s0*cos( (pi*k/N) * (n+0.5));
          continue
      end
      A(k+1, n+1) = s1*cos( (pi*k/N) * (n+0.5));
   end
end

A,
S = A.',

figure;
hold on;
for i = 1:N
    plot(t, A(i,:));   % wykres wierszy macierzy A
    plot(t, S(:,i));   % wykres kolumn macierzy S
    pause(0.001);
end
hold off;

y = A*x';            % Współczynniki DCT

% Wyświetlenie wyników
figure;
subplot(2,1,1);
stem(abs(y));       % Wartości współczynników DCT
title('Współczynniki DCT');
xlabel('Numer współczynnika');
ylabel('Wartość');


% Obliczenie amplitud i częstotliwości składowych sygnału
f = (0:N-1)*fp/N;   % Oś częstotliwości
Amp1 = A1/2;
Amp2 = A2/2;
Amp3 = A3/2;
F1 = f1;
F2 = f2;
F3 = f3;

% Porównanie z wartościami składowych sygnału
subplot(2,1,2);
stem(f, abs(y));    % Wartości współczynników DCT
hold on;
stem(F1, Amp1, 'r');    % Amplituda i częstotliwość pierwszej składowej
stem(F2, Amp2, 'g');    % Amplituda i częstotliwość drugiej składowej
stem(F3, Amp3, 'b');    % Amplituda i częstotliwość trzeciej składowej
title('Współczynniki DCT i składowe sygnału');
xlabel('Częstotliwość [Hz]');
ylabel('Wartość');
legend('Współczynniki DCT', 'Składowa 1', 'Składowa 2', 'Składowa 3');

x_r = S*y;

x,
x_r,

