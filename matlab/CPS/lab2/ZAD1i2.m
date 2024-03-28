N = 20;
A = zeros(N,N);
% A(1,1:N) = ones(1, N)

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

% A,

% w1 = A(5,1:N),
% w2 = A(5, 1:N),
% 
% w12 = w1.*w2;
% 
% prod1 = sum(w12),

for i = 1:20 % iteracja po wszystkich parach wektorów
    for j = i+1:20 % iteracja tylko po parach różnych wektorów
        dot_product = dot(macierz_analizy(i,:), macierz_analizy(j,:)); % obliczenie iloczynu skalarnego pary wektorów
        if dot_product > 0.000000001 % sprawdzenie, czy iloczyn skalarny jest równy zero
            disp('Iloczyn skalarny nie jest równy zero dla pary wektorów:');
            disp(['Wektor ' num2str(i) ': ' num2str(macierz_analizy(i,:))]);
            disp(['Wektor ' num2str(j) ': ' num2str(macierz_analizy(j,:))]);
            return % jeśli iloczyn skalarny nie jest równy zero, wyświetl komunikat i zakończ program
        end
    end
end

disp('Iloczyn skalarny jest równy zero dla każdej pary różnych wektorów.') % jeśli nie ma niezerowego iloczynu skalarnego, wyświetl komunikat o powodzeniu

% %2)
% S = A.';
% S*A,
% 
% x = randn(N,1);
% X = A*x
% 
% xs=S*X;
% 
% x, xs


