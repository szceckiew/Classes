function C=metSiecz(f, fp, a, b, iter)
C = zeros(1,iter); % kolejne oszacowania miejsca zerowego
c = b-((feval(f,b)*(b-a))/(feval(f,b)-feval(f,a))); % pierwsze oszacowanie
for i = 1 : iter
    fa = feval(f,a); fb=feval(f,b); fc=feval(f,c); fpc=feval(fp,c); % oblicz
    
    

    C(i)=c; % zapamietaj
end