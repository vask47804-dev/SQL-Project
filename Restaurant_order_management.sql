use Restaurant_order_management;
--List all menu items.
SELECT * FROM MenuItems;
--Show names and emails of all customers.
SELECT Name, Email FROM Customers;
--Find all table bookings with status 'Reserved'.
SELECT * FROM TableBookings WHERE Status = 'Reserved';
--Get all orders that are still 'Pending'.
SELECT * FROM CustomerOrders WHERE Status = 'Pending';
--Display all bills that are marked 'Paid'.
SELECT * FROM Bills WHERE PaymentStatus = 'Paid';
--Find menu items priced above 300.
SELECT ItemName, Price FROM MenuItems WHERE Price > 300;
--List customers with more than 50 loyalty points.
SELECT Name, LoyaltyPoints FROM Customers WHERE LoyaltyPoints > 50;
--Show bookings with more than 5 seats.
SELECT * FROM TableBookings WHERE Seats > 5;
--Get bills paid by 'Card'.
SELECT * FROM Bills WHERE PaymentMethod = 'Card';
--Find orders placed in the last 60 minutes.
SELECT * FROM CustomerOrders WHERE OrderDateTime >= NOW() - INTERVAL 60 MINUTE;
--List orders with customer names.
SELECT o.OrderID, c.Name, o.Status FROM CustomerOrders o JOIN Customers c ON o.CustomerID = c.CustomerID;
--Show order details with item names.
SELECT d.OrderDetailID, m.ItemName, d.Quantity, d.Subtotal FROM OrderDetails d JOIN MenuItems m ON d.ItemID = m.ItemID;
--Get bills with customer names.
SELECT b.BillID, c.Name, b.TotalAmount, b.PaymentStatus FROM Bills b JOIN CustomerOrders o ON b.OrderID = o.OrderID JOIN Customers c ON o.CustomerID = c.CustomerID;
--List bookings with customer names.
SELECT t.TableID, c.Name, t.Status FROM TableBookings t JOIN Customers c ON t.CustomerID = c.CustomerID;
--Find orders with table booking status.
SELECT o.OrderID, t.Status, o.OrderDateTime FROM CustomerOrders o JOIN TableBookings t ON o.TableID = t.TableID;
--Count total customers.
SELECT COUNT(*) AS TotalCustomers FROM Customers;
--Find average price of menu items.
SELECT AVG(Price) AS AvgPrice FROM MenuItems;
--Get total revenue from all bills.
SELECT SUM(TotalAmount) AS TotalRevenue FROM Bills;
--Count how many orders are 'Completed'.
SELECT COUNT(*) AS CompletedOrders FROM CustomerOrders WHERE Status = 'Completed';
--Find the highest bill amount.
SELECT MAX(TotalAmount) AS MaxBill FROM Bills;
--Find the total number of orders placed by each customer.
SELECT CustomerID, COUNT(*) AS TotalOrders FROM CustomerOrders GROUP BY CustomerID;
--Show the average bill amount per payment method.
SELECT PaymentMethod, AVG(TotalAmount) AS AvgAmount FROM Bills GROUP BY PaymentMethod;
--Find the top 5 customers with the highest loyalty points.
SELECT Name, LoyaltyPoints FROM Customers ORDER BY LoyaltyPoints DESC LIMIT 5;
--Get the number of bookings per status.
SELECT Status, COUNT(*) AS CountBookings FROM TableBookings GROUP BY Status;
--Find the most expensive menu item in each category.
SELECT Category, MAX(Price) AS MaxPrice FROM MenuItems GROUP BY Category;
--List all orders with customer names and table booking status.
SELECT o.OrderID, c.Name, t.Status FROM CustomerOrders o JOIN Customers c ON o.CustomerID = c.CustomerID JOIN TableBookings t ON o.TableID = t.TableID;
--Show bills with order status and customer name.
SELECT b.BillID, b.TotalAmount, o.Status, c.Name FROM Bills b JOIN CustomerOrders o ON b.OrderID = o.OrderID JOIN Customers c ON o.CustomerID = c.CustomerID;
--Find all menu items ordered by 'Customer 10'.
SELECT DISTINCT m.ItemName FROM OrderDetails d JOIN CustomerOrders o ON d.OrderID = o.OrderID JOIN Customers c ON o.CustomerID = c.CustomerID JOIN MenuItems m ON d.ItemID = m.ItemID WHERE c.Name = 'Customer 10';
--Get total spending of each customer (sum of bills).
SELECT c.CustomerID, c.Name, SUM(b.TotalAmount) AS TotalSpent FROM Customers c JOIN CustomerOrders o ON c.CustomerID = o.CustomerID JOIN Bills b ON o.OrderID = b.OrderID GROUP BY c.CustomerID, c.Name;
--List orders with more than 3 items.
SELECT o.OrderID, COUNT(d.ItemID) AS ItemCount FROM CustomerOrders o JOIN OrderDetails d ON o.OrderID = d.OrderID GROUP BY o.OrderID HAVING COUNT(d.ItemID) > 3;
-- Find customers who have spent more than 1000 in total.
SELECT Name FROM Customers WHERE CustomerID IN ( SELECT o.CustomerID FROM CustomerOrders o JOIN Bills b ON o.OrderID = b.OrderID GROUP BY o.CustomerID HAVING SUM(b.TotalAmount) > 1000 );
--Get menu items that were never ordered.
SELECT ItemName FROM MenuItems WHERE ItemID NOT IN ( SELECT DISTINCT ItemID FROM OrderDetails );
--Find customers who booked more than 5 tables.
SELECT Name FROM Customers WHERE CustomerID IN ( SELECT CustomerID FROM TableBookings GROUP BY CustomerID HAVING COUNT(*) > 5 );
--Show the latest order placed by each customer.
SELECT o.CustomerID, MAX(o.OrderDateTime) AS LatestOrder FROM CustomerOrders o GROUP BY o.CustomerID;
--Find the average bill amount of customers who have more than 10 orders.
SELECT AVG(b.TotalAmount) AS AvgBill FROM Bills b JOIN CustomerOrders o ON b.OrderID = o.OrderID WHERE o.CustomerID IN ( SELECT CustomerID FROM CustomerOrders GROUP BY CustomerID HAVING COUNT(*) > 10 );
--Rank customers by total spending.
SELECT c.CustomerID, c.Name, SUM(b.TotalAmount) AS TotalSpent, RANK() OVER (ORDER BY SUM(b.TotalAmount) DESC) AS RankOrder FROM Customers c JOIN CustomerOrders o ON c.CustomerID = o.CustomerID JOIN Bills b ON o.OrderID = b.OrderID GROUP BY c.CustomerID, c.Name;
--Find the most popular menu item (highest total quantity ordered).
SELECT m.ItemName, SUM(d.Quantity) AS TotalOrdered FROM OrderDetails d JOIN MenuItems m ON d.ItemID = m.ItemID GROUP BY m.ItemName ORDER BY TotalOrdered DESC LIMIT 1;
--Get the busiest table (most orders linked).
SELECT t.TableID, COUNT(o.OrderID) AS TotalOrders FROM TableBookings t JOIN CustomerOrders o ON t.TableID = o.TableID GROUP BY t.TableID ORDER BY TotalOrders DESC LIMIT 1;
--Find customers who have both 'Reserved' and 'Cancelled' bookings.
SELECT DISTINCT c.Name FROM Customers c JOIN TableBookings t ON c.CustomerID = t.CustomerID WHERE c.CustomerID IN ( SELECT CustomerID FROM TableBookings WHERE Status = 'Reserved' ) AND c.CustomerID IN ( SELECT CustomerID FROM TableBookings WHERE Status = 'Cancelled' );
--Show daily revenue (sum of bills grouped by date).
SELECT DATE(OrderDateTime) AS OrderDate, SUM(b.TotalAmount) AS DailyRevenue FROM CustomerOrders o JOIN Bills b ON o.OrderID = b.OrderID GROUP BY DATE(OrderDateTime) ORDER BY OrderDate;

