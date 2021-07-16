select N, 
case 
when P is null then 'Root'
when N in (select N from(select N, case when N in (select P from BST) then 'T' else 'F' end as NIN from BST) as T where T.NIN='F') then 'Leaf'
else 'Inner'
end
from BST
order by N;