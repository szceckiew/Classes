clear all; close all;
A=[ 2 -4 10
    0 4 8
    0 0 -2];

B=[  4
    16
    -2];
liczbakol=3;
liczbawierszy=3;

X=zeros(1,3);

for kol=liczbakol:-1:1
    S=0;
    for i=kol+1:liczbakol
        S=S+A(kol,i)*X(1,i);
    end
    %zm=(B(kol,1)-S);
    %zm2=A(kol,kol);
    X(1,kol)=(B(kol,1)-S)/A(kol,kol);

 end