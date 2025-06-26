use airportdb;

insert into airport values (4040,'GRG','GRGT','TEST DATA',now(),now());
insert into airport_geo values (4040,'TEST DATA','ATHENS','GREECE',37.93666700,23.94444400, POINT(37.93666700, 23.94444400), now(),now());
insert into airline values (4040, 'GG', 'Athens Test Airline', 4040, now(),now());
insert into flightschedule values ('GR4949', 4040, 6627, '2015-09-01 15:00:00', '2015-09-01 17:00:00', 4040, 1, 1, 1, 1, 1, 1, 1, now(), now());
insert into flight values (1043212,'GR4949',4040,6627,'2015-09-01 15:00:00','2015-09-01 15:00:00',4040,870,now(),now());
insert into passenger values (404040, 'P404040','Bruce','Wayne', now(),now());
insert into booking values (99999999, 1043212, '24F', 404040, 150.10, now(),now());
update booking set seat = '26F' where booking_id = 7726857;