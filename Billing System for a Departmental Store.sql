-- Create the database
CREATE DATABASE BillingSystemForDeptStore;

-- Use the created database
USE BillingSystemForDeptStore;

-- Create Users table
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role ENUM('Admin', 'Cashier', 'Manager') NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Categories table
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    Description TEXT
);

-- Create Products table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    Description TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Stores table
CREATE TABLE Stores (
    StoreID INT AUTO_INCREMENT PRIMARY KEY,
    StoreName VARCHAR(100) NOT NULL,
    Location VARCHAR(255),
    ManagerID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (ManagerID) REFERENCES Users(UserID)
);

-- Create Sales table
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    SaleDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CustomerID INT,
    StoreID INT,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    PaymentMethod ENUM('Cash', 'Credit Card') NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

-- Create SaleItems table
CREATE TABLE SaleItems (
    SaleItemID INT AUTO_INCREMENT PRIMARY KEY,
    SaleID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    PriceAtSale DECIMAL(10, 2) NOT NULL,
    Subtotal DECIMAL(10, 2) AS (Quantity * PriceAtSale) STORED,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create InventoryMovements table
CREATE TABLE InventoryMovements (
    MovementID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    StoreID INT,
    QuantityChanged INT NOT NULL,
    MovementType ENUM('Sale', 'Return', 'Restock') NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

-- Create Discounts table
CREATE TABLE Discounts (
    DiscountID INT AUTO_INCREMENT PRIMARY KEY,
    DiscountCode VARCHAR(20) NOT NULL UNIQUE,
    Description TEXT,
    DiscountPercentage DECIMAL(5, 2) NOT NULL,
    ValidFrom DATE,
    ValidUntil DATE,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create Returns table
CREATE TABLE Returns (
    ReturnID INT AUTO_INCREMENT PRIMARY KEY,
    SaleID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    ReturnReason TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Insert sample data into Users
INSERT INTO Users (Username, PasswordHash, Role, Email, Phone) VALUES
('admin1', 'hashedpassword1', 'Admin', 'admin1@example.com', '123-456-7890'),
('cashier1', 'hashedpassword2', 'Cashier', 'cashier1@example.com', '123-456-7891'),
('manager1', 'hashedpassword3', 'Manager', 'manager1@example.com', '123-456-7892');

-- Insert sample data into Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Electronics', 'Devices and gadgets'),
('Clothing', 'Apparel and accessories'),
('Groceries', 'Food and household items');

-- Insert sample data into Products
INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity, Description) VALUES
('Laptop', 1, 799.99, 50, 'High performance laptop'),
('T-Shirt', 2, 19.99, 200, 'Cotton t-shirt in various colors'),
('Milk', 3, 1.99, 100, '1 liter of fresh milk');

-- Insert sample data into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('John', 'Doe', 'john.doe@example.com', '987-654-3210', '123 Elm St, Springfield'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3211', '456 Oak St, Springfield');

-- Insert sample data into Stores
INSERT INTO Stores (StoreName, Location, ManagerID) VALUES
('Store A', 'Downtown', 3),
('Store B', 'Uptown', 3);

-- Insert sample data into Sales
INSERT INTO Sales (SaleDate, CustomerID, StoreID, TotalAmount, PaymentMethod) VALUES
('2024-08-01 10:30:00', 1, 1, 819.98, 'Credit Card'),
('2024-08-01 11:00:00', 2, 2, 21.98, 'Cash');

-- Insert sample data into SaleItems
INSERT INTO SaleItems (SaleID, ProductID, Quantity, PriceAtSale) VALUES
(1, 1, 1, 799.99),
(1, 3, 1, 1.99),
(2, 2, 1, 19.99);

-- Insert sample data into InventoryMovements
INSERT INTO InventoryMovements (ProductID, StoreID, QuantityChanged, MovementType) VALUES
(1, 1, -1, 'Sale'),
(3, 1, -1, 'Sale'),
(2, 2, -1, 'Sale');

-- Insert sample data into Discounts
INSERT INTO Discounts (DiscountCode, Description, DiscountPercentage, ValidFrom, ValidUntil) VALUES
('SUMMER20', 'Summer sale discount', 20.00, '2024-07-01', '2024-08-31');

-- Insert sample data into Returns
INSERT INTO Returns (SaleID, ProductID, Quantity, ReturnReason) VALUES
(1, 3, 1, 'Expired milk');

SELECT * FROM Products WHERE CategoryID = 2;

SELECT * FROM Sales WHERE StoreID = 1 AND SaleDate ='2024-08-01 10:30:00' ;

UPDATE Products
SET StockQuantity = StockQuantity - 300
WHERE ProductID = 1;

SELECT * FROM Returns WHERE SaleID = 1;

SELECT SUM(TotalAmount) AS TotalSales
FROM Sales
WHERE StoreID = 2;





