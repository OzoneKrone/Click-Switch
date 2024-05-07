-- Popolamento della tabella user_account
INSERT INTO user_account (username, email, passwrd, name, address, role)
VALUES 
    ('user1', 'user1@example.com', 'password1', 'User One', '123 Main Street', 'user'),
    ('user2', 'user2@example.com', 'password2', 'User Two', '456 Elm Street', 'user'),
    ('admin1', 'admin1@example.com', 'adminpassword1', 'Admin One', '789 Oak Street', 'admin');

-- Popolamento della tabella product
INSERT INTO product (name, price, description, quantity, image)
VALUES 
    ('Qisan', 99.99, 'Mechanical keyboard with RGB lighting', 50, NULL),
    ('Razer', 29.99, 'Gaming mouse with adjustable DPI', 100, NULL),
    ('Logitech', 249.99, '27-inch 1440p IPS monitor', 30, NULL);

-- Popolamento della tabella user_order
INSERT INTO user_order (date_time, status, total, username)
VALUES 
    ('2024-05-01 10:00:00', 'placed', 129.98, 'user1'),
    ('2024-05-02 11:30:00', 'shipped', 29.99, 'user2');

-- Popolamento della tabella order_items
INSERT INTO order_items (product_id, order_id, name, price, quantity)
VALUES 
    (1, 1, 'Qisan', 99.99, 1),
    (2, 1, 'Razer', 29.99, 1),
    (3, 2, 'Logitech', 249.99, 1);
