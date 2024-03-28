function [x,t]=lab1_1_pomsin(T,fs,f,A)
N=fs*T; %liczba próbek
dt=1/fs; %okres próbkowania

n=0:N; %numery próbek
t=dt*n; %chwile próbek

%sygnał
x=A*sin(2*pi*f*t);
end