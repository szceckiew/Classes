clear all;
close all;

N=3;
A=[16 -8 -4
    -8 29 12
    -4 12 41
    ];
L=eye(N);

for j=1:N
    value=0;
    for k=1:j-1
        value = value + L(j,k)*L(j,k);
    end
    L(j,j) = sqrt(A(j,j) - value);
    for i=j+1:N
        value = 0;
        for k=1:j-1
            value = value + L(i,k)*L(j,k);
        end
        L(i,j) = (1/L(j,j)) * (A(i,j) - value);
    end
end
U = L.';


[C]=chol(A);