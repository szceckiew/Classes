clear all;
close all;
N=4;
A=zeros(N,2);
B=zeros(N,1);

for i=1:N
    A(i,2)=1;
    A(i,1)=round(rand*100);
end

for i=1:N
    B(i,1)=round(rand*100);
end

wsp=inv(A'*A)*A'*B;

f = @(x) wsp(1,1)*x+wsp(2,1);
figure; fplot(f,[0 100]); grid;



