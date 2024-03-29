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
L=eye(N);
U=zeros(N,N);

for i=1:N
    for j=1:i-1
        L(i,j)=(1/U(j,j))*(A(i,j)-L(i,1:j-1)*U(1:j-1,j));
    end
    for j=i:N
        U(i,j)=A(i,j)-L(i,1:i-1)*U(1:i-1,j);
    end
end

A2=L*U;
