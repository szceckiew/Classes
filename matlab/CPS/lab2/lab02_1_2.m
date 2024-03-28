clear all;
close all;
clc;
% stwórz macierz
N=20;
macierz_analizy=zeros(N,N);
for k=0:(N-1)
    if k==0
        s=sqrt(1/N);
    else
        s=sqrt(2/N);
    end
    for n=0:(N-1)
        macierz_analizy(k+1,n+1)=s*cos(pi*(k/N)*(n+0.5));
    end
end
% sprawdź czy jest ortonormalna - iloczyn skalarny wszystkich par jest równy zero
% (ortogonalna - (A*(A^T)=(A^T)*A=I))


for i = 1:20 % iteracja po wszystkich parach wektorów
    for j = i+1:20 % iteracja tylko po parach różnych wektorów
        %dot - po prostu oblicza iloczyn skalarny podanych wektorów
        dot_product = dot(macierz_analizy(i,:), macierz_analizy(j,:)); % obliczenie iloczynu skalarnego pary wektorów
        if dot_product > 0.000000001 % sprawdzenie, czy iloczyn skalarny jest równy zero
            disp('Iloczyn skalarny nie jest równy zero dla pary wektorów:');
            disp(['Wektor ' num2str(i) ': ' num2str(macierz_analizy(i,:))]);
            disp(['Wektor ' num2str(j) ': ' num2str(macierz_analizy(j,:))]);
            return % jeśli iloczyn skalarny nie jest równy zero, wyświetl komunikat i zakończ program; macierz nie jest ortonormalna
        end
    end
end

disp('Iloczyn skalarny jest równy zero dla każdej pary różnych wektorów.') % jeśli nie ma niezerowego iloczynu skalarnego, wyświetl komunikat o powodzeniu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%zad 2
% sprawdź czy jest równa z identycznościową
macierz_syntezy = macierz_analizy.';
matlab_moment=(macierz_syntezy*macierz_analizy==eye(N,N)); % komórka 1,1 jest równa 1 
if matlab_moment(1,1)==1
    disp('S*A==I');
else
    disp('S*A~=I');
end

% sygnał losowy
x=randn(N,1);

%analiza
X=macierz_analizy*x;

%rekonstrukcja - synteza
x_s=macierz_syntezy*X;

% różnice są rzędu 10^-15
error=sum(abs((x-x_s))/N);
disp('Średnia różnica sygnału po rekonstrukcji')
error,

