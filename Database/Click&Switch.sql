drop database if exists ClickSwitch;
create database ClickSwitch;
use ClickSwitch;

create table user_account
(
	username varchar(50) PRIMARY KEY NOT NULL,
    email varchar(50) UNIQUE NOT NULL,
    passwrd varchar(50) NOT NULL,
    name varchar(50) NOT NULL,
    address varchar(50) NOT NULL,
    role enum('user', 'admin') NOT NULL
);

CREATE TABLE product (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description VARCHAR(200),
    quantity INT NOT NULL,
    image BLOB DEFAULT NULL
);

CREATE TABLE user_order (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date_time DATETIME NOT NULL,
    status ENUM('placed', 'shipped', 'delivered') NOT NULL,
    total DECIMAL(10,2) NOT NULL,
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
