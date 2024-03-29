%a) jakość wyniku należy odczytać z wykresu
% equnonlin_solve.m
clear all; close all;
it = 24;
%b) it 17 -> dokładność do 0.001% odczytane z cb
a = pi-pi/5; b=pi+pi/5; % znajdz zero funkcji y=sin(x) dla x=pi
f = @(x) sin(x); % definicja funkcji
fp = @(x) cos(x); % definicja pochodnej funkcji

x = 0 : 0.01 : 2*pi;
plot( x, f(x), 'b-', x, fp(x),'r-'); grid; xlabel('x'); title('f(x), fp(x)');
legend('Funkcja','Jej pochodna'); pause

cb = nonlinsolvers( f, fp, a, b, 'bisection', it );
cr = nonlinsolvers( f, fp, a, b, 'regula-falsi', it);
cn = nonlinsolvers( f, fp, a, b, 'newton-raphson', it);

cb_err=cb-pi;
cr_err=cr-pi;
cn_err=cn-pi;
plot( 1:it,cb,'o-', 1:it,cr,'*', 1:it,cn,'^-'); xlabel('iter'); title('c(iter)')
grid on, legend('Bisection','Regula-Falsi','Newton-Raphson');

