use trains;

DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS faq;
DROP TABLE IF EXISTS reservation;
DROP TABLE IF EXISTS schedule;
DROP TABLE IF EXISTS stops_at;
DROP TABLE IF EXISTS station;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS train;

CREATE TABLE employee (
    ssn VARCHAR (20) NOT NULL,
    username VARCHAR(45),
    password VARCHAR(20),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    account_type VARCHAR(45),
    PRIMARY KEY (username)
);

CREATE TABLE station (
    sid INT NOT NULL,
    name VARCHAR(45),
    city VARCHAR(45),
    state VARCHAR(45),
    PRIMARY KEY (sid)
);

-- CREATE TABLE train (
--     train_id INT,
--     PRIMARY KEY (train_id)
-- );

CREATE TABLE stops_at (
    stop_id INT NOT NULL,
    origin_station INT,
    destination_station INT,
    departure_datetime DATETIME NOT NULL,
    arrival_datetime DATETIME,
    PRIMARY KEY (stop_id, departure_datetime),
    FOREIGN KEY (destination_station) REFERENCES station (sid),
    FOREIGN KEY (origin_station) REFERENCES station (sid)
);

CREATE TABLE schedule (
    tid CHAR(4) NOT NULL,
    stop_id INT NOT NULL,
    transit_line_name VARCHAR(45) NOT NULL,
    num_stops INT,
    travel_time INT,
    fare FLOAT,
    PRIMARY KEY (tid, stop_id, transit_line_name),
    FOREIGN KEY (stop_id)
        REFERENCES stops_at (stop_id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE customer (
    username VARCHAR(45) NOT NULL,
    password VARCHAR(45),
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(45),
    person_type VARCHAR(45),
    PRIMARY KEY (username)
);
ALTER TABLE schedule ADD INDEX (tid, transit_line_name);
CREATE TABLE reservation (
    reservation_number INT NOT NULL,
    origin_station INT,
    destination_station INT,
    reservation_date DATE,
    total_fare DOUBLE,
    departure_datetime DATETIME,
    arrival_datetime DATETIME,
    one_way_or_round_trip VARCHAR(45),
    tid CHAR(4),
    transit_line_name VARCHAR(45),
    username VARCHAR(45),
    PRIMARY KEY (reservation_number),
    FOREIGN KEY (username)
        REFERENCES customer (username)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (tid, transit_line_name)
        REFERENCES schedulet (tid, transit_line_name)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

CREATE TABLE faq (
    idfaq INT NOT NULL,
    question MEDIUMTEXT,
    answer MEDIUMTEXT,
    PRIMARY KEY (idfaq)
);


-- ------------------------------ADD DATA NOTE: Reservation must be made on website if none exists in reservation table-------------------------------------------------------
-- Pascack Valley Line
insert into station values (1000, 'meadowlands', 'meadowlands', 'NJ');
insert into station values (1001, 'wood-ridge', 'wood-ridge', 'NJ');
insert into station values (1002, 'teterboro', 'teterboro', 'NJ');
insert into station values (1003, 'essex st', 'hackensack', 'NJ');
-- Main Line
insert into station values (2000, 'kingsland', 'kingsland', 'NJ');
insert into station values (2001, 'lyndhurst', 'lyndhurst', 'NJ');
insert into station values (2002, 'delawanna', 'delawanna', 'NJ');
insert into station values (2003, 'pasaic', 'passaic', 'NJ');
-- Montclair-Boonton Line
insert into station values (3000, 'watessing', 'bloomfield', 'NJ');
insert into station values (3001, 'bloomfield', 'bloomfield', 'NJ');
insert into station values (3002, 'glen ridge', 'glen ridge', 'NJ');
insert into station values (3003, 'Bay st', 'montclair', 'NJ');
-- Hacketstown Line
insert into station values (4000, 'east orange', 'east orange', 'NJ');
insert into station values (4001, 'brick church', 'east orange', 'NJ');
insert into station values (4002, 'orange', 'orange', 'NJ');
insert into station values (4003, 'highland ave', 'orange', 'NJ');

-- High Bridge Line
insert into station values (5000, 'newark airport', 'newark', 'NJ');
insert into station values (5001, 'union', 'union', 'NJ');
insert into station values (5002, 'roselle park', 'roselle park', 'NJ');
insert into station values (5003, 'cranford', 'cranford', 'NJ');

-- Northeast Corridor Line
insert into station values (6000, 'metropark', 'iselin', 'NJ');
insert into station values (6001, 'metuchen', 'metuchen', 'NJ');
insert into station values (6002, 'edison', 'edison', 'NJ');
insert into station values (6003, 'new brunswick', 'new brunswick', 'NJ');

-- ---------------------------------------------------------------------------------------------
insert into stops_at values(1100, 1000, 1001, '2020-12-17 08:00:00', '2020-12-17 08:10:00');
insert into stops_at values(1200, 1001, 1002, '2020-12-17 08:15:00', '2020-12-17 08:25:00');
insert into stops_at values(1300, 1002, 1003, '2020-12-17 08:30:00', '2020-12-17 08:40:00');
insert into stops_at values(1101, 1000, 1001, '2020-12-17 09:00:00', '2020-12-17 09:10:00');
insert into stops_at values(1202, 1001, 1002, '2020-12-17 09:15:00', '2020-12-17 09:25:00');
insert into stops_at values(1303, 1002, 1003, '2020-12-17 09:30:00', '2020-12-17 09:40:00');
insert into stops_at values(1104, 1000, 1001, '2020-12-17 10:00:00', '2020-12-17 10:10:00');
insert into stops_at values(1205, 1001, 1002, '2020-12-17 10:15:00', '2020-12-17 10:25:00');
insert into stops_at values(1306, 1002, 1003, '2020-12-17 10:30:00', '2020-12-17 10:40:00');

insert into stops_at values(2100, 2000, 2001, '2020-12-17 08:00:00', '2020-12-17 08:10:00');
insert into stops_at values(2200, 2001, 2002, '2020-12-17 08:15:00', '2020-12-17 08:25:00');
insert into stops_at values(2300, 2002, 2003, '2020-12-17 08:30:00', '2020-12-17 08:40:00');
insert into stops_at values(2101, 2000, 2001, '2020-12-17 09:00:00', '2020-12-17 09:10:00');
insert into stops_at values(2202, 2001, 2002, '2020-12-17 09:15:00', '2020-12-17 09:25:00');
insert into stops_at values(2303, 2002, 2003, '2020-12-17 09:30:00', '2020-12-17 09:40:00');
insert into stops_at values(2104, 2000, 2001, '2020-12-17 10:00:00', '2020-12-17 10:10:00');
insert into stops_at values(2205, 2001, 2002, '2020-12-17 10:15:00', '2020-12-17 10:25:00');
insert into stops_at values(2306, 2002, 2003, '2020-12-17 10:30:00', '2020-12-17 10:40:00');


insert into stops_at values(3100, 3000, 3001, '2020-12-17 08:00:00', '2020-12-17 08:10:00');
insert into stops_at values(3200, 3001, 3002, '2020-12-17 08:15:00', '2020-12-17 08:25:00');
insert into stops_at values(3300, 3002, 3003, '2020-12-17 08:30:00', '2020-12-17 08:40:00');
insert into stops_at values(3101, 3000, 3001, '2020-12-17 09:00:00', '2020-12-17 09:10:00');
insert into stops_at values(3202, 3001, 3002, '2020-12-17 09:15:00', '2020-12-17 09:25:00');
insert into stops_at values(3303, 3002, 3003, '2020-12-17 09:30:00', '2020-12-17 09:40:00');
insert into stops_at values(3104, 3000, 3001, '2020-12-17 10:00:00', '2020-12-17 10:10:00');
insert into stops_at values(3205, 3001, 3002, '2020-12-17 10:15:00', '2020-12-17 10:25:00');
insert into stops_at values(3306, 3002, 3003, '2020-12-17 10:30:00', '2020-12-17 10:40:00');


insert into stops_at values(4100, 4000, 4001, '2020-12-17 08:00:00', '2020-12-17 08:10:00');
insert into stops_at values(4200, 4001, 4002, '2020-12-17 08:15:00', '2020-12-17 08:25:00');
insert into stops_at values(4300, 4002, 4003, '2020-12-17 08:30:00', '2020-12-17 08:40:00');
insert into stops_at values(4101, 4000, 4001, '2020-12-17 09:00:00', '2020-12-17 09:10:00');
insert into stops_at values(4202, 4001, 4002, '2020-12-17 09:15:00', '2020-12-17 09:25:00');
insert into stops_at values(4303, 4002, 4003, '2020-12-17 09:30:00', '2020-12-17 09:40:00');
insert into stops_at values(4104, 4000, 4001, '2020-12-17 10:00:00', '2020-12-17 10:10:00');
insert into stops_at values(4205, 4001, 4002, '2020-12-17 10:15:00', '2020-12-17 10:25:00');
insert into stops_at values(4306, 4002, 4003, '2020-12-17 10:30:00', '2020-12-17 10:40:00');

insert into stops_at values(5100, 5000, 5001, '2020-12-17 08:00:00', '2020-12-17 08:10:00');
insert into stops_at values(5200, 5001, 5002, '2020-12-17 08:15:00', '2020-12-17 08:25:00');
insert into stops_at values(5300, 5002, 5003, '2020-12-17 08:30:00', '2020-12-17 08:40:00');
insert into stops_at values(5101, 5000, 5001, '2020-12-17 09:00:00', '2020-12-17 09:10:00');
insert into stops_at values(5202, 5001, 5002, '2020-12-17 09:15:00', '2020-12-17 09:25:00');
insert into stops_at values(5303, 5002, 5003, '2020-12-17 09:30:00', '2020-12-17 09:40:00');
insert into stops_at values(5104, 5000, 5001, '2020-12-17 10:00:00', '2020-12-17 10:10:00');
insert into stops_at values(5205, 5001, 5002, '2020-12-17 10:15:00', '2020-12-17 10:25:00');
insert into stops_at values(5306, 5002, 5003, '2020-12-17 10:30:00', '2020-12-17 10:40:00');

insert into stops_at values(6100, 6000, 6001, '2020-12-17 08:00:00', '2020-12-17 08:10:00');
insert into stops_at values(6200, 6001, 6002, '2020-12-17 08:15:00', '2020-12-17 08:25:00');
insert into stops_at values(6300, 6002, 6003, '2020-12-17 08:30:00', '2020-12-17 08:40:00');
insert into stops_at values(6101, 6000, 6001, '2020-12-17 09:00:00', '2020-12-17 09:10:00');
insert into stops_at values(6202, 6001, 6002, '2020-12-17 09:15:00', '2020-12-17 09:25:00');
insert into stops_at values(6303, 6002, 6003, '2020-12-17 09:30:00', '2020-12-17 09:40:00');
insert into stops_at values(6104, 6000, 6001, '2020-12-17 10:00:00', '2020-12-17 10:10:00');
insert into stops_at values(6205, 6001, 6002, '2020-12-17 10:15:00', '2020-12-17 10:25:00');
insert into stops_at values(6306, 6002, 6003, '2020-12-17 10:30:00', '2020-12-17 10:40:00');

insert into stops_at values(1100, 1000, 1001, '2021-01-17 08:00:00', '2021-01-17 08:10:00');
insert into stops_at values(1200, 1001, 1002, '2021-01-17 08:15:00', '2021-01-17 08:25:00');
insert into stops_at values(1300, 1002, 1003, '2021-01-17 08:30:00', '2021-01-17 08:40:00');
insert into stops_at values(1101, 1000, 1001, '2021-01-17 09:00:00', '2021-01-17 09:10:00');
insert into stops_at values(1202, 1001, 1002, '2021-01-17 09:15:00', '2021-01-17 09:25:00');
insert into stops_at values(1303, 1002, 1003, '2021-01-17 09:30:00', '2021-01-17 09:40:00');
insert into stops_at values(1104, 1000, 1001, '2021-01-17 10:00:00', '2021-01-17 10:10:00');
insert into stops_at values(1205, 1001, 1002, '2021-01-17 10:15:00', '2021-01-17 10:25:00');
insert into stops_at values(1306, 1002, 1003, '2021-01-17 10:30:00', '2021-01-17 10:40:00');

insert into stops_at values(2100, 2000, 2001, '2021-01-17 08:00:00', '2021-01-17 08:10:00');
insert into stops_at values(2200, 2001, 2002, '2021-01-17 08:15:00', '2021-01-17 08:25:00');
insert into stops_at values(2300, 2002, 2003, '2021-01-17 08:30:00', '2021-01-17 08:40:00');
insert into stops_at values(2101, 2000, 2001, '2021-01-17 09:00:00', '2021-01-17 09:10:00');
insert into stops_at values(2202, 2001, 2002, '2021-01-17 09:15:00', '2021-01-17 09:25:00');
insert into stops_at values(2303, 2002, 2003, '2021-01-17 09:30:00', '2021-01-17 09:40:00');
insert into stops_at values(2104, 2000, 2001, '2021-01-17 10:00:00', '2021-01-17 10:10:00');
insert into stops_at values(2205, 2001, 2002, '2021-01-17 10:15:00', '2021-01-17 10:25:00');
insert into stops_at values(2306, 2002, 2003, '2021-01-17 10:30:00', '2021-01-17 10:40:00');


insert into stops_at values(3100, 3000, 3001, '2021-01-17 08:00:00', '2021-01-17 08:10:00');
insert into stops_at values(3200, 3001, 3002, '2021-01-17 08:15:00', '2021-01-17 08:25:00');
insert into stops_at values(3300, 3002, 3003, '2021-01-17 08:30:00', '2021-01-17 08:40:00');
insert into stops_at values(3101, 3000, 3001, '2021-01-17 09:00:00', '2021-01-17 09:10:00');
insert into stops_at values(3202, 3001, 3002, '2021-01-17 09:15:00', '2021-01-17 09:25:00');
insert into stops_at values(3303, 3002, 3003, '2021-01-17 09:30:00', '2021-01-17 09:40:00');
insert into stops_at values(3104, 3000, 3001, '2021-01-17 10:00:00', '2021-01-17 10:10:00');
insert into stops_at values(3205, 3001, 3002, '2021-01-17 10:15:00', '2021-01-17 10:25:00');
insert into stops_at values(3306, 3002, 3003, '2021-01-17 10:30:00', '2021-01-17 10:40:00');

insert into stops_at values(4100, 4000, 4001, '2021-01-17 08:00:00', '2021-01-17 08:10:00');
insert into stops_at values(4200, 4001, 4002, '2021-01-17 08:15:00', '2021-01-17 08:25:00');
insert into stops_at values(4300, 4002, 4003, '2021-01-17 08:30:00', '2021-01-17 08:40:00');
insert into stops_at values(4101, 4000, 4001, '2021-01-17 09:00:00', '2021-01-17 09:10:00');
insert into stops_at values(4202, 4001, 4002, '2021-01-17 09:15:00', '2021-01-17 09:25:00');
insert into stops_at values(4303, 4002, 4003, '2021-01-17 09:30:00', '2021-01-17 09:40:00');
insert into stops_at values(4104, 4000, 4001, '2021-01-17 10:00:00', '2021-01-17 10:10:00');
insert into stops_at values(4205, 4001, 4002, '2021-01-17 10:15:00', '2021-01-17 10:25:00');
insert into stops_at values(4306, 4002, 4003, '2021-01-17 10:30:00', '2021-01-17 10:40:00');

insert into stops_at values(5100, 5000, 5001, '2021-01-17 08:00:00', '2021-01-17 08:10:00');
insert into stops_at values(5200, 5001, 5002, '2021-01-17 08:15:00', '2021-01-17 08:25:00');
insert into stops_at values(5300, 5002, 5003, '2021-01-17 08:30:00', '2021-01-17 08:40:00');
insert into stops_at values(5101, 5000, 5001, '2021-01-17 09:00:00', '2021-01-17 09:10:00');
insert into stops_at values(5202, 5001, 5002, '2021-01-17 09:15:00', '2021-01-17 09:25:00');
insert into stops_at values(5303, 5002, 5003, '2021-01-17 09:30:00', '2021-01-17 09:40:00');
insert into stops_at values(5104, 5000, 5001, '2021-01-17 10:00:00', '2021-01-17 10:10:00');
insert into stops_at values(5205, 5001, 5002, '2021-01-17 10:15:00', '2021-01-17 10:25:00');
insert into stops_at values(5306, 5002, 5003, '2021-01-17 10:30:00', '2021-01-17 10:40:00');

insert into stops_at values(6100, 6000, 6001, '2021-01-17 08:00:00', '2021-01-17 08:10:00');
insert into stops_at values(6200, 6001, 6002, '2021-01-17 08:15:00', '2021-01-17 08:25:00');
insert into stops_at values(6300, 6002, 6003, '2021-01-17 08:30:00', '2021-01-17 08:40:00');
insert into stops_at values(6101, 6000, 6001, '2021-01-17 09:00:00', '2021-01-17 09:10:00');
insert into stops_at values(6202, 6001, 6002, '2021-01-17 09:15:00', '2021-01-17 09:25:00');
insert into stops_at values(6303, 6002, 6003, '2021-01-17 09:30:00', '2021-01-17 09:40:00');
insert into stops_at values(6104, 6000, 6001, '2021-01-17 10:00:00', '2021-01-17 10:10:00');
insert into stops_at values(6205, 6001, 6002, '2021-01-17 10:15:00', '2021-01-17 10:25:00');
insert into stops_at values(6306, 6002, 6003, '2021-01-17 10:30:00', '2021-01-17 10:40:00');

insert into schedule values (1111, 1100, 'Pascack Valley Line', 1, 10, 10.00);
insert into schedule values (1111, 1200, 'Pascack Valley Line', 1, 10, 10.00);
insert into schedule values (1111, 1300, 'Pascack Valley Line', 1, 10, 10.00);
insert into schedule values (1111, 1101, 'Pascack Valley Line', 1, 10, 10.00);
insert into schedule values (1111, 1202, 'Pascack Valley Line', 1, 10, 10.00);
insert into schedule values (1111, 1303, 'Pascack Valley Line', 1, 10, 10.00);
insert into schedule values (1111, 1104, 'Pascack Valley Line', 1, 10, 10.00);
insert into schedule values (1111, 1205, 'Pascack Valley Line', 1, 10, 10.00);
insert into schedule values (1111, 1306, 'Pascack Valley Line', 1, 10, 10.00);

insert into schedule values (2222, 2100, 'Main Line', 1, 10, 10.00);
insert into schedule values (2222, 2200, 'Main Line', 1, 10, 10.00);
insert into schedule values (2222, 2300, 'Main Line', 1, 10, 10.00);
insert into schedule values (2222, 2101, 'Main Line', 1, 10, 10.00);
insert into schedule values (2222, 2202, 'Main Line', 1, 10, 10.00);
insert into schedule values (2222, 2303, 'Main Line', 1, 10, 10.00);
insert into schedule values (2222, 2104, 'Main Line', 1, 10, 10.00);
insert into schedule values (2222, 2205, 'Main Line', 1, 10, 10.00);
insert into schedule values (2222, 2306, 'Main Line', 1, 10, 10.00);

insert into schedule values (3333, 3100, 'Montclair-Boonton Line', 1, 10, 10.00);
insert into schedule values (3333, 3200, 'Montclair-Boonton Line', 1, 10, 10.00);
insert into schedule values (3333, 3300, 'Montclair-Boonton Line', 1, 10, 10.00);
insert into schedule values (3333, 3101, 'Montclair-Boonton Line', 1, 10, 10.00);
insert into schedule values (3333, 3202, 'Montclair-Boonton Line', 1, 10, 10.00);
insert into schedule values (3333, 3303, 'Montclair-Boonton Line', 1, 10, 10.00);
insert into schedule values (3333, 3104, 'Montclair-Boonton Line', 1, 10, 10.00);
insert into schedule values (3333, 3205, 'Montclair-Boonton Line', 1, 10, 10.00);
insert into schedule values (3333, 3306, 'Montclair-Boonton Line', 1, 10, 10.00);

insert into schedule values (4444, 4100, 'Hacketstown Line', 1, 10, 10.00);
insert into schedule values (4444, 4200, 'Hacketstown Line', 1, 10, 10.00);
insert into schedule values (4444, 4300, 'Hacketstown Line', 1, 10, 10.00);
insert into schedule values (4444, 4101, 'Hacketstown Line', 1, 10, 10.00);
insert into schedule values (4444, 4202, 'Hacketstown Line', 1, 10, 10.00);
insert into schedule values (4444, 4303, 'Hacketstown Line', 1, 10, 10.00);
insert into schedule values (4444, 4104, 'Hacketstown Line', 1, 10, 10.00);
insert into schedule values (4444, 4205, 'Hacketstown Line', 1, 10, 10.00);
insert into schedule values (4444, 4306, 'Hacketstown Line', 1, 10, 10.00);

insert into schedule values (5555, 5100, 'High Bridge Line', 1, 10, 10.00);
insert into schedule values (5555, 5200, 'High Bridge Line', 1, 10, 10.00);
insert into schedule values (5555, 5300, 'High Bridge Line', 1, 10, 10.00);
insert into schedule values (5555, 5101, 'High Bridge Line', 1, 10, 10.00);
insert into schedule values (5555, 5202, 'High Bridge Line', 1, 10, 10.00);
insert into schedule values (5555, 5303, 'High Bridge Line', 1, 10, 10.00);
insert into schedule values (5555, 5104, 'High Bridge Line', 1, 10, 10.00);
insert into schedule values (5555, 5205, 'High Bridge Line', 1, 10, 10.00);
insert into schedule values (5555, 5306, 'High Bridge Line', 1, 10, 10.00);

insert into schedule values (6666, 6100, 'Northeast Corridor Line', 1, 10, 10.00);
insert into schedule values (6666, 6200, 'Northeast Corridor Line', 1, 10, 10.00);
insert into schedule values (6666, 6300, 'Northeast Corridor Line', 1, 10, 10.00);
insert into schedule values (6666, 6101, 'Northeast Corridor Line', 1, 10, 10.00);
insert into schedule values (6666, 6202, 'Northeast Corridor Line', 1, 10, 10.00);
insert into schedule values (6666, 6303, 'Northeast Corridor Line', 1, 10, 10.00);
insert into schedule values (6666, 6104, 'Northeast Corridor Line', 1, 10, 10.00);
insert into schedule values (6666, 6205, 'Northeast Corridor Line', 1, 10, 10.00);
insert into schedule values (6666, 6306, 'Northeast Corridor Line', 1, 10, 10.00);



