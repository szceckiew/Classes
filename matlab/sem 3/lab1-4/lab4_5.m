clear all;
close all;

A = [1 2; ...
    3 4],
A_odwr = lab4_4_odrz2(A),
if A_odwr == 0
   disp("Błąd")
else
   A_odwr2 = lab4_4_odrz2(A_odwr),
   if(A == A_odwr2)
       disp("A==A_odrw2");
   end
end


