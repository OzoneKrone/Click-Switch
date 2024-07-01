drop database if exists ClickSwitch;
create database ClickSwitch;
use ClickSwitch;

create table user_account
(
	username varchar(50) PRIMARY KEY NOT NULL,
    email varchar(50) UNIQUE NOT NULL,
    hash_password varchar(200) NOT NULL,
    name varchar(50) NOT NULL,
    address varchar(50) NOT NULL,
    role enum('user', 'admin') NOT NULL
);

CREATE TABLE product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description VARCHAR(500),
    quantity INT NOT NULL,
    is_available BOOL NOT NULL,
    image_url VARCHAR(255)
);

CREATE TABLE user_order (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date_time DATETIME NOT NULL,
    status VARCHAR(50) NOT NULL,
    total DECIMAL(6,2) NOT NULL,
    username VARCHAR(50) NOT NULL,
    FOREIGN KEY (username) REFERENCES user_account(username)
);

CREATE TABLE order_items (
    product_id INT,
    order_id INT,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (product_id, order_id),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (order_id) REFERENCES user_order(id)
);

-- Popolamento della tabella user_account
INSERT INTO user_account (username, email, hash_password, name, address, role)
VALUES 
    ('user1', 'user1@example.com', 'ff84abb1970b527abf2e96539a5944c844ef5c42df3c6479cda7d64543cdf3e1326878f388587c3aa8913b6aed65f408fa177236357607c22df75d1e1ef38d22', 'User One', '123 Main Street', 'user'),
    ('user2', 'user2@example.com', '385b5fb3512f87533f59837c26d0337dd8f3c7056e9607eb66e78fbc00fcdd52c6a5a3302eaf834df860379d8654924b00e5b34a059709c998bdc54772b794b2', 'User Two', '456 Elm Street', 'user'),
    ('admin', 'admin1@example.com', '5b722b307fce6c944905d132691d5e4a2214b7fe92b738920eb3fce3a90420a19511c3010a0e7712b054daef5b57bad59ecbd93b3280f210578f547f4aed4d25', 'Admin One', '789 Oak Street', 'admin');

-- Popolamento della tabella product
INSERT INTO product (name, price, description, quantity, is_available, image_url)
VALUES 
    ('Flame 60', 119.99, '6063 aluminum<br>6.5° degree typing angle<br>PCB: QMK/VIA Compatible, Daughter Board Type C design - Solder only<br>Gasket mount (poron gaskets)<br>3.5MM dampener between plate and PCB<br>1.5-2MM bottom case dampener<br>Width: 297.75MM or (11.7 inch)<br>Depth: 108.25MM or (4.2 inch)<br>Front height: 20MM or (0.7 inch)<br>Weight (without any kind of plate): 1.6KG or (3.5LBS)<br>Colours: Black, Blue, Wine Red, E-White (Soya)', 100, true, 'images/flame60.jpg'),
    ('Qisan 68', 59.99, 'Design mini e portatile, tastiera a due tasti con tasti meccanici OUTEMU (equivalente al modello Cherry MX)', 50, true, 'images/qisan.jpg'),
    ('Razer BlackWidow', 129.99, 'Tastiera meccanica da gaming con Razer Chroma™ RGB', 100, true, 'images/blackwidow.jpg'),
    ('Logitech G412', 79.99, 'G413 TKL SE include switch meccanici Tactile, rollover a 6 tasti anti-ghosting, copritasti in PBT e scocca robusta in lega di alluminio senza tastierino numerico.', 30, true, 'images/g412.jpg'),
    ('Keychron Q1', 229.99, 'Tastiera Meccanica Premium con RBG e Hot-Swappable Sockets', 100, true, 'images/q1.jpg'),
    ('Akko 3502', 200.99, 'Tastiera Meccanica Premium Personalizzabile. Switch Holy Pandas lubrificati.', 100, true, 'images/akko.jpg'),
    ('Cherry Red Switches', 29.99, '5-Pin Keyboard switches (Pack of 25)', 100, true, 'images/red.jpg'),
    ('NK65', 119.99, 'Complete DYI Keyboard Kit', 100, true, 'images/nk65.jpg'),
    ('GMK TIK R2', 119.99, 'Barebone DYI Keyboard Kit', 100, true, 'images/gmk65.jpg'),
    ('CYL Nord', 149.99, 'GMK ABS Double-Shot Keycaps', 100, true, 'images/cyl.jpg'),
    ('CYL Phantom R2', 149.99, 'GMK ABS Double-Shot Keycaps', 120, true, 'images/phant.jpg'),
    ('KAT Milkshake', 49.99, 'PBT Double-Shot Keycaps', 20, true, 'images/milk.jpg'),
    ('Gateron Quinn Switches', 39.99, '36 Per Box', 220, true, 'images/quinn.jpg'),
    ('Qmx Stabilizers', 39.99, '6 Per Box', 2220, true, 'images/stabs.jpg'),
    ('WT60-C PCB', 29.99, 'Introducing the WT60-C PCB. Designed by wilba.tech', 2220, true, 'images/pcb.jpg'),
    ('Deskpad', 29.99, 'In collaboration with randomfrankp. Now featuring a new rough texture!', 50, true, 'images/pad.jpg'),
    ('Aluminum Lubrication Station', 49.99, 'Say goodbye to messy applications and hello to smooth performance. Get your switches organized and lubricated with our Lubricant Station.', 30, true, 'images/alum.jpg'),
    ('Lubricants', 9.99, 'Don\'t let friction slow you down, glide through tasks with ease by using our versatile lubricants for switches, springs, and stabilizers.', 20, true, 'images/lube.jpg');

-- Popolamento della tabella user_order
INSERT INTO user_order (date_time, status, total, username)
VALUES 
    ('2024-05-01 10:00:00', 'pending', 129.98, 'user1'),
    ('2024-05-02 11:30:00', 'shipped', 29.99, 'user2');

-- Popolamento della tabella order_items
INSERT INTO order_items (product_id, order_id, name, price, quantity)
VALUES 
    (1, 1, 'Qisan', 99.99, 1),
    (2, 1, 'Razer', 29.99, 1),
    (3, 2, 'Logitech', 249.99, 1);

