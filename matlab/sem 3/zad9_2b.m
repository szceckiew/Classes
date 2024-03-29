%inna funkcja - parabola -> y = ax^2 +bx+c
clear all; close all;
it = 24;
stopnie=80; %45/7/80 stopni
switch (stopnie)
    case 45
        x1 = -2; x2= -0.5;
        a=1; b=0; c=-1;
        xstart=-2;
        xstop=0;
        err=-1;
    case 7
        x1 = -3.5; x2= -1;
        a=1/10; b=0; c=-1/2;
        xstart=-3.5;
        xstop=0;
        err=-sqrt(5);
    case 80
        x1 = -0.5; x2= -0.1;
        a=10; b=0; c=-1;
        xstart=-0.5;
        xstop=0;
err=-sqrt(10)/10;
end



f = @(x) a*x.^(2)+b*x+c; % definicja funkcji
fp = @(x) 2*a*x+b; % definicja pochodnej funkcji

x = xstart : 0.01 : xstop;
plot( x, f(x), 'b-', x, fp(x),'r-'); grid; xlabel('x'); title('f(x), fp(x)');
legend('Funkcja','Jej pochodna'); pause

cb = nonlinsolvers( f, fp, x1, x2, 'bisection', it );
cr = nonlinsolvers( f, fp, x1, x2, 'regula-falsi', it);
cn = nonlinsolvers( f, fp, x1, x2, 'newton-raphson', it);

cb_err=cb-err;
cr_err=cr-err;
cn_err=cn-err;
plot( 1:it,cb,'o-', 1:it,cr,'*', 1:it,cn,'^-'); xlabel('iter'); title('c(iter)')
grid on, legend('Bisection','Regula-Falsi','Newton-Raphson');