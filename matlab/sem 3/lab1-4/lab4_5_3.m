clear all;
close all;

A = [1 2 3 4; ...
    3 4 6 8;
    9 10 2 12
    9 11 15 3];
N = size(A);
Z = zeros(N(1), N(1));
A1 = odwr_rek(A, N(1), N(1), N(1), Z);
N = size(A1);
A2 = odwr_rek(A1, N(1), N(1), N(1), Z),