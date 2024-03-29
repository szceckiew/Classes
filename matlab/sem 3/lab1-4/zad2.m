a=input("Podaj a: ");
b=input("Podaj b: ");
c=input("Podaj c: ");

abc=[a b c];

roots(abc)

p1=(-b-((b^2)-(4*a*c))^(1/2))/(2*a);
p2=(-b+((b^2)-(4*a*c))^(1/2))/(2*a);

abc2=[p1,p2]