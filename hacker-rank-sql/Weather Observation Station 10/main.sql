select distinct CITY from STATION where RIGHT(LOWER(CITY),1) not in ('a','e','i','o','u');