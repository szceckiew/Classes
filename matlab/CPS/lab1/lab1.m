clear all; close all;

T=0.1; %czas trwania sinusoidy
A=230; %amplituda sinusoidy
f=50; %częstotliwość sinusoidy

%częstotliwości próbkowania
fs1=10000;

N=fs1*T; %liczba próbek
dt=1/fs1; %okres próbkowania

n=0:N; %numery próbek
t=dt*n; %chwile próbek

%sygnał
x1=A*sin(2*pi*f*t);

plot(t,x1,'b-');
hold on;

%fs2
fs2=500;
[x2,t2]=lab1_1_pomsin(T,fs2,f,A);

plot(t2,x2,'r-o');

% fs3
fs3=200;
[x3,t3]=lab1_1_pomsin(T,fs3,f,A);

plot(t3,x3,'k-x');
hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%B
%1
Tb=1;
f=50;
fsb1=10000;
[xb1,tb1]=lab1_1_pomsin(Tb,fsb1,f,A);

figure;
plot(tb1,xb1,'b-');
hold on;
%2
fsb2=51;
[xb2,tb2]=lab1_1_pomsin(Tb,fsb2,f,A);

plot(tb2,xb2,'g-o');
%3
fsb3=50;
[xb3,tb3]=lab1_1_pomsin(Tb,fsb3,f,A);

plot(tb3,xb3,'r-o');
%4
fsb4=49;
[xb4,tb4]=lab1_1_pomsin(Tb,fsb4,f,A);

plot(tb4,xb4,'k-o');
hold off;

%%%%
%B2
Tb=1;
f=50;
fsb1=10000;
[xb1,tb1]=lab1_1_pomsin(Tb,fsb1,f,A);

figure;
plot(tb1,xb1,'b-');
hold on;
%2
fsb2=26;
[xb2,tb2]=lab1_1_pomsin(Tb,fsb2,f,A);

plot(tb2,xb2,'g-o');
%3
fsb3=25;
[xb3,tb3]=lab1_1_pomsin(Tb,fsb3,f,A);

plot(tb3,xb3,'r-o');
%4
fsb4=24;
[xb4,tb4]=lab1_1_pomsin(Tb,fsb4,f,A);

plot(tb4,xb4,'k-o');
hold off;

%%%%%%%%%%%%%%%%%%%
%C
Tc=1;
fsc=100;
cc=zeros(102,61);
for fc=0:5:300
    [xc,tc]=lab1_1_pomsin(Tc,fsc,fc,A);
    cc(1,(fc/5)+1)=fc;
    cc(2:102,(fc/5)+1)=xc;
    %fc/5+1
    %fc
end
figure;
for i=1:61
    plot(tc,cc(2:102,i),'b-'); title(sprintf('iteration %d, freq %d ',i,cc(1,i)))
    pause(0.2);
end

figure;
plot(tc,cc(2:102,2),'b-');      %5
hold on
plot(tc,cc(2:102,22),'g-o');    %105
plot(tc,cc(2:102,42),'r-x');    %205
hold off;

figure;
plot(tc,cc(2:102,20),'b-');     %95
hold on;
plot(tc,cc(2:102,40),'g-o');    %195
plot(tc,cc(2:102,60),'r-x');    %295
hold off;

figure;
plot(tc,cc(2:102,20),'b-x');     %95
hold on;
plot(tc,cc(2:102,22),'g-o');    %105
hold off;

%C cos
Tc=1;
fsc=100;
cc=zeros(102,61);
for fc=0:5:300
    [xc,tc]=lab1_1_pomcos(Tc,fsc,fc,A);
    cc(1,(fc/5)+1)=fc;
    cc(2:102,(fc/5)+1)=xc;
    %fc/5+1
    %fc
end
figure;
for i=1:61
    plot(tc,cc(2:102,i),'b-'); title(sprintf('iteration %d, freq %d ',i,cc(1,i)))
    pause(0.2);
end

figure;
plot(tc,cc(2:102,2),'b-');      %5
hold on
plot(tc,cc(2:102,22),'g-o');    %105
plot(tc,cc(2:102,42),'r-x');    %205
hold off;

figure;
plot(tc,cc(2:102,20),'b-');     %95
hold on;
plot(tc,cc(2:102,40),'g-o');    %195
plot(tc,cc(2:102,60),'r-x');    %295
hold off;

figure;
plot(tc,cc(2:102,20),'b-x');     %95
hold on;
plot(tc,cc(2:102,22),'g-o');    %105
hold off;
% 
% %test1
% [xc,tc]=lab1_1_pomsin(Tc,fsc,5,A);
% figure;
% plot(tc,xc,'k-o');
% 
% figure;
% [xc,tc]=lab1_1_pomsin(Tc,fsc,105,A);
% plot(tc,xc,'r-o');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%D


