-- uloha č.2 --
create database car_rental;
use car_rental;

create table automobily(car_id int PRIMARY KEY,
manufacturer varchar(100),
model varchar(100),
year year,
horse_power int,
price_per_day int);

INSERT INTO automobily (car_id, manufacturer, model, year, horse_power, price_per_day) 
VALUES
(1, 'Toyota', 'Corolla', '2020', 132, 50),
(2, 'Ford', 'Mustang', '2018', 450, 150),
(3, 'Tesla', 'Model 3', '2022', 283, 200),
(4, 'BMW', 'X5', '2019', 335, 120),
(5, 'Audi', 'A4', '2021', 190, 90);

create table zakaznici(client_id int PRIMARY KEY,
first_name varchar(10),
last_name varchar(10),
adres_city varchar(20));

INSERT INTO zakaznici (client_id, first_name, last_name, adres_city)
VALUES
(1, 'John', 'Doe', 'Prague'),
(2, 'Alice', 'Smith', 'Brno'),
(3, 'Robert', 'Johnson', 'Ostrava'),
(4, 'Emma', 'Brown', 'Plzen'),
(5, 'Michael', 'Davis', 'Liberec');

create table rezervacie(booking_id int PRIMARY KEY, 
client_id int,
car_id int,
start_date date,
end_date date,
total_amount float);

INSERT INTO rezervacie (client_id, car_id, start_date, end_date, total_amount)
VALUES
(1, 2, '2024-09-01', '2024-09-07', 350.00),
(2, 3, '2024-10-10', '2024-10-15', 500.00),
(3, 1, '2024-11-05', '2024-11-09', 250.00),
(4, 4, '2024-12-20', '2024-12-25', 600.00),
(5, 5, '2024-08-15', '2024-08-20', 450.00);

alter table automobily modify column car_id integer auto_increment;
alter table zakaznici modify column client_id integer auto_increment;
alter table rezervacie modify column booking_id integer auto_increment;

alter table rezervacie add constraint client_id_fk foreign key (client_id) references zakaznici (client_id),
add constraint car_id_fk foreign key (car_id) references automobily (car_id);

-- uloha č.3 --
select * from rezervacie;
update zakaznici set first_name = 'Jan', last_name = 'Mitz', adres_city = 'LM' where client_id=1;
select * from zakaznici;

select booking_id from rezervacie where client_id=1;
DELETE FROM rezervacie WHERE booking_id = 1;
DELETE FROM zakaznici WHERE client_id = 1;


insert into zakaznici (first_name, last_name, adres_city)
VALUES
('John', 'Doe', 'Olomouc'),
('Francis', 'Joke', 'Zlín');