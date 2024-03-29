clear all;
close all;

f=20;
probe_f=192000;
init=0;

omega=2*pi*f/probe_f;
a=2*cos(omega);

iteration_count=45000;

y=[sin(omega+init),sin(2*omega+init)];
x=zeros(1,iteration_count);
x(2)=omega;

for i=3:iteration_count
    y(i)=a*y(i-1)-y(i-2);
    x(i)=x(i-1) + omega;
end

plot(x,y);
