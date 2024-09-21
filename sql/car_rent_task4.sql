-- úloha č.4 --
create database car_rent;
use car_rent;

create table cars (car_id int PRIMARY KEY,
producer varchar(100),
model varchar(100),
year year,
horse_power int,
price_per_day int);

create table clients (client_id int PRIMARY KEY,
name varchar(10),
surname varchar(10),
address varchar(20),
city varchar(20));

create table bookings (booking_id int PRIMARY KEY, 
client_id int,
car_id int,
start_date date,
end_date date,
total_amount float);

alter table cars modify column car_id integer auto_increment;
alter table clients modify column client_id integer auto_increment;
alter table bookings modify column booking_id integer auto_increment;

alter table bookings add constraint client_id_fk foreign key (client_id) references clients (client_id),
add constraint car_id_fk foreign key (car_id) references cars (car_id);

INSERT INTO clients (name, surname, address, city) VALUES
('Michal', 'Taki', 'os. Srodkowe 12', 'Poznan'),
('Pawel', 'Ktory', 'ul. Stara 11', 'Gdynia'),
('Anna', 'Inna', 'os. Srednie 1', 'Gniezno'),
('Alicja', 'Panna', 'os. Duze 33', 'Torun'),
('Damian', 'Papa', 'ul. Skosna 66', 'Warszawa'),
('Marek', 'Troska', 'os. Male 90', 'Radom'),
('Jakub', 'Klos', 'os. Polskie 19', 'Wadowice'),
('Lukasz', 'Lis', 'os. Podlaskie 90', 'Bialystok');

INSERT INTO cars (producer, model, year, horse_power, price_per_day) VALUES
('Mercedes', 'CLK', 2018, 190, 400),
('Hyundai', 'Coupe', 2014, 165, 300),
('Dacia', 'Logan', 2015, 103, 150),
('Saab', '95', 2012, 140, 140),
('BMW', 'E36', 2007, 110, 80),
('Fiat', 'Panda', 2016, 77, 190),
('Honda', 'Civic', 2019, 130, 360),
('Volvo', 'XC70', 2013, 180, 280);

INSERT INTO bookings (client_id, car_id, start_date,
end_date, total_amount) VALUES
(3, 3, '2020-07-06', '2020-07-08', 400),
(6, 3, '2020-07-10', '2020-07-16', 1680),
(4, 5, '2020-07-11', '2020-07-14', 450),
(5, 4, '2020-07-11', '2020-07-13', 600),
(7, 3, '2020-07-12', '2020-07-14', 800),
(5, 7, '2020-07-14', '2020-07-17', 240),
(3, 8, '2020-07-14', '2020-07-16', 380),
(5, 7, '2020-07-15', '2020-07-18', 1080),
(6, 5, '2020-07-16', '2020-07-20', 1120),
(8, 1, '2020-07-16', '2020-07-19', 600),
(7, 2, '2020-07-16', '2020-07-21', 500),
(4, 6, '2020-07-17', '2020-07-19', 280),
(1, 8, '2020-07-17', '2020-07-19', 720),
(3, 7, '2020-07-18', '2020-07-21', 240),
(5, 4, '2020-07-18', '2020-07-22', 1200);

select * from clients;
select * from cars;
select * from bookings;

select * from cars where year > 2015;
select * from bookings where total_amount between 1000 and 2555;
select client_id from clients where surname like 'N%' and name like '%ew'