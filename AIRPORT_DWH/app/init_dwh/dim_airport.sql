use airport_dwh;

insert into dim_airports (
	airport_id,
    name,
    city,
    country,
    latitude,
    longitude,
    last_updated
)
select 
	t1.airport_id, 
	t1.name, 
    t1.city, 
    t1.country, 
    t1.latitude, 
    t1.longitude, 
    t1.last_updated 
from airportdb.airport_geo t1
where t1.country IN ('CYPRUS','GREECE');