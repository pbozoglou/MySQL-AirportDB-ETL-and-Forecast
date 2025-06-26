use airportdb;

alter table flight
drop column last_updated,
drop column created_at;
drop trigger update_flight;

alter table airport
drop column last_updated,
drop column created_at;
drop trigger update_airport;

alter table airport_geo
drop column last_updated,
drop column created_at;
drop trigger update_airport_geo;

alter table booking
drop column last_updated,
drop column created_at;
drop trigger update_booking;

alter table passenger
drop column last_updated,
drop column created_at;
drop trigger update_passenger;

alter table airline
drop column last_updated,
drop column created_at;
drop trigger update_airline;

alter table flightschedule
drop column last_updated,
drop column created_at;
drop trigger update_schedule;