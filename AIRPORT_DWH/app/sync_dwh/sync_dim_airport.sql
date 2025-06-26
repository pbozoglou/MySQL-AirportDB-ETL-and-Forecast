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
	airport_id, 
	name, 
    city, 
    country, 
    latitude, 
    longitude,
    last_updated
from airportdb.airport_geo t1
where t1.country in ('cyprus','greece') and t1.last_updated > now() - interval 7 day
on duplicate key update
    airport_id = t1.airport_id,
    name = t1.name,
    city = t1.city,
    country = t1.country,
    latitude = t1.latitude,
    longitude = t1.longitude,
    last_updated = t1.last_updated;