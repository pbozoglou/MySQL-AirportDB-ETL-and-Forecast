use airport_dwh;

insert into dim_passengers (
	passenger_id,
    passportno,
    firstname,
    lastname,
    last_updated
)
select 
    t1.passenger_id,
    t1.passportno,
    t1.firstname,
    t1.lastname,
    t1.last_updated
from airportdb.passenger t1;