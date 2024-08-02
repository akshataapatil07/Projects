-- Create the database
CREATE DATABASE WholesaleManagementSystemDB;

-- Use the database
USE WholesaleManagementSystemDB;


-- Create Products Table
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Category VARCHAR(255),
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL
);

-- Create Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(255),
    ContactNumber VARCHAR(20),
    Address TEXT
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Payments Table
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    Status ENUM('Paid', 'Pending') NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Create StockPurchases Table
CREATE TABLE StockPurchases (
    StockPurchaseID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    SupplierID INT,
    PurchaseDate DATE NOT NULL,
    Quantity INT NOT NULL,
    Cost DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Create MonthlyProfit Table
CREATE TABLE MonthlyProfit (
    MonthYear CHAR(7) PRIMARY KEY, -- e.g., '2024-08'
    TotalRevenue DECIMAL(10, 2),
    TotalCost DECIMAL(10, 2),
    NetProfit DECIMAL(10, 2)
);

-- Insert into Products
INSERT INTO Products (ProductName, Category, Price, StockQuantity)
VALUES ('Product A', 'Category 1', 10.00, 100),
       ('Product B', 'Category 2', 15.00, 200);

-- Insert into Suppliers
INSERT INTO Suppliers (SupplierName, ContactPerson, ContactNumber, Address)
VALUES ('Supplier A', 'John Doe', '555-1234', '123 Supplier St.'),
       ('Supplier B', 'Jane Smith', '555-5678', '456 Supplier Ave.');

-- Insert into Customers
INSERT INTO Customers (CustomerName, ContactPerson, ContactNumber, Address)
VALUES ('Customer A', 'Alice Brown', '555-9876', '789 Customer Rd.'),
       ('Customer B', 'Bob White', '555-6543', '321 Customer Ln.');

-- Insert into Orders
INSERT INTO Orders (OrderDate, CustomerID, TotalAmount)
VALUES ('2024-08-01', 1, 25.00),
       ('2024-08-02', 2, 30.00);

-- Insert into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
VALUES (1, 1, 2, 10.00),
       (2, 2, 2, 15.00);

-- Insert into Payments
INSERT INTO Payments (OrderID, PaymentDate, Amount, Status)
VALUES (1, '2024-08-01', 25.00, 'Paid'),
       (2, '2024-08-02', 30.00, 'Pending');

-- Insert into StockPurchases
INSERT INTO StockPurchases (ProductID, SupplierID, PurchaseDate, Quantity, Cost)
VALUES (1, 1, '2024-08-01', 50, 500.00),
       (2, 2, '2024-08-02', 100, 1500.00);
       
SELECT SUM(TotalAmount) AS TotalSales
FROM Orders
WHERE YEAR(OrderDate) = 2024 AND MONTH(OrderDate) = 8;

SELECT ProductName, StockQuantity
FROM Products;

SELECT ProductName, StockQuantity
FROM Products
WHERE StockQuantity < 10;



