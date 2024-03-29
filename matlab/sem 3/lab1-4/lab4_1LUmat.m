clear all;
close all;

N=3;
A=zeros(N,N);
licznik=1;
for i=1:N
    for j=1:N
        A(i,j)=licznik;
        licznik=licznik+1;
    end
end

[L,U]=lu(A);

C=L*U;