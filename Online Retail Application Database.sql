-- Create the database
CREATE DATABASE OnlineRetailApplicationDatabase;

-- Use the database
USE OnlineRetailApplicationDatabase;


-- Create Roles Table
CREATE TABLE Roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Create Categories Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

-- Create Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Create Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    address TEXT,
    phone_number VARCHAR(15),
    role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Create Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50),
    shipping_address TEXT,
    shipping_method VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Create Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Create Reviews Table
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    user_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Shipping_Methods Table
CREATE TABLE Shipping_Methods (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50) NOT NULL,
    description TEXT,
    cost DECIMAL(10, 2) NOT NULL
);

-- Insert Roles
INSERT INTO Roles (role_name, description) VALUES
('Admin', 'Administrative role with full access'),
('Customer', 'Standard customer role with limited access');

-- Insert Categories
INSERT INTO Categories (name, description) VALUES
('Electronics', 'Devices and gadgets'),
('Clothing', 'Apparel and accessories'),
('Home & Kitchen', 'Furniture and kitchen appliances');

-- Insert Products
INSERT INTO Products (name, description, price, stock_quantity, category_id) VALUES
('Smartphone', 'Latest model with high specs', 699.99, 50, 1),
('Laptop', 'High-performance laptop', 1299.99, 30, 1),
('T-shirt', 'Comfortable cotton t-shirt', 19.99, 100, 2),
('Blender', 'Powerful kitchen blender', 89.99, 20, 3);

-- Insert Shipping Methods
INSERT INTO Shipping_Methods (method_name, description, cost) VALUES
('Standard Shipping', 'Delivered in 5-7 business days', 5.99),
('Express Shipping', 'Delivered in 1-2 business days', 15.99);

-- Insert Users
INSERT INTO Users (username, password, email, address, phone_number, role_id) VALUES
('john_doe', 'password123', 'john@example.com', '123 Elm Street', '555-1234', 2),
('admin_user', 'adminpass', 'admin@example.com', '456 Oak Avenue', '555-5678', 1);

-- Insert Orders
INSERT INTO Orders (user_id, total_amount, status, shipping_address, shipping_method) VALUES
(1, 719.98, 'Processing', '123 Elm Street', 'Standard Shipping'),
(2, 1299.99, 'Completed', '456 Oak Avenue', 'Express Shipping');

-- Insert Order Items
INSERT INTO Order_Items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 699.99),
(1, 4, 1, 89.99),
(2, 2, 1, 1299.99);

-- Insert Payments
INSERT INTO Payments (order_id, amount, payment_method, status) VALUES
(1, 719.98, 'Credit Card', 'Completed'),
(2, 1299.99, 'Credit Card', 'Completed');

-- Insert Reviews
INSERT INTO Reviews (product_id, user_id, rating, comment) VALUES
(1, 1, 5, 'Excellent smartphone with great features!'),
(2, 2, 4, 'Powerful laptop, but a bit expensive.');

SELECT o.order_id, o.order_date, o.total_amount, o.status, o.shipping_address, o.shipping_method
FROM Orders o
WHERE o.user_id = 1; -- Replace 1 with the specific user_id

SELECT SUM(total_amount) AS total_revenue
FROM Orders
WHERE status = 'Completed';

SELECT r.rating, r.comment, u.username
FROM Reviews r
JOIN Users u ON r.user_id = u.user_id
WHERE r.product_id = 1; -- Replace 1 with the specific product_id

SELECT p.product_id, p.name, COUNT(oi.order_id) AS order_count
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY order_count DESC
LIMIT 1;




