clear all;
close all;

A=[1 2 3
   4 5 6 
   7 8 9];

B=lab4_5odrz(A),


function [U] = lab4_5odrz(A)
 N = size(A);
 Z = zeros(N(1),N(1));
 for i=1:N
    for j=1:N
       Matrix_dop = A;
       Matrix_dop(i,:) = [];
       Matrix_dop(:,j) = [];
       Z(i,j) = (-1)^(i+j) * det(Matrix_dop);
    end
  end
U = (1/(det(A))) * Z.';
end
