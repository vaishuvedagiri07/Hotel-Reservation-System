CREATE DATABASE HotelReservationdbs;
USE HotelReservationdbs;
CREATE TABLE Hotel (
    hotel_id INT PRIMARY KEY,
    hotel_name VARCHAR(100),
    location VARCHAR(100),
    phone VARCHAR(15)
);
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);
CREATE TABLE Room (
    room_id INT PRIMARY KEY,
    hotel_id INT,
    room_number INT,
    room_type VARCHAR(30),
    price DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);
CREATE TABLE Reservation (
    reservation_id INT PRIMARY KEY,
    customer_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    reservation_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_status VARCHAR(20),
    FOREIGN KEY (reservation_id) REFERENCES Reservation(reservation_id)
);
SHOW TABLES;
INSERT INTO Hotel VALUES
(1,'Grand Palace','Indore','9876543210'),
(2,'Royal Stay','Jaipur','9876543211');
INSERT INTO Customer VALUES
(101,'Rahul','9876543212','rahul@gmail.com'),
(102,'Priya','9876543213','priya@gmail.com'),
(103,'Arjun','9876543214','arjun@gmail.com'),
(104,'Sneha','9876543215','sneha@gmail.com');
INSERT INTO Room VALUES
(1,1,101,'Single',1500,'Available'),
(2,1,102,'Double',2500,'Available'),
(3,1,103,'Deluxe',3500,'Available'),
(4,2,201,'Single',1800,'Available'),
(5,2,202,'Suite',5000,'Available');
INSERT INTO Reservation VALUES
(1001,101,1,'2026-11-12','2026-11-14','Confirmed'),
(1002,102,2,'2026-11-15','2026-11-17','Confirmed'),
(1003,103,3,'2026-11-18','2026-11-20','Pending');
SELECT * FROM Hotel;
SELECT * FROM Customer;
SELECT * FROM Room;
SELECT * FROM Reservation;
SELECT * FROM Payment;
INSERT INTO Payment VALUES
(501,1001,3000,'2026-11-10','Paid'),
(502,1002,5000,'2026-11-10','Paid'),
(503,1003,3500,'2026-11-10','Pending');
SELECT * FROM Room
WHERE status = 'Available';
SELECT c.name, r.reservation_id,
       r.check_in, r.check_out, r.status
FROM Customer c
JOIN Reservation r
ON c.customer_id = r.customer_id;
SELECT r.reservation_id, c.name,
       rm.room_number, rm.room_type,
       rm.price, r.check_in, r.check_out
FROM Reservation r
JOIN Customer c
ON r.customer_id = c.customer_id
JOIN Room rm
ON r.room_id = rm.room_id;
SELECT SUM(amount) AS Total_Revenue
FROM Payment
WHERE payment_status = 'Paid';
SELECT * FROM Room
WHERE price > 2500;
SELECT COUNT(*) AS Total_Customers
FROM Customer;
UPDATE Reservation
SET status = 'Confirmed'
WHERE reservation_id = 1003;
UPDATE Reservation
SET status = 'Cancelled'
WHERE reservation_id = 1002;
SELECT c.name, r.reservation_id,
       p.amount, p.payment_status
FROM Payment p
JOIN Reservation r
ON p.reservation_id = r.reservation_id
JOIN Customer c
ON r.customer_id = c.customer_id;
SELECT room_id, COUNT(*) AS Total_Bookings
FROM Reservation
WHERE status <> 'Cancelled'
GROUP BY room_id;
SELECT *
FROM Room
WHERE room_id = 1
AND NOT EXISTS (
    SELECT *
    FROM Reservation
    WHERE Reservation.room_id = Room.room_id
    AND status = 'Confirmed'
    AND check_in < '2026-11-15'
    AND check_out > '2026-11-13'
);

