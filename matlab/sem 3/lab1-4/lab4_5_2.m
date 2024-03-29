clear all;
close all;
A = [1 21 3; ...
    4 51 6;
    7 8 9];
    
disp(det(A));
A1 = lab4_5odrz3(A),
if A1 == 0
   disp(" ");
else
   disp(det(A1));
   A2 = lab4_5odrz3(A1),
   if A2 == 0
       disp(" ")
   else
       if A2 == A
           disp("A2==A")
       end
   end
end
err = max(abs(A - A2)),
