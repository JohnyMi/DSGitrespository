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


-- CTE (Common table expressions) - a_names
-- Umožnuje dočasne uložiť vysledok dotazu a odkazovať naň v ďalšej časti
with a_names as(
select clients.name, clients.surname, bookings.total_amount
FROM bookings
INNER JOIN clients ON
bookings.client_id = clients.client_id
where name like 'A%' or surname like 'A%')
select avg(total_amount) from a_names; 

-- Extras --
-- 1. Vypíšte názvy všetkých áut, ktoré boli prenajaté aspoň na 5 dní.
-- Požadovaný výstup: názvy áut a počet dní prenájmu.
select cars.producer, cars.model, DATEDIFF(bookings.end_date, bookings.start_date) AS rental_days
FROM bookings
INNER JOIN cars ON
bookings.car_id = cars.car_id
where DATEDIFF(bookings.end_date, bookings.start_date) >= 5;

-- 2. Vypíšte všetky rezervácie, kde celková suma za prenájom prekročila 500 a auto bolo prenajaté na viac ako 3 dni.
-- Požadovaný výstup: ID rezervácie, meno zákazníka, model auta a celková suma.
select bookings.booking_id, clients.name, clients.surname, cars.model, total_amount, DATEDIFF(bookings.end_date, bookings.start_date) AS rental_days
FROM bookings
INNER JOIN clients ON
bookings.client_id = clients.client_id
INNER JOIN cars ON 
bookings.car_id = cars.car_id
where total_amount > 500 and DATEDIFF(bookings.end_date, bookings.start_date) > 3;

-- 3. Vypíšte najdrahšie auto, ktoré si zákazník prenajal medzi 1. a 15. júlom 2020.
-- Požadovaný výstup: názov auta, meno zákazníka, cena za prenájom.
with max_amount as(
select cars.producer, cars.model, clients.name,clients.surname, total_amount
FROM bookings
INNER JOIN clients ON
bookings.client_id = clients.client_id
INNER JOIN cars ON
bookings.car_id = cars.car_id
where start_date >= '2020-07-01'
and end_date <= '2020-07-15')
select producer, model, name, surname, total_amount 
from max_amount
WHERE total_amount = (SELECT MAX(total_amount) FROM max_amount); 

-- 4. Vypíšte počet zákazníkov, ktorí si prenajali auto s výkonom motora vyšším ako 150 koní, 
-- a celkovú sumu, ktorú za prenájom zaplatili.
-- Požadovaný výstup: počet zákazníkov, celková suma.
WITH clients_count AS (
    SELECT clients.client_id, clients.name, clients.surname, bookings.total_amount, cars.horse_power
    FROM bookings
    INNER JOIN clients ON bookings.client_id = clients.client_id
    INNER JOIN cars ON bookings.car_id = cars.car_id
    WHERE cars.horse_power > 150)
SELECT COUNT(DISTINCT client_id) AS 'Number of clients', SUM(total_amount) AS 'Total amount'
FROM clients_count;

-- 5. Vypíšte názvy miest, v ktorých žijú zákazníci, ktorí si prenajali auto viac ako dvakrát, 
-- a usporiadajte tieto mestá podľa počtu zákazníkov, ktorí si auto prenajali.
-- Požadovaný výstup: názvy miest a počet zákazníkov z daného mesta
 with rental_counts as(
 select clients.client_id, clients.city, count(bookings.booking_id) as rental_times  
  FROM bookings
 INNER JOIN clients ON
 bookings.client_id=clients.client_id
 group by clients.client_id, clients.city
 having rental_times >2)
 select city, count(client_id) as 'Number_of_clients'
 from rental_counts
 group by city
 order by Number_of_clients desc;
 
-- 6. Zistite, ktoré auto bolo prenajaté najčastejšie, a uveďte koľkokrát bolo prenajaté.
-- Požadovaný výstup: názov auta, počet prenájmov.
WITH top_rented_car as(
select cars.car_id, cars.producer, cars.model, count(bookings.booking_id) as rental_count
FROM bookings
INNER JOIN cars ON
bookings.car_id=cars.car_id
group by cars.car_id, cars.producer, cars.model)
select producer, model, rental_count as 'Number_of_bookings'
from top_rented_car
order by rental_count desc;

-- 7. Vypíšte zákazníkov, ktorí si prenajali auto s výkonom nad 150 koní a zaplatili za prenájom viac ako 500.
-- Požadovaný výstup: meno, priezvisko zákazníka, model auta a suma.
select clients.name, clients.surname, cars.producer, cars.model, cars.horse_power, bookings.total_amount
FROM bookings
INNER JOIN clients ON
bookings.client_id=clients.client_id
INNER JOIN cars ON
bookings.car_id=cars.car_id
where horse_power>150 and total_amount>500;

-- 8. Vypíšte zoznam áut, ktoré neboli prenajaté v roku 2020.
-- Požadovaný výstup: názvy áut.
select cars.producer, cars.model,bookings.start_date
FROM bookings
INNER JOIN cars ON
bookings.car_id=cars.car_id
where start_date like'2020%';
-- skúška zmeniť rok či sa zobrazí v tabuľke
select * from bookings;
update bookings set start_date='2021-07-06', end_date='2021-07-08' where booking_id=56;

-- 9. Vypíšte všetkých zákazníkov, ktorí si prenajali auto medzi januárom a marcom 2020, a usporiadajte ich podľa mesta.
-- Požadovaný výstup: meno, priezvisko, mesto, dátum prenájmu.

update bookings set start_date='2020-01-06', end_date='2020-01-08' where booking_id=46;
update bookings set start_date='2020-02-16', end_date='2020-02-19' where booking_id=47;

select clients.name, clients.surname,clients.city,bookings.start_date
FROM bookings
INNER JOIN clients ON
bookings.client_id=clients.client_id
where start_date between '2020-01-01' and '2020-03-31'
ORDER BY clients.city, clients.name, clients.surname, bookings.start_date;

-- 10. Zistite priemerné náklady na prenájom auta pre všetkých zákazníkov, ktorí si prenajali auto aspoň 3-krát.
-- Požadovaný výstup: meno, priezvisko zákazníka, priemerná suma prenájmu.
select clients.name, clients.surname, count(bookings.booking_id) as 'Number_of_bookings', avg(bookings.total_amount) as 'Average_cost'
FROM bookings
INNER JOIN clients ON
bookings.client_id=clients.client_id
INNER JOIN cars ON
bookings.car_id=cars.car_id
group by bookings.client_id
having count(bookings.booking_id) >=3;

