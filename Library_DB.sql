-- CREATE TABLE

CREATE TABLE library (
    library_id INT AUTO_INCREMENT,
    library_name VARCHAR(30),
    address VARCHAR(40),
    postal_code VARCHAR(6),
    city VARCHAR(20),
    province VARCHAR(4),
    country VARCHAR (4),
    phone_number BIGINT,
    hours_of_service VARCHAR(100),
    PRIMARY KEY(library_id)
) AUTO_INCREMENT = 100;

CREATE TABLE book_info (
    book_info_id INT AUTO_INCREMENT,
    title VARCHAR(30),
    genre VARCHAR(20),
    author_name VARCHAR(30),
    publication_year INT,
    PRIMARY KEY(book_info_id)
    );

CREATE TABLE book_copy (
	library_id INT,
    book_info_id INT,
    book_copy_id INT AUTO_INCREMENT,
    status VARCHAR(1), -- A-Available, B-Borrowed, R-Reserved, M-Missing
    PRIMARY KEY(book_copy_id),
    FOREIGN KEY(library_id) REFERENCES library(library_id) ON DELETE SET NULL,
    FOREIGN KEY(book_info_id) REFERENCES book_info(book_info_id) ON DELETE CASCADE
    ) AUTO_INCREMENT = 1000000000;

CREATE TABLE member (
    member_id INT AUTO_INCREMENT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    joined_year INT,
    PRIMARY KEY(member_id)
) AUTO_INCREMENT = 100000;


CREATE TABLE borrow (
    borrow_id INT AUTO_INCREMENT,
    member_id INT,
    book_copy_id INT,
    borrowed_date DATE,
    returned_date DATE,
    times_renewed INT,
    PRIMARY KEY(borrow_id),
    FOREIGN KEY(member_id) REFERENCES member(member_id) ON DELETE CASCADE,
    FOREIGN KEY(book_copy_id) REFERENCES book_copy(book_copy_id) ON DELETE CASCADE
) AUTO_INCREMENT = 5000;


CREATE TABLE reserve (
    reserve_id INT AUTO_INCREMENT,
    member_id INT,
    book_copy_id INT,
    reservation_date DATE,
    PRIMARY KEY(reserve_id),
    FOREIGN KEY(member_id) REFERENCES member(member_id) ON DELETE CASCADE,
    FOREIGN KEY(book_copy_id) REFERENCES book_copy(book_copy_id) ON DELETE CASCADE
) AUTO_INCREMENT 1000;

-- INSERT VALUES

INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Toronto Public Library', '155 Bonis Avenue', 'M1T3W6', 'Toronto', 'ON', 'CA', 4163968943, 'Mon-Fri: 9:00am-8:30pm, Sat: 9:00am-5:00pm, Sun: 1:30pm-5:00pm');
INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Toronto Public Library', '1515 Albion Road', 'M9V1B2', 'Toronto', 'ON', 'CA', 4163945170, 'Mon-Fri: 9:00am-8:30pm, Sat: 9:00am-5:00pm, Sun: 1:30pm-5:00pm');
INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Toronto Public Library', '20 Covington Road', 'M6A3C1', 'Toronto', 'ON', 'CA', 4163955440, 'Mon-Fri: 9:00am-8:30pm, Sat: 9:00am-5:00pm, Sun: 1:30pm-5:00pm');
INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Toronto Public Library', '2161 Queen Street East', 'M4L1J1', 'Toronto', 'ON', 'CA', 4163937703, 'Mon-Thu: 9:00am-8:30pm, Fri-Sat: 9:00am-5:00pm, Sun: Closed');
INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Markham Public Library', '3990 Major Mackenzie Drive East', 'L6C1P8', 'Markham', 'ON', 'CA', 9055137977, 'Mon-Thu: 9:30am-9:00pm, Fri: 9:30am-6:00pm, Sat: 9:00am-5:00pm, Sun: 1:00pm-5:00pm');
INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Markham Public Library', '3201 Bur Oak Avenue', 'L6B0T2', 'Markham', 'ON', 'CA', 9055137977, 'Mon-Fri: 10:00am-6:00pm, Sat: 9:00am-5:00pm, Sun: Closed');
INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Richmond Hill Public Library', '1 Atkinson Street', 'L4C0H5', 'Richmond Hill', 'ON', 'CA', 9058849288, 'Mon-Thu: 9:30am-9:00pm, Fri: 9:30am-6:00pm, Sat: 10:00am-5:00pm, Sun: 12:00pm-5:00pm');
INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Richmond Hill Public Library', '34 Regatta Avenue', 'L4E4R1', 'Richmond Hill', 'ON', 'CA', 9057735533, 'Mon-Thu: 10:00am-9:00pm, Fri: 10:00am-6:00pm, Sat: 10:00am-5:00pm, Sun: 12:00pm-5:00pm');
INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Richmond Hill Public Library', '1 William F. Bell Parkway', 'L4S2T9', 'Richmond Hill', 'ON', 'CA', 9057800711, 'Mon-Thu: 9:30am-9:00pm, Fri: 9:30am-6:00pm, Sat: 10:00am-5:00pm, Sun: 12:00pm-5:00pm');
INSERT INTO library(library_name, address, postal_code, city, province, country, phone_number, hours_of_service) VALUES('Richmond Hill Public Library', '40 Pearson Avenue', 'L4C6T7', 'Richmond Hill', 'ON', 'CA', 9058892847, 'Tue-Wed: 10:00am-8:00pm, Thur-Fri: 10:00am-6:00pm, Sat: 10:00am-5:00pm, Sun-Mon: Closed');


INSERT INTO book_info(title, genre, author_name, publication_year) VALUES('P.S. I LIKE YOU', 'Romance', 'Kasie West', 2016);
INSERT INTO book_info(title, genre, author_name, publication_year) VALUES('BIG NATE BLASTS OFF', 'Humor', 'Lincoln Peirce', 2016);
INSERT INTO book_info(title, genre, author_name, publication_year) VALUES('The TWELVE DOGS of CHRISTMAS', 'Mystery', 'David Rosenfelt', 2016);
INSERT INTO book_info(title, genre, author_name, publication_year) VALUES('STARTERS', 'Science Fiction', 'Lissa Price', 2012);
INSERT INTO book_info(title, genre, author_name, publication_year) VALUES('ENDERS', 'Science Fiction', 'Lissa Price', 2012);
INSERT INTO book_info(title, genre, author_name, publication_year) VALUES('TWILIGHT', 'Romance', 'Stephenie Meyer', 2005);


INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(104, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(105, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 1, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(104, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(105, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(105, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 2, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(104, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 3, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(104, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(104, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(105, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 4, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(104, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(104, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(105, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 5, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(100, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(101, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(102, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(103, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(104, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(105, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(106, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(107, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(108, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 6, 'A');
INSERT INTO book_copy(library_id, book_info_id, status) VALUES(109, 6, 'A');




INSERT INTO member(first_name, last_name, joined_year) VALUES('Timmy', 'Chen', 2019);
INSERT INTO member(first_name, last_name, joined_year) VALUES('John', 'Kim', 2019);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Karrie', 'Chan', 2019);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Melissa', 'White', 2019);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Kimmy', 'Wong', 2020);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Lance', 'Carti', 2020);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Johnathan', 'Fong', 2020);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Kevin', 'Tong', 2020);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Jake', 'Chen', 2020);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Emily', 'Kim', 2021);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Karen', 'Wen', 2021);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Moses', 'Park', 2021);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Luke', 'Li', 2021);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Anthony', 'Macros', 2021);
INSERT INTO member(first_name, last_name, joined_year) VALUES('July', 'Wang', 2021);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Cici', 'Chang', 2022);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Anna', 'Liu', 2022);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Maple', 'Li', 2022);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Jack', 'Wang', 2022);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Jone', 'Cheng', 2022);
INSERT INTO member(first_name, last_name, joined_year) VALUES('Claude', 'Li', 2022);


INSERT INTO borrow(member_id, book_copy_id, borrowed_date, returned_date, times_renewed) VALUES(100000, 1000000005, '2022-01-01', '2022-01-28', 1);
INSERT INTO borrow(member_id, book_copy_id, borrowed_date, returned_date, times_renewed) VALUES(100000, 1000000029, '2022-01-01', '2022-01-28', 1);
INSERT INTO borrow(member_id, book_copy_id, borrowed_date, returned_date, times_renewed) VALUES(100000, 1000000067, '2022-01-01', '2022-01-28', 1);
INSERT INTO borrow(member_id, book_copy_id, borrowed_date, returned_date, times_renewed) VALUES(100000, 1000000080, '2022-01-01', '2022-01-28', 1);
INSERT INTO borrow(member_id, book_copy_id, borrowed_date, returned_date, times_renewed) VALUES(100000, 1000000102, '2022-01-01', '2022-01-28', 1);
INSERT INTO borrow(member_id, book_copy_id, borrowed_date, returned_date, times_renewed) VALUES(100002, 1000000003, '2022-05-07', NULL, 0);
INSERT INTO borrow(member_id, book_copy_id, borrowed_date, returned_date, times_renewed) VALUES(100002, 1000000069, '2022-07-05', NULL, 0);
INSERT INTO borrow(member_id, book_copy_id, borrowed_date, returned_date, times_renewed) VALUES(100003, 1000000035, '2022-07-14', NULL, 0);



INSERT INTO reserve(member_id, book_copy_id, reservation_date) VALUES(100005, 1000000002, '2022-07-21');
INSERT INTO reserve(member_id, book_copy_id, reservation_date) VALUES(100007, 1000000006, '2022-07-24');
INSERT INTO reserve(member_id, book_copy_id, reservation_date) VALUES(100007, 1000000001, '2022-07-23');


-- REPORT

-- Top 5 Library Most Books
SELECT l.*, r.total 
FROM (SELECT library_id, COUNT(*) Total
FROM book_copy
GROUP BY library_id
ORDER BY total DESC
LIMIT 5) r
JOIN library l ON r.library_id = l.library_id;



-- Top 10 Members Most Borrowed Books
SELECT m.*, ten.Total
FROM (SELECT b.member_id, COUNT(*) Total
FROM borrow b
WHERE b.returned_date IS NULL
GROUP BY b.member_id
ORDER BY total DESC
LIMIT 10) ten
JOIN member m ON m.member_id = ten.member_id;

-- Expiried bookks

SELECT bc.book_copy_id, bi.title, bi.genre, bi.author_name, bi.publication_year, m.member_id, m.first_name, m.last_name, l.library_name, e.borrowed_date
FROM ( SELECT * FROM borrow b
WHERE DATE_ADD(current_date, INTERVAL -2 WEEK) > borrowed_date AND returned_date IS NULL AND times_renewed = 0
OR DATE_ADD(current_date, INTERVAL -4 WEEK) > borrowed_date AND returned_date IS NULL AND times_renewed BETWEEN 0 AND 1
OR DATE_ADD(current_date, INTERVAL -6 WEEK) > borrowed_date AND returned_date IS NULL AND times_renewed BETWEEN 0 AND 2
OR DATE_ADD(current_date, INTERVAL -8 WEEK) > borrowed_date AND returned_date IS NULL) e
JOIN book_copy bc ON bc.book_copy_id = e.book_copy_id
JOIN book_info bi ON bi.book_info_id = bc.book_info_id
JOIN member m ON m.member_id = e.member_id
JOIN library l ON l.library_id = bc.library_id;
