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
select client_id from clients where surname like 'N%' and name like '%ew';

-- Úloha č.5 --
-- 1. Vypište jména všech zákazníků, jejichž rezervace stála více než 1000. --
select clients.name, clients.surname, bookings.total_amount
from bookings
INNER join clients on
bookings.client_id=clients.client_id
where total_amount > 1000; 

-- 2. Vypište město bydliště všech zákazníků, kteří si pronajali auto v období 12-20.07.2020 
-- a výkon motoru pronajatého vozu nepřesahuje 120, výsledky seřaďte podle nejvyšších nákladů na pronájem. --
select clients.city, bookings.total_amount from clients 
join bookings on clients.client_id = bookings.client_id
join cars on bookings.car_id = cars.car_id
where bookings.start_date >= '2020-07-12'
and bookings.end_date <= '2020-07-20'
and cars.horse_power <= 120
order by bookings.total_amount DESC;

-- 3. * Uveďte počet vozů s denními náklady na pronájem 300 a více, seskupte vozy 
-- podle výkonu motoru a seřaďte od nejmenšího po největší.
select clients.city, bookings.start_date, bookings.end_date, cars.horse_power, bookings.total_amount
from bookings
LEFT JOIN clients ON
bookings.client_id=clients.client_id
LEFT JOIN cars ON
bookings.car_id=cars.car_id
where start_date >= '2020-07-12' and end_date <= '2020-07-20' and horse_power < 120
order by total_amount desc;

-- aleternatívne riešenie
select horse_power, count(car_id)
from cars
where price_per_day >= 300
group by horse_power
order by horse_power asc;

-- 4. * Uveďte celkové náklady na všechny rezervace provedené mezi 14. a 18. červencem 2020.
SELECT SUM(total_amount) AS total_cost
FROM bookings
WHERE start_date >= '2020-07-14' 
AND end_date <= '2020-07-18';

-- 5. * Vypište následující (vše v jednom dotazu):
-- a. průměrná částka utracená každým zákazníkem název sloupce: Average_reservations_price
-- b. počet pronajatých vozů pro každého zákazníka, přičemž se berou v úvahu pouze zákazníci, 
-- kteří si pronajali alespoň dva vozy • sloupec: Number of rented cars
-- c. jméno a příjmení zákazníka • sloupce: Name, Surname
-- Seřaďte podle největšího počtu zapůjčených aut.
select clients.name, clients.surname, 
avg(bookings.total_amount) as 'Average_reservations_price', 
count(bookings.car_id) as 'Number_of_rented_cars'
from bookings
left join clients on
bookings.client_id=clients.client_id
group by bookings.client_id
having Number_of_rented_cars > 1
order by Number_of_rented_cars desc;