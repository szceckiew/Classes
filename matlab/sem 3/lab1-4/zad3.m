%promień r
%wysokość h
%objętość - V
%pole pow - S

S=input("Podaj S: ");


wyr=[-3*pi 0 S/2];
root=roots(wyr);
r=max(root);
h=S/(2*pi*r) - r;
wymiary=[r h];
V=pi*r^2*h;

sprawdzenie=2*pi*r^2 + 2*pi*r*h;

r=0.7284;
V=pi*r^2*h;