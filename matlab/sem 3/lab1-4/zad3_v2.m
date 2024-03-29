S=input("Podaj S: ");
Ep=input("Podaj dokładność: ");

k=(5^(1/2)-1)/2;

%V(r)= -PI*r^3+S/2*r
wyr=[-pi 0 S/2 0];
root=roots(wyr);
b=max(root);
a=min(root);

xL = b - k * ( b - a );
xR = a + k * ( b - a );

while (b-a) > Ep
    if zad3_v2_func1(xL,S) > zad3_v2_func1(xR,S)
        b = xR;
        xR = xL;
        xL = b - k * ( b - a );
    else
        a = xL;
        xL = xR;
        xR = a + k * ( b - a );
    end
end

odp= (a+b)/2