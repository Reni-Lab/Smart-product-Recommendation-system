CREATE DATABASE IF NOT EXISTS shoppingdb;
USE shoppingdb;

DROP TABLE IF EXISTS ShoppingItems;

CREATE TABLE ShoppingItems (
    ProductId INT PRIMARY KEY AUTO_INCREMENT,
    Category VARCHAR(50),
    ProductName VARCHAR(100),
    Price DECIMAL(12,2),
    Description TEXT
);

INSERT INTO ShoppingItems (Category, ProductName, Price, Description) VALUES
('Potions', 'Feodovorna Icelatinus', 300000.00, 'Shuts down emotional thinking while retaining pure logic.'),
('Potions', 'Decoctum ad cutem purandam', 200000.00, 'Makes your skin glow flawlessly, no pores or pimples.'),
('Potions', 'Claritas Conscientiae', 400000.00, 'Grants unlimited energy and zero exhaustion, dosage-based.'),
('Potions', 'Suprisum', 500000.00, 'Reveals one of 2000+ products from the future timeline.'),

('Artifacts', 'Crystal Ball', 500000.00, 'Signature piece of Reni, grants omniscient presence.'),
('Artifacts', 'Chrono-Rage', 100000.00, 'Schedules negative emotions for later, preventing breakdowns.'),
('Artifacts', 'Carpetium Magicus', 250000.00, 'A non-living pet carpet that entertains and cleans.'),
('Artifacts', 'Heartender', 90000.00, 'Induces real-adjacent hallucinations; VR alternative, still in testing.'),

('Teleportation', 'Spell – 100 km radius', 500000.00, 'Instantly jump across cities within 100 km.'),
('Teleportation', 'Spell – 1000 km radius', 1000000.00, 'Travel across states or countries in seconds.'),
('Teleportation', 'Spell – 50,000 km radius', 10000000.00, 'Cross continents and oceans — no passport required.'),

('Maps', 'Real-World Holographic Map', 50000.00, 'Displays your current location holographically in real time.'),
('Maps', 'Object Finder Map', 200000.00, 'Finds objects connected to your brain in seconds, showing exact location.'),
('Maps', 'Exotic Creature Finder Map', 400000.00, 'Tracks plants or animals you specify, updating their positions in real time.');

USE shoppingdb;

-- Drop if exists for clean re-run
DROP TABLE IF EXISTS CustomerData;

-- Create CustomerData table
CREATE TABLE CustomerData (
    CustomerId INT,
    ProductId INT,
    ProductCategory VARCHAR(50),
    ProductPrice DECIMAL(12,2),
    Views INT,
    CartAdds INT,
    Purchases INT,
    PreviousPurchases INT,
    PRIMARY KEY (CustomerId, ProductId),
    FOREIGN KEY (ProductId) REFERENCES ShoppingItems(ProductId)
);

-- Insert sample customer-product interactions
INSERT INTO CustomerData (CustomerId, ProductId, ProductCategory, ProductPrice, Views, CartAdds, Purchases, PreviousPurchases) VALUES
(1, 1, 'Potions', 300000.00, 12, 4, 2, 1),
(1, 2, 'Potions', 200000.00, 8, 2, 1, 0),
(1, 5, 'Artifacts', 500000.00, 5, 1, 0, 0),
(2, 3, 'Potions', 400000.00, 15, 6, 3, 2),
(2, 6, 'Artifacts', 100000.00, 10, 3, 2, 1),
(2, 9, 'Teleportation', 500000.00, 3, 1, 0, 0),
(3, 4, 'Potions', 500000.00, 20, 8, 5, 3),
(3, 7, 'Artifacts', 250000.00, 7, 2, 1, 0),
(3, 13, 'Maps', 200000.00, 9, 3, 2, 1),
(4, 8, 'Artifacts', 90000.00, 6, 2, 1, 0),
(4, 10, 'Teleportation', 1000000.00, 2, 1, 0, 0),
(4, 12, 'Maps', 50000.00, 12, 5, 3, 2),
(5, 11, 'Teleportation', 10000000.00, 1, 0, 0, 0),
(5, 14, 'Maps', 400000.00, 4, 1, 0, 0);
