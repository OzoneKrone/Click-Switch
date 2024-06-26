-- Popolamento della tabella user_account
INSERT INTO user_account (username, email, hash_password, name, address, role)
VALUES 
    ('user1', 'user1@example.com', 'ff84abb1970b527abf2e96539a5944c844ef5c42df3c6479cda7d64543cdf3e1326878f388587c3aa8913b6aed65f408fa177236357607c22df75d1e1ef38d22', 'User One', '123 Main Street', 'user'),
    ('user2', 'user2@example.com', '385b5fb3512f87533f59837c26d0337dd8f3c7056e9607eb66e78fbc00fcdd52c6a5a3302eaf834df860379d8654924b00e5b34a059709c998bdc54772b794b2', 'User Two', '456 Elm Street', 'user'),
    ('admin', 'admin1@example.com', '5b722b307fce6c944905d132691d5e4a2214b7fe92b738920eb3fce3a90420a19511c3010a0e7712b054daef5b57bad59ecbd93b3280f210578f547f4aed4d25', 'Admin One', '789 Oak Street', 'admin');

-- Popolamento della tabella product
INSERT INTO product (name, price, description, quantity, is_available, image_url)
VALUES 
    ('Qisan 68', 59.99, 'Design mini e portatile, tastiera a due tasti con tasti meccanici OUTEMU (equivalente al modello Cherry MX)', 50, true, 'images/qisan.jpg'),
    ('Razer BlackWidow', 129.99, 'Tastiera meccanica da gaming con Razer Chroma™ RGB', 100, true, 'images/blackwidow.jpg'),
    ('Logitech G412', 79.99, 'G413 TKL SE include switch meccanici Tactile, rollover a 6 tasti anti-ghosting, copritasti in PBT e scocca robusta in lega di alluminio senza tastierino numerico.', 30, false, 'images/g412.jpg'),
    ('Keychron Q1', 229.99, 'Permium Mechanical keyboard with RBG and Hot-Swappable Sockets', 100, true, NULL),
    ('Akko 3502', 200.99, 'Gaming mouse with adjustable DPI', 100, true, NULL),
    ('Cherry Red Switches', 29.99, '5-Pin Keyboard switches (Pack of 25)', 100, true, NULL),
    ('NK65', 119.99, 'Barebone DYI Keyboard Kit', 100, true, NULL),
    ('GMK65', 119.99, 'Keyboard', 100, true, 'images/keyb.jpg');

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
