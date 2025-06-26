use airport_dwh;

insert into fact_bookings
select 
    t1.booking_id, 
    t2.flight_key, 
    t3.passenger_key, 
    t4.airport_key, 
    t5.date_key, 
    t6.time_key,
    t1.price, 
    t1.last_updated
from airportdb.booking t1
join dim_flights t2 on t2.flight_id = t1.flight_id
left join dim_passengers t3 on t3.passenger_id = t1.passenger_id
left join dim_airports t4 on t4.airport_id = t2.from_airport_id
left join dim_date t5 on t5.full_date = date(t2.departure)
left join dim_time t6 on t6.hour24 = time(t2.departure)
where t2.from_airport_id in (select airport_id from dim_airports);