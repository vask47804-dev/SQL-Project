# SQL-Project
Related tables and SQL Queries
CREATE TABLE MenuItems (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Availability BOOLEAN
);
CREATE TABLE Numbers (n INT PRIMARY KEY);
-- Fill Numbers table with values 1 to 500
INSERT INTO Numbers (n)
SELECT ones.n + tens.n*10 + hundreds.n*100 + 1 AS num
FROM (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
      UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) ones
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) tens
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) hundreds
WHERE ones.n + tens.n*10 + hundreds.n*100 < 500;
INSERT INTO MenuItems (ItemID, ItemName, Category, Price, Availability)
SELECT n,
       CONCAT('Dish ', n),
       CASE WHEN n % 4 = 0 THEN 'Starter'
            WHEN n % 4 = 1 THEN 'Main'
            WHEN n % 4 = 2 THEN 'Dessert'
            ELSE 'Beverage' END,
       ROUND(RAND() * 500, 2),
       IF(n % 2 = 0, TRUE, FALSE)
FROM Numbers
WHERE n <= 500;
select * from menuitems;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Email VARCHAR(100),
    LoyaltyPoints INT
);
CREATE TABLE Numbers1 (n INT PRIMARY KEY);

-- Fill Numbers table with values 1 to 500
INSERT INTO Numbers1 (n)
SELECT ones.n + tens.n*10 + hundreds.n*100 + 1 AS num
FROM (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
      UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) ones
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) tens
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) hundreds
WHERE ones.n + tens.n*10 + hundreds.n*100 < 500;
INSERT INTO Customers (CustomerID, Name, Phone, Email, LoyaltyPoints)
SELECT n,
       CONCAT('Customer ', n),
       CONCAT('90000', LPAD(n, 5, '0')),
       CONCAT('customer', n, '@mail.com'),
       (n * 5) % 100
FROM Numbers1;
select * from customers;
CREATE TABLE TableBookings (
    TableID INT PRIMARY KEY,
    CustomerID INT,
    BookingDateTime DATETIME,
    Seats INT,
    Status VARCHAR(20)
);
CREATE TABLE Numbers2 (n INT PRIMARY KEY);

-- Fill Numbers table with values 1 to 100
INSERT INTO Numbers2 (n)
SELECT ones.n + tens.n*10 + 1 AS num
FROM (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
      UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) ones
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) tens
WHERE ones.n + tens.n*10 < 100;
INSERT INTO TableBookings (TableID, CustomerID, BookingDateTime, Seats, Status)
SELECT n,
       (n % 500) + 1,  -- links to Customers table (assuming 500 customers exist)
       NOW() + INTERVAL n HOUR,
       (n % 6) + 2,    -- seats between 2 and 7
       CASE WHEN n % 3 = 0 THEN 'Reserved'
            WHEN n % 3 = 1 THEN 'Occupied'
            ELSE 'Cancelled' END
FROM Numbers2
WHERE n <= 100;
select * from tablebookings;
CREATE TABLE CustomerOrders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    TableID INT,
    OrderDateTime DATETIME,
    Status VARCHAR(20)
);
CREATE TABLE Numbers3 (n INT PRIMARY KEY);

-- Fill Numbers table with values 1 to 2500
INSERT INTO Numbers3 (n)
SELECT ones.n + tens.n*10 + hundreds.n*100 + thousands.n*1000 + 1 AS num
FROM (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
      UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) ones
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) tens
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) hundreds
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2) thousands
WHERE ones.n + tens.n*10 + hundreds.n*100 + thousands.n*1000 < 2500;
INSERT INTO CustomerOrders (OrderID, CustomerID, TableID, OrderDateTime, Status)
SELECT n,
       (n % 500) + 1,   -- links to Customers table (assuming 500 customers exist)
       (n % 100) + 1,   -- links to TableBookings table (assuming 100 tables exist)
       NOW() - INTERVAL n MINUTE,
       CASE WHEN n % 3 = 0 THEN 'Pending'
            WHEN n % 3 = 1 THEN 'Served'
            ELSE 'Completed' END
FROM Numbers3
WHERE n <= 2500;
select * from customerorders;
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ItemID INT,
    Quantity INT,
    Subtotal DECIMAL(10,2)
);
CREATE TABLE Numbers4 (n INT PRIMARY KEY);

-- Fill Numbers table with values 1 to 2000
INSERT INTO Numbers4 (n)
SELECT ones.n + tens.n*10 + hundreds.n*100 + thousands.n*1000 + 1 AS num
FROM (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
      UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) ones
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) tens
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) hundreds
CROSS JOIN (SELECT 0 n UNION SELECT 1) thousands
WHERE ones.n + tens.n*10 + hundreds.n*100 + thousands.n*1000 < 2000;
INSERT INTO OrderDetails (OrderDetailID, OrderID, ItemID, Quantity, Subtotal)
SELECT n,
       (n % 2500) + 1,   -- links to CustomerOrders (2,500 records)
       (n % 500) + 1,    -- links to MenuItems (500 records)
       (n % 5) + 1,      -- quantity between 1 and 5
       ROUND(((n % 500) + 50) * ((n % 5) + 1), 2)
FROM Numbers4
WHERE n <= 2000;
select * from orderdetails;
CREATE TABLE Bills (
    BillID INT PRIMARY KEY,
    OrderID INT,
    TotalAmount DECIMAL(10,2),
    PaymentMethod VARCHAR(20),
    PaymentStatus VARCHAR(20)
);
CREATE TABLE Numbers5 (n INT PRIMARY KEY);

-- Fill Numbers table with values 1 to 400
INSERT INTO Numbers5 (n)
SELECT ones.n + tens.n*10 + hundreds.n*100 + 1 AS num
FROM (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
      UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) ones
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) tens
CROSS JOIN (SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) hundreds
WHERE ones.n + tens.n*10 + hundreds.n*100 < 400;
INSERT INTO Bills (BillID, OrderID, TotalAmount, PaymentMethod, PaymentStatus)
SELECT n,
       (n % 2500) + 1,   -- links to CustomerOrders (2,500 records)
       ROUND(RAND() * 2000, 2), -- random bill amount up to 2000
       CASE WHEN n % 3 = 0 THEN 'Cash'
            WHEN n % 3 = 1 THEN 'Card'
            ELSE 'UPI' END,
       CASE WHEN n % 2 = 0 THEN 'Paid'
            ELSE 'Pending' END
FROM Numbers5
WHERE n <= 400;
select * from bills;

SQL Queries-

SELECT * FROM MenuItems;

SELECT Name, Email FROM Customers;

SELECT * FROM TableBookings WHERE Status = 'Reserved';

SELECT * FROM CustomerOrders WHERE Status = 'Pending';

SELECT * FROM Bills WHERE PaymentStatus = 'Paid';

SELECT ItemName, Price FROM MenuItems WHERE Price > 300;

SELECT Name, LoyaltyPoints FROM Customers WHERE LoyaltyPoints > 50;

SELECT * FROM TableBookings WHERE Seats > 5;

SELECT * FROM Bills WHERE PaymentMethod = 'Card';

SELECT * FROM CustomerOrders 
WHERE OrderDateTime >= NOW() - INTERVAL 60 MINUTE;

SELECT o.OrderID, c.Name, o.Status
FROM CustomerOrders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

SELECT d.OrderDetailID, m.ItemName, d.Quantity, d.Subtotal
FROM OrderDetails d
JOIN MenuItems m ON d.ItemID = m.ItemID;

SELECT b.BillID, c.Name, b.TotalAmount, b.PaymentStatus
FROM Bills b
JOIN CustomerOrders o ON b.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID;

SELECT t.TableID, c.Name, t.Status
FROM TableBookings t
JOIN Customers c ON t.CustomerID = c.CustomerID;

SELECT o.OrderID, t.Status, o.OrderDateTime
FROM CustomerOrders o
JOIN TableBookings t ON o.TableID = t.TableID;

SELECT COUNT(*) AS TotalCustomers FROM Customers;

SELECT AVG(Price) AS AvgPrice FROM MenuItems;

SELECT SUM(TotalAmount) AS TotalRevenue FROM Bills;

SELECT COUNT(*) AS CompletedOrders 
FROM CustomerOrders WHERE Status = 'Completed';

SELECT MAX(TotalAmount) AS MaxBill FROM Bills;

SELECT CustomerID, COUNT(*) AS TotalOrders
FROM CustomerOrders
GROUP BY CustomerID;

SELECT PaymentMethod, AVG(TotalAmount) AS AvgAmount
FROM Bills
GROUP BY PaymentMethod;

SELECT Name, LoyaltyPoints
FROM Customers
ORDER BY LoyaltyPoints DESC
LIMIT 5;

SELECT Status, COUNT(*) AS CountBookings
FROM TableBookings
GROUP BY Status;

SELECT Category, MAX(Price) AS MaxPrice
FROM MenuItems
GROUP BY Category;

SELECT o.OrderID, c.Name, t.Status
FROM CustomerOrders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN TableBookings t ON o.TableID = t.TableID;

SELECT b.BillID, b.TotalAmount, o.Status, c.Name
FROM Bills b
JOIN CustomerOrders o ON b.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID;

SELECT DISTINCT m.ItemName
FROM OrderDetails d
JOIN CustomerOrders o ON d.OrderID = o.OrderID
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN MenuItems m ON d.ItemID = m.ItemID
WHERE c.Name = 'Customer 10';

SELECT c.CustomerID, c.Name, SUM(b.TotalAmount) AS TotalSpent
FROM Customers c
JOIN CustomerOrders o ON c.CustomerID = o.CustomerID
JOIN Bills b ON o.OrderID = b.OrderID
GROUP BY c.CustomerID, c.Name;

SELECT o.OrderID, COUNT(d.ItemID) AS ItemCount
FROM CustomerOrders o
JOIN OrderDetails d ON o.OrderID = d.OrderID
GROUP BY o.OrderID
HAVING COUNT(d.ItemID) > 3;

SELECT Name
FROM Customers
WHERE CustomerID IN (
    SELECT o.CustomerID
    FROM CustomerOrders o
    JOIN Bills b ON o.OrderID = b.OrderID
    GROUP BY o.CustomerID
    HAVING SUM(b.TotalAmount) > 1000
);

SELECT ItemName
FROM MenuItems
WHERE ItemID NOT IN (
    SELECT DISTINCT ItemID FROM OrderDetails
);

SELECT Name
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM TableBookings
    GROUP BY CustomerID
    HAVING COUNT(*) > 5
);

SELECT o.CustomerID, MAX(o.OrderDateTime) AS LatestOrder
FROM CustomerOrders o
GROUP BY o.CustomerID;

SELECT AVG(b.TotalAmount) AS AvgBill
FROM Bills b
JOIN CustomerOrders o ON b.OrderID = o.OrderID
WHERE o.CustomerID IN (
    SELECT CustomerID
    FROM CustomerOrders
    GROUP BY CustomerID
    HAVING COUNT(*) > 10
);

SELECT c.CustomerID, c.Name, SUM(b.TotalAmount) AS TotalSpent,
       RANK() OVER (ORDER BY SUM(b.TotalAmount) DESC) AS RankOrder
FROM Customers c
JOIN CustomerOrders o ON c.CustomerID = o.CustomerID
JOIN Bills b ON o.OrderID = b.OrderID
GROUP BY c.CustomerID, c.Name;

SELECT m.ItemName, SUM(d.Quantity) AS TotalOrdered
FROM OrderDetails d
JOIN MenuItems m ON d.ItemID = m.ItemID
GROUP BY m.ItemName
ORDER BY TotalOrdered DESC
LIMIT 1;

SELECT t.TableID, COUNT(o.OrderID) AS TotalOrders
FROM TableBookings t
JOIN CustomerOrders o ON t.TableID = o.TableID
GROUP BY t.TableID
ORDER BY TotalOrders DESC
LIMIT 1;

SELECT DISTINCT c.Name
FROM Customers c
JOIN TableBookings t ON c.CustomerID = t.CustomerID
WHERE c.CustomerID IN (
    SELECT CustomerID FROM TableBookings WHERE Status = 'Reserved'
)
AND c.CustomerID IN (
    SELECT CustomerID FROM TableBookings WHERE Status = 'Cancelled'
);

SELECT DATE(OrderDateTime) AS OrderDate, SUM(b.TotalAmount) AS DailyRevenue
FROM CustomerOrders o
JOIN Bills b ON o.OrderID = b.OrderID
GROUP BY DATE(OrderDateTime)
ORDER BY OrderDate;



