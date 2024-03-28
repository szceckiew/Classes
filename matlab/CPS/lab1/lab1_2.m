close all; clear all;
A=230;
Tcalk=0.1;
f=200;
fp=10000;

T=1/fp; %okres próbkowania
n=fp*Tcalk; %ilość próbek;
N=1:n; %wektor próbek

[x,t]=lab1_1_pomsin(Tcalk,fp,f,A);

figure;
plot(t,x,'b-o');


wynik=@(t,n) x(n)*sinc(n/T*(t-n*T));

i=1;
for t=0:0.1:1
    suma=0;
    for pr=1:n
        suma=suma+wynik(t,pr);
    end
    xrec(i)=suma;
    i=i+1; 
end

figure;
plot(0:0.1:1,xrec,'g-x');




