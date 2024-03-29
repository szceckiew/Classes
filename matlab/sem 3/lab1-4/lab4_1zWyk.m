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


%function [x,L,U] = fun(A,~)
[N,N] = size(A);
if(0) % prosciej, wolniej -----------------------------------------
    L = eye(N);
    U = zeros(N,N);
    for i = 1:N
        for j=i:N
            U(i,j) = A(i,j) - L(i,1:i-1)*U(1:i-1,j);
        end
        for j=i+1:N
            L(j,i) = 1/U(i,i) * ( A(j,i) - L(j,1:i-1)*U(1:i-1,i) );
        end
    end
else % trudniej, szybciej ----------------------------------------
    U=A; L=eye(N);
    for i=1:N-1
        for j=i+1:N
            L(j,i) = U(j,i) / U(i,i);
            U(j,i:N) = U(j,i:N) - L(j,i)*U(i,i:N);
        end
    end
end

C=L*U;
