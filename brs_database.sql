drop database if EXISTS brs;

create database brs;

use brs;

create table administrator (
    id varchar(10) primary key,
    firstname varchar(50) not null,
    middlename varchar(50) not null,
    lastname varchar(50) not null,
    `address` varchar(50),
    phonenumber varchar(15)
);

create table driver (
    id varchar(10) primary key,
    firstname varchar(50) not null,
    middlename varchar(50) not null,
    lastname varchar(50) not null,
    `address` varchar(50),
    phonenumber varchar(15)    
);

create table bus (
    id varchar(10) primary key,
    capacity int not null        
);

create table customer (
    id varchar(10) primary key,
    firstname varchar(50) not null,
    middlename varchar(50) not null,
    lastname varchar(50) not null,
    `address` varchar(50),
    phonenumber varchar(15)
);


create table scheduledroute (
    id varchar(10) primary key,
    source varchar(50) not null,
    destination varchar(50) not null,
    departureTime datetime not null,
    arrivalTime datetime not null    
);

create table busassignment (
    routeId varchar(10) not null,
    busId varchar(10) not null,
    driverId varchar(10) not null,

    foreign key (routeId) references scheduledroute(id),
    foreign key (busId) references bus(id),
    foreign key (driverId) references driver(id)
);

create table reservation (
    id varchar(10) primary key,
    customerId varchar(10) not null,
    busId varchar(10) not null,
    routeId varchar(10) not null,
    seatNumber int not null,
    purchaseDate datetime not null,

    foreign key (customerId) references customer(id),
    foreign key (busId) references bus(id),
    foreign key (routeId) references scheduledroute(id)
);


create table user(
    id varchar(10) primary key,
    `password` varchar(128) not null,
    `role` varchar(15) not null
);

-- populate with data

INSERT INTO `administrator` (`id`, `firstname`, `middlename`, `lastname`, `address`, `phonenumber`) VALUES
('admin', 'admin', 'adminm', 'adminl', 'akaki, addis ababa, ethiopia, 1000', '2510888523');

INSERT INTO `customer` (`id`, `firstname`, `middlename`, `lastname`, `address`, `phonenumber`) VALUES
('cust-01', 'fname', 'mname', 'lname', 'akaki, addis ababa, ethiopia, 1000', '25109743523');

INSERT INTO `user` (`id`, `password`, `role`) VALUES
('cust-01', '6367c48dd193d56ea7b0baad25b19455e529f5ee', 'CUSTOMER'),
('admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'ADMIN');

INSERT INTO `scheduledroute` (`id`, `source`, `destination`, `departureTime`, `arrivalTime`) VALUES
('route-0', 'Akaki kality', 'Bole', '2020-01-01 10:20:10', '2020-01-01 11:20:10'),
('route-1', 'Semit', 'Tulu dimtu', '2020-02-01 10:20:10', '2020-02-01 11:20:10'),
('route-3', '6 Kilo', 'Mexico', '2020-03-01 08:20:10', '2020-03-01 10:20:10'),
('route-2', 'Piassa', 'Megenagna', '2020-04-01 08:20:10', '2020-04-01 09:20:10');

INSERT INTO `bus` (`id`, `capacity`) VALUES
('bus-01', 50),
('bus-02', 60),
('bus-03', 65),
('bus-04', 45);

INSERT INTO `driver` (`id`, `firstname`, `middlename`, `lastname`, `address`, `phonenumber`) VALUES
('driver-01', 'Abebe', 'Desta', 'Hagos', 'akaki, addis ababa, ethiopia, 1000', '2510777523'),
('driver-02', 'Kebede', 'Ayeale', 'Surafel', 'bole, addis ababa, ethiopia, 1000', '2510888523'),
('driver-03', 'Markos', 'Hailu', 'Samuael', 'nifas silk, addis ababa, ethiopia, 1000', '2510999523');


INSERT INTO `busassignment` (`busId`, `routeId`, `driverId`) VALUES
('bus-01', 'route-1', 'driver-01'),
('bus-02', 'route-2', 'driver-02'),
('bus-03', 'route-3', 'driver-03');

select r.id, r.source, r.destination, r.departureTime, r.arrivalTime, ba.busId, ba.Driverid from busassignment ba 
join scheduledroute r on r.id = ba.routeId;


SELECT r.id, r.source, r.destination, r.departureTime, r.arrivalTime
FROM BusAssignment as ba 
JOIN ScheduledRoute r ON ba.routeId = r.id AND ba.busId = '%s' ;