-- 1️⃣ Create Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- 2️⃣ Create Authors Table
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100)
);

-- 3️⃣ Create Books Table
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    genre VARCHAR(100),
    available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

-- 4️⃣ Create Members Table
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    join_date DATE DEFAULT CURRENT_DATE
);

-- 5️⃣ Create Loans Table
CREATE TABLE loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    issue_date DATE DEFAULT CURRENT_DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- 6️⃣ Insert Sample Data into Authors Table
INSERT INTO authors (name, country) VALUES
('J.K. Rowling', 'United Kingdom'),
('George Orwell', 'United Kingdom'),
('Harper Lee', 'USA');

-- 7️⃣ Insert Sample Data into Books Table
INSERT INTO books (title, author_id, genre, available) VALUES
('Harry Potter', 1, 'Fantasy', TRUE),
('1984', 2, 'Dystopian', TRUE),
('To Kill a Mockingbird', 3, 'Fiction', TRUE);

-- 8️⃣ Insert Sample Data into Members Table
INSERT INTO members (name, email) VALUES
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com');

-- 9️⃣ Insert Sample Data into Loans Table
INSERT INTO loans (member_id, book_id, issue_date, return_date) VALUES
(1, 1, '2024-02-01', '2024-02-15'),
(2, 2, '2024-02-10', NULL); -- Book not yet returned

-- 🔹 Queries for Library Management System

-- 📌 View All Books and Their Authors
SELECT b.title, a.name AS author, b.genre, b.available 
FROM books b
JOIN authors a ON b.author_id = a.author_id;

-- 📌 Check Borrowed Books
SELECT m.name AS member, b.title AS book, l.issue_date, l.return_date 
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id;

-- 📌 Find Available Books
SELECT title FROM books WHERE available = TRUE;

-- 📌 Mark a Book as Returned
UPDATE loans 
SET return_date = CURRENT_DATE 
WHERE loan_id = 2; -- Change 2 to the correct loan_id

-- 📌 Count Total Books in Library
SELECT COUNT(*) AS total_books FROM books;

-- 📌 Find Overdue Books (Borrowed for More Than 14 Days)
SELECT m.name AS member, b.title AS book, l.issue_date, l.return_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b ON l.book_id = b.book_id
WHERE l.return_date IS NULL AND DATEDIFF(CURRENT_DATE, l.issue_date) > 14;
