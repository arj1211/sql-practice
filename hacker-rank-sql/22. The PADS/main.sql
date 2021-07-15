select CONCAT(Name, '(', LEFT(Occupation, 1), ')') from OCCUPATIONS order by Name;

select CONCAT('There are a total of ', STR(COUNT(*)), ' ', LOWER(Occupation), 's.') from OCCUPATIONS group by Occupation order by COUNT(*);