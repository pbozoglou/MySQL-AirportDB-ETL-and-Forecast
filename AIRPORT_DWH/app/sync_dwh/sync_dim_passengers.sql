use airport_dwh;

insert into dim_passengers (
	passenger_id,
    passportno,
    firstname,
    lastname,
    last_updated
)
select
    passenger_id,
    passportno,
    firstname,
    lastname,
    last_updated
from airportdb.passenger t1
where t1.last_updated > now() - interval 7 day
on duplicate key update
	passenger_id = t1.passenger_id,
    passportno = t1.passportno,
    firstname = t1.firstname,
    lastname = t1.lastname,
    last_updated = t1.last_updated;