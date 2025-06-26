drop database if exists airport_dwh;

create database airport_dwh;

use airport_dwh;

create table dim_flights(
	flight_key int primary key auto_increment,
	flight_id int unique,
    flightno char(8),
    from_airport_id smallint,
    to_airport_id smallint,
    departure datetime,
    arrival datetime,
    airline_id smallint,
    last_updated datetime
);

create table dim_airports(
	airport_key int primary key auto_increment,
	airport_id smallint unique,
    name varchar(50),
    city varchar(50),
    country varchar(50),
    latitude decimal(11,8),
    longitude decimal(11,8),
    last_updated datetime
);

create table dim_date(
	date_key int primary key auto_increment,
    full_date date,
    day_of_week int,
    day_name varchar(20), 
    day_of_month int,
    day_of_year int,
    week_of_year int,
    month_name varchar(20),
    month_of_year int,
    quarter int,
    year year
);

create table dim_time(
	time_key int primary key auto_increment,
    hour24 time,
    hour12 time,
    hour tinyint,
    minute tinyint
);

create table dim_passengers(
	passenger_key int primary key auto_increment,
	passenger_id int unique,
    passportno char(9),
    firstname varchar(100),
    lastname varchar(100),
    last_updated datetime
);

create table dim_flightschedule(
	flightno char(8) primary key,
    airport_key int,
 	airport_id smallint,
    monday tinyint,
    tuesday tinyint,
    wednesday tinyint,
    thursday tinyint,
    friday tinyint,
    saturday tinyint,
    sunday tinyint,
    last_updated date,
    foreign key (airport_key) references dim_airports(airport_key)
);

create table fact_bookings(
	booking_id int primary key,
    flight_key int,
    passenger_key int,
    departure_airport_key int,
    date_key int,
    time_key int,
    price int,
    last_updated datetime,
    foreign key (flight_key) references dim_flights(flight_key),
    foreign key (passenger_key) references dim_passengers(passenger_key),
    foreign key (departure_airport_key) references dim_airports(airport_key),
    foreign key (date_key) references dim_date(date_key),
    foreign key (time_key) references dim_time(time_key)
);

create table fact_forecasts(
	forecast_key int primary key auto_increment,
    date_key int,
    airport_key int,
    day_of_month int,
    day_of_week int,
    scheduled_flights int,
    price_forecast int,
    foreign key (date_key) references dim_date(date_key),
    foreign key (airport_key) references dim_airports(airport_key)
);