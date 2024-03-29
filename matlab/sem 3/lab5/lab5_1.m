clear all;
x1=-1;
y1=1;
x2=3;
y2=3;


wynik1 = f55(y1, x1, y2, x2); 
odp1=wynik1(1);
wynik2 = f56(y1, x1, y2, x2); 
odp2=wynik2(1);
wynik3 = f57(y1, x1, y2, x2); 
odp3=wynik3(1);
function [y] = f55(y1, x1, y2, x2)
   y = @(x)( (y2-y1)/(x2-x1)*x + (x2*y1 - x1*y2)/(x2 - x1));
end
function [y] = f56(y1, x1, y2, x2)
   y = @(x)( y1 + (y2 - y1)/(x2 - x1)*(x - x1) );
end
function [y] = f57(y1, x1, y2, x2)
   y = @(x)( (x - x2)/(x1 - x2)*y1 + (x - x1)/(x2 - x1)*y2 );
end

function [y] = fNewst2(y1,x1,y2,x2,y3,x3)
    y = @(x)( y1 + (y2 - y1)/(x2 - x1)*(x - x1) );
end

