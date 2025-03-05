--CREATE DATABASE Lesson3_homework

Create database Lesson3_homework

--create table passengers
create table passengers (
    id BIGINT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    country_of_citizenship VARCHAR(50),
    country_of_residence VARCHAR(50),
    passport_number VARCHAR(20),
    created_at DATETIME2,
    updated_at DATETIME2
);
SELECT*FROM passengers

--CREATE TABLE no_fly_list
CREATE TABLE no_fly_list (
    id BIGINT PRIMARY KEY,
    active_from DATE,
    active_to DATE,
    no_fly_reason VARCHAR(255),
    created_at DATETIME2,
    updated_at DATETIME2,
    psngr_id BIGINT REFERENCES passengers(id)
);
SELECT*FROM no_fly_list

--CREATE TABLE booking
CREATE TABLE booking (
    bookingid BIGINT PRIMARY KEY,
    flight_id BIGINT,
    status VARCHAR(20),
    booking_platform VARCHAR(20),
    created_at DATETIME2,
    updated_at DATETIME2,
    passenger_id BIGINT REFERENCES passengers(id)
);
SELECT*FROM booking

--CREATE TABLE baggage
CREATE TABLE baggage (
    id BIGINT PRIMARY KEY,
    weight_in_kg DECIMAL(4,2),
    created_date DATETIME2,
    updated_date DATETIME2,
    booking_id BIGINT REFERENCES booking(bookingid)
);
SELECT*FROM baggage

--CREATE TABLE baggage_check
CREATE TABLE baggage_check (
    id BIGINT PRIMARY KEY,
    check_result VARCHAR(50),
    created_at DATETIME2,
    updated_at DATETIME2,
    booking_id BIGINT REFERENCES booking(bookingid),
    passenger_id BIGINT REFERENCES passengers(id)
);
SELECT*FROM baggage_check

--CREATE TABLE security_check
CREATE TABLE security_check (
    id BIGINT PRIMARY KEY,
    check_result VARCHAR(20),
    comments VARCHAR(8000),
    created_at DATETIME2,
    updated_at DATETIME2,
    passenger_id BIGINT REFERENCES passengers(id)
);
SELECT*FROM baggage_check

--CREATE TABLE airport
CREATE TABLE airport (
    id BIGINT PRIMARY KEY,
    airport_name VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    created_at DATETIME2,
    updated_at DATETIME2
);
SELECT*FROM airport

--CREATE TABLE airline
CREATE TABLE airline (
    id BIGINT PRIMARY KEY,
    airline_code VARCHAR(50),
    airline_name VARCHAR(50),
    airline_country VARCHAR(50),
    created_at DATETIME2,
    updated_at DATETIME2
);
SELECT*FROM airline

--CREATE TABLE boarding_pass
CREATE TABLE boarding_pass (
    id BIGINT PRIMARY KEY,
    qr_code VARCHAR(8000),
    created_at DATETIME2,
    updated_at DATETIME2,
    booking_id BIGINT REFERENCES booking(bookingid)
);
SELECT*FROM boarding_pass

--CREATE TABLE flights
CREATE TABLE flights (
    flight_id BIGINT PRIMARY KEY,
    departing_gate VARCHAR(20),
    arriving_gate VARCHAR(20),
    created_at DATETIME2,
    airline_id BIGINT,
    departing_airport_id BIGINT REFERENCES airport(id),
    arriving_airport_id BIGINT REFERENCES airport(id)
);
SELECT*FROM flights

--CREATE TABLE flight_manifest
CREATE TABLE flight_manifest (
    id BIGINT PRIMARY KEY,
    created_at DATETIME2,
    updated_at DATETIME2,
    booking_id BIGINT REFERENCES booking(bookingid),
    flight_id BIGINT REFERENCES flights(flight_id)
);
SELECT*FROM flight_manifest