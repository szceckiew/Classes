% interp_lagrange.m
clear all; close all;;
x = [-3, -1, 1, 3]; y = [1, 1, 1, 1]; % zadane punkty = wezly
xi = [-4: 0.05 : 4]; % gdzie obliczyc nowe wartosci funkcji
[yi,a] = funTZ_lagrange(x,y,xi); % nasza funkcja interpolujaca
yii = polyval(a,xi); % oblicz wartosci wielomianu "a" w punktach "xi"
a, % obliczone wsp. wielomianu: aN,...,a1,a0
figure; plot(x,y,'ro',xi,yi,'b-',xi,yii,''); title('y=f(x)'); % rysunek


function [yi,a] = funTZ_lagrange(xk,yk,xi)
Nk=length(xk); % liczba wartosci wejsciowych
Ni=length(xi); % liczba wartosci wyjsciowych (interpolowanych)
% Oblicz wspolczynniki wielomianu a
a=zeros(1,Nk);
for k = 1:Nk
    if(k==1) dxk(1) = prod( xk(1)-xk(2:Nk) ); proots = xk(2:Nk);
    elseif(k==Nk) dxk(Nk) = prod( xk(Nk)-xk(1:Nk-1) ); proots = xk(1:Nk-1);
else dxk(k) = prod( xk(k)-[xk(1:k-1) xk(k+1:Nk)] ); proots = [xk(1:k-1) xk(k+1:Nk)];
end
Lk = poly(proots)/dxk(k), % kolejny wielomian Lagrange'a
a = a + yk(k) * Lk; % suma wielomianow Lagrange'a
end
% Oblicz interpolowane wartosci funkcji w punktach xi jako sume wielomianow Lagrange'a
for i=1:Ni
yi(i)=0;
for k=1:Nk
if(k==1) dxi = xi(i)-xk(2:Nk);
elseif(k==Nk) dxi = xi(i)-xk(1:Nk-1);
else dxi = xi(i)-[xk(1:k-1) xk(k+1:Nk)];
end
yi(i) = yi(i) + yk(k) * prod(dxi)/dxk(k) ; % suma wartosci wielomianow Lagrange'
a
end
end
% Pokaz krzywe uzytych wielomianow Lagrange'a w tym przypadku
if(1)
figure
for k=1:Nk
for i=1:Ni
if(k==1) dxi = xi(i)-xk(2:Nk);
elseif(k==Nk) dxi = xi(i)-xk(1:Nk-1);
else dxi = xi(i)-[xk(1:k-1) xk(k+1:Nk)];
end
yL(i) = yk(k) * prod(dxi)/dxk(k) ; % kolejny wielomian Lagrange'a
end
plot(xk,yk,'ko',xk,zeros(1,Nk),'ko',xi,yL); hold on;
end
xlabel('x'); ylabel('y'); title('y=f(x)'); grid; pause
end
end