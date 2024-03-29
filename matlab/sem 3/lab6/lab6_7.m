%Interpolacja Czebyszewa jest mniej wrażliwa na błędy zaokrągleń od  interpolacji z użyciem wzoru Lagrange'a.
clear all; close all;

x = linspace(-1,1); %100 wektorów wierszowych rozmieszczonych pomiędzy punktami -1 i 1

%zbior funkcji bazowych
C3 = 4*x.^3 - 3*x;
C4 = 8*x.^4 - 8*x.^2 + 1;
C2 = 2*x.*C3 - C4;
C1 = 2*x.*C2 - C3;
C0 = 2*x.*C1 - C2;
C5 = 2*x.*C4 - C3;
C6 = 2*x.*C5 - C4;
C7 = 2*x.*C6 - C5;
C8 = 2*x.*C7 - C6;
C9 = 2*x.*C8 - C7;
C10 = 2*x.*C9 - C8;

figure(7)
plot(x,C0,'Color','r'); hold on;
plot(x,C1,'Color','r'); 
plot(x,C2,'Color','b');
plot(x,C3,'Color','g');
plot(x,C4,'Color','c');
plot(x,C5,'Color','m');
plot(x,C6,'Color','y');
plot(x,C7,'Color','k'); hold off

figure(8)
plot(x,C0,'Color','r'); hold on;
plot(x,C1,'Color','r'); 
plot(x,C2,'Color','b');
plot(x,C3,'Color','g');
plot(x,C4,'Color','c');
plot(x,C5,'Color','m');
plot(x,C6,'Color','y');
plot(x,C7,'Color',[0.8500 0.3250 0.0980]); 
plot(x,C8,'Color',[0.9290 0.6940 0.1250]); 
plot(x,C9,'Color',[0.4940 0.1840 0.5560]); 
plot(x,C10,'Color',[0.6350 0.0780 0.1840]); hold off;