select 
    case 
        when ((A+B<=C) or (A+C<=B) or (B+C<=A)) then 'Not A Triangle'
        when (A<>B and B<>C and A<>C) then 'Scalene'
        when ((A=B and B<>C) or (A=C and C<>B) or (B=C and C<>A)) then 'Isosceles'
        when (A=B and B=C) then 'Equilateral'
    end 
from TRIANGLES;