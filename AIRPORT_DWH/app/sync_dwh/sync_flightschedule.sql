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
where t2.country in ("greece","cyprus") and (t1.last_updated > now() - interval 7 day)
on duplicate key update
    flightno = t1.flightno,
    airport_key = t2.airport_key,
	airport_id = t1.from,
    monday = t1.monday,
    tuesday = t1.tuesday,
    wednesday = t1.wednesday,
    thursday = t1.thursday,
    friday = t1.friday,
    saturday = t1.saturday,
    sunday = t1.sunday,
    last_updated = t1.last_updated;