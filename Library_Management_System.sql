create database LibraryManagementSystem ;

use LibraryManagementSystem ;

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    status ENUM('available', 'issued') DEFAULT 'available',
    total_copies INT NOT NULL,
    available_copies INT NOT NULL
);


CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    membership_number VARCHAR(50) UNIQUE NOT NULL,
    contact_information VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    date_of_membership DATE NOT NULL
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    user_id INT,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Books (title, author, category, price, total_copies, available_copies)
VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 10.99, 5, 5),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 12.99, 10, 10),
('1984', 'George Orwell', 'Dystopian', 15.99, 8, 8),
('Moby Dick', 'Herman Melville', 'Classic', 9.99, 6, 6),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 14.99, 7, 7),
('Pride and Prejudice', 'Jane Austen', 'Romance', 11.99, 12, 12),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 13.99, 9, 9),
('War and Peace', 'Leo Tolstoy', 'Historical', 19.99, 5, 5),
('The Alchemist', 'Paulo Coelho', 'Adventure', 10.99, 15, 15),
('Ulysses', 'James Joyce', 'Modernist', 17.99, 4, 4),
('Great Expectations', 'Charles Dickens', 'Classic', 16.99, 11, 11);

SELECT * FROM Users;

INSERT INTO Users (name, membership_number, contact_information, email, date_of_membership)
VALUES 
('John Doe', 'M12345', '123 Main St, Anytown, USA', 'john.doe@example.com', '2024-01-01'),
('Jane Smith', 'M12346', '456 Elm St, Anytown, USA', 'jane.smith@example.com', '2024-02-01'),
('Alice Johnson', 'M12347', '789 Oak St, Anytown, USA', 'alice.johnson@example.com', '2024-03-15'),
('Bob Brown', 'M12348', '101 Pine St, Anytown, USA', 'bob.brown@example.com', '2024-04-20'),
('Charlie Davis', 'M12349', '202 Maple St, Anytown, USA', 'charlie.davis@example.com', '2024-05-10'),
('Emily Clark', 'M12350', '303 Birch St, Anytown, USA', 'emily.clark@example.com', '2024-06-05'),
('Frank Miller', 'M12351', '404 Cedar St, Anytown, USA', 'frank.miller@example.com', '2024-07-15'),
('Grace Wilson', 'M12352', '505 Walnut St, Anytown, USA', 'grace.wilson@example.com', '2024-08-01'),
('Henry Lee', 'M12353', '606 Ash St, Anytown, USA', 'henry.lee@example.com', '2024-09-12'),
('Ivy Walker', 'M12354', '707 Cherry St, Anytown, USA', 'ivy.walker@example.com', '2024-10-23'),
('Jack Young', 'M12356', '808 Willow St, Anytown, USA', 'jack.young@example.com', '2024-11-30');


INSERT INTO Transactions (book_id, user_id, issue_date, due_date, return_date)
VALUES 
(1, 2, '2024-07-05', '2024-07-20', NULL),
(2, 3, '2024-07-06', '2024-07-21', '2024-07-18'),
(3, 4, '2024-07-07', '2024-07-22', NULL),
(4, 5, '2024-07-08', '2024-07-23', '2024-07-20'),
(5, 6, '2024-07-09', '2024-07-24', NULL),
(6, 7, '2024-07-10', '2024-07-25', '2024-07-22'),
(7, 8, '2024-07-11', '2024-07-26', NULL),
(8, 9, '2024-07-12', '2024-07-27', NULL),
(9, 10, '2024-07-13', '2024-07-28', '2024-07-25'),
(10, 1, '2024-07-14', '2024-07-29', NULL);

SELECT * FROM Books WHERE status = 'available';

SELECT * FROM Books WHERE author = 'George Orwell';

SELECT * FROM Books WHERE title LIKE '%Moby%';

SELECT * FROM Books WHERE category = 'Fiction';

SELECT available_copies FROM Books WHERE title = '1984';

SELECT Users.name, Users.email, Transactions.book_id, Transactions.issue_date, Transactions.due_date
FROM Users
JOIN Transactions ON Users.user_id = Transactions.user_id
WHERE Transactions.return_date IS NULL;

SELECT Books.title, Transactions.issue_date, Transactions.due_date, Transactions.return_date
FROM Books
JOIN Transactions ON Books.book_id = Transactions.book_id
WHERE Transactions.user_id = 1;

SELECT Books.title, Users.name, Transactions.due_date
FROM Books
JOIN Transactions ON Books.book_id = Transactions.book_id
JOIN Users ON Users.user_id = Transactions.user_id
WHERE Transactions.due_date < CURDATE() AND Transactions.return_date IS NULL;

SELECT COUNT(*) AS total_books FROM Books;

SELECT category, COUNT(*) AS available_books
FROM Books
WHERE status = 'available'
GROUP BY category;

UPDATE Books
SET status = CASE WHEN available_copies = 1 THEN 'issued' ELSE 'available' END,
    available_copies = available_copies - 1
WHERE book_id = 1;

UPDATE Books
SET status = 'available',
    available_copies = available_copies + 1
WHERE book_id = 1;

INSERT INTO Books (title, author, category, price, total_copies, available_copies)
VALUES ('New Book Title', 'Author Name', 'Category', 20.99, 5, 5);

INSERT INTO Users (name, membership_number, contact_information, email, date_of_membership)
VALUES ('New User', 'M12356', '123 New St, Anytown, USA', 'new.user@example.com', '2024-08-01');

INSERT INTO Transactions (book_id, user_id, issue_date, due_date)
VALUES (1, 2, '2024-07-15', '2024-07-30');


