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
where t1.from in (select airport_id from dim_airports);