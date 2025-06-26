use airportdb;

alter table flight
add column last_updated datetime default '2025-01-01 00:00:00',
add column created_at datetime default '2025-01-01 00:00:00';

delimiter //
create trigger update_flight
before update on flight
for each row
begin
	set new.last_updated = now();
end;
//
delimiter ;

alter table airport
add column last_updated datetime default '2025-01-01 00:00:00',
add column created_at datetime default '2025-01-01 00:00:00';

delimiter //
create trigger update_airport
before update on airport
for each row
begin
	set new.last_updated = now();
end;
//
delimiter ;

alter table airport_geo
add column last_updated datetime default '2025-01-01 00:00:00',
add column created_at datetime default '2025-01-01 00:00:00';

delimiter //
create trigger update_airport_geo
before update on airport_geo
for each row
begin
	set new.last_updated = now();
end;
//
delimiter ;

alter table booking
add column last_updated datetime default '2025-01-01 00:00:00',
add column created_at datetime default '2025-01-01 00:00:00';

delimiter //
create trigger update_booking
before update on booking
for each row
begin
	set new.last_updated = now();
end;
//
delimiter ;

alter table passenger
add column last_updated datetime default '2025-01-01 00:00:00',
add column created_at datetime default '2025-01-01 00:00:00';

delimiter //
create trigger update_passenger
before update on passenger
for each row
begin
	set new.last_updated = now();
end;
//
delimiter ;

alter table airline
add column last_updated datetime default '2025-01-01 00:00:00',
add column created_at datetime default '2025-01-01 00:00:00';

delimiter //
create trigger update_airline
before update on airline
for each row
begin
	set new.last_updated = now();
end;
//
delimiter ;

alter table flightschedule
add column last_updated datetime default '2025-01-01 00:00:00',
add column created_at datetime default '2025-01-01 00:00:00';

delimiter //
create trigger update_schedule
before update on flightschedule
for each row
begin
	set new.last_updated = now();
end;
//
delimiter ;