(select * from (select min(CITY), LEN from (select CITY, length(CITY) as LEN from STATION order by length(CITY), CITY) group by LEN order by LEN) where rownum<=1)
union all
(select * from (select min(CITY), LEN from (select CITY, length(CITY) as LEN from STATION order by length(CITY), CITY) group by LEN order by LEN desc) where rownum<=1);