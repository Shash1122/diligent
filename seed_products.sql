-- Insert categories
INSERT INTO categories (category_name) VALUES
('Electronics'),
('Books'),
('Clothing'),
('Home Goods');

-- Insert products
INSERT INTO products (product_name, description, price, stock, category_id) VALUES
('Laptop', 'A high-performance laptop', 1200.00, 50, 1),
('Smartphone', 'A latest model smartphone', 800.00, 150, 1),
('Headphones', 'Noise-cancelling headphones', 150.00, 300, 1),
('The Great Gatsby', 'A classic novel', 15.00, 500, 2),
('To Kill a Mockingbird', 'A classic novel', 15.00, 500, 2),
('1984', 'A classic novel', 15.00, 500, 2),
('T-Shirt', 'A plain t-shirt', 20.00, 1000, 3),
('Jeans', 'A pair of denim jeans', 50.00, 800, 3),
('Jacket', 'A stylish jacket', 100.00, 400, 3),
('Coffee Maker', 'An automatic coffee maker', 60.00, 200, 4),
('Blender', 'A powerful blender', 40.00, 250, 4),
('Toaster', 'A 4-slice toaster', 30.00, 350, 4),
('Desk Lamp', 'A modern desk lamp', 25.00, 450, 4),
('Mouse', 'A wireless mouse', 20.00, 600, 1),
('Keyboard', 'A mechanical keyboard', 70.00, 400, 1);
