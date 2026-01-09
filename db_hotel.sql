create table hotel.roomtypes(
	room_type_id serial not null primary key,
	type_name varchar(50) not null unique,
	price_per_night numeric(10,2) check(price_per_night>0),
	max_capacity int check(max_capacity>0)
);

create type status as enum ('available', 'occupied', 'maintenance'); 
create table hotel.Rooms(
	room_id serial not null primary key,
	room_number varchar(10) not null unique,
	room_type_id int references hotel.roomtypes(room_type_id) on delete cascade,
	status_room status not null 
);

create table hotel.Customers(
	custom_id serial  not null primary key,
	full_name varchar(100) not null,
	email varchar(100) not null unique,
	phone varchar(15) not null
);

create type status_order as enum ('Pending', 'Confirmed', 'Cancelled'); 
create table hotel.Booking(
	booking_id serial not null primary key,
	custom_id int references hotel.customers(custom_id) on delete cascade,
	room_id int references hotel.rooms(room_id) on delete cascade,
	check_in date not null,
	check_out date not null,
	status status_order not null 
);

create type method_type as enum ('Credit Card', 'Cash', 'Bank Tranfer');
create table hotel.Payments(
	payment_id serial not null primary key,
	booking_id int references hotel.booking(booking_id) on delete cascade,
	amount numeric(10,2) DEFAULT 0 check(amount >= 0),
	payment_date date not null,
	method method_type not null
);

