use airport_dwh;

insert into dim_flights (
    flight_id,
    flightno,
    from_airport_id,
    to_airport_id,
    departure,
    arrival,
    airline_id,
    last_updated
)
select
    flight_id,
    flightno,
    `from`,
    `to`,
    departure,
    arrival,
    airline_id,
    last_updated
from airportdb.flight t1
where t1.from in (select airport_id from dim_airports) and (t1.last_updated > now() - interval 7 day)
on duplicate key update
    flight_id = t1.flight_id,
    flightno = t1.flightno,
    from_airport_id = t1.from,
    to_airport_id = t1.to,
    departure = t1.departure,
    arrival = t1.arrival,
    airline_id = t1.airline_id,
    last_updated = t1.last_updated;