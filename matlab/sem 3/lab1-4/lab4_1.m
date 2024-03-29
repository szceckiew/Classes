function [L,U] = myLu(A, choice)
[N,N] = size(A);
if(choice == 0) % prosciej, wolniej -----------------------------------------
    L = eye(N); U = zeros(N,N);
    for i = 1:N
        for j=i:N
            U(i,j) = A(i,j) - L(i,1:i-1)*U(1:i-1,j);
        end
        for j=i+1:N
            L(j,i) = 1/U(i,i) * ( A(j,i) - L(j,1:i-1)*U(1:i-1,i) );
        end
    end
elseif(choice==1) %moja implementacja
    L = eye(N); U = zeros(N,N);
    for i = 1:N
        for j=1:i-1
            L(i,j) = 1/U(j,j) * ( A(i,j) - L(i,1:j-1)*U(1:j-1,j) );
        end
        for j=i:N
            U(i,j) = A(i,j) - L(i,1:i-1)*U(1:i-1,j);
        end
    end
else % trudniej, szybciej ----------------------------- -----------
U=A; L=eye(N);
    for i=1:N-1
        for j=i+1:N
            L(j,i) = U(j,i) / U(i,i);
            U(j,i:N) = U(j,i:N) - L(j,i)*U(i,i:N);
        end
    end
end

if(choice==2) %dekompozycja Choleskiego
   L = eye(N);
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
end

