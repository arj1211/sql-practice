select cast(abs(min(lat_n) - max(lat_n)) + abs(min(long_w) - max(long_w)) as numeric(10,4)) from station;