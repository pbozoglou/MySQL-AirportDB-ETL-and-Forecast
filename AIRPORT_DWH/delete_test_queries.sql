use airportdb;

update booking set seat = '25K' where booking_id = 7726857;
delete from booking where booking.booking_id = 99999999;
delete from passenger where passenger.passenger_id = 404040;
delete from flight where flight.flight_id = 1043212;
delete from flightschedule where flightschedule.flightno = 'GR4949';
delete from airline where airline.airline_id = 4040;
delete from airport_geo where airport_geo.airport_id=4040;
delete from airport where airport.airport_id=4040;