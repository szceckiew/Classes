x=[99 25 87 56 50 56 52
    1 2 3 4 5 6 7];


U = x(:, 2:end - 1) - x(:, 1:end - 2);

c = - pinv(U) * (x(:, end) - x(:, end - 1));
c(end + 1, 1) = 1;
s = (x(:, 2:end) * c) / sum(c);