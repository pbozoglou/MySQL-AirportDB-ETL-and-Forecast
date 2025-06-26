insert into airport_dwh.dim_flightschedule
select
	t1.flightno,
    t2.airport_key,
	t1.from,
    t1.monday,
    t1.tuesday,
    t1.wednesday,
    t1.thursday,
    t1.friday,
    t1.saturday,
    t1.sunday,
    t1.last_updated
from airportdb.flightschedule t1
join airport_dwh.dim_airports t2 on t1.from = t2.airport_id
where t2.country in ("GREECE","CYPRUS");