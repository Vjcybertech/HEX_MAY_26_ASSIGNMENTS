CREATE DATABASE ECOMMERCE_ASSIGNMENT_DB

use ECOMMERCE_ASSIGNMENT_DB

CREATE TABLE Customer
( CustomerId INT PRIMARY KEY IDENTITY(1,1),
CustomerName VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,
MobileNo VARCHAR(15) NOT NULL,
City VARCHAR(50) NOT NULL,
Address VARCHAR(255),
IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE() );

CREATE TABLE Seller
( SellerId INT PRIMARY KEY IDENTITY(1,1),
SellerName VARCHAR(100) NOT NULL,
Email VARCHAR(100) UNIQUE NOT NULL,
MobileNo VARCHAR(15) NOT NULL,
City VARCHAR(50),
Rating DECIMAL(2,1),
IsActive BIT DEFAULT 1 );

CREATE TABLE Product ( ProductId INT PRIMARY KEY IDENTITY(1,1),
ProductName VARCHAR(100) NOT NULL,
Category VARCHAR(50) NOT NULL,
Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
StockQuantity INT CHECK (StockQuantity >= 0),
SellerId INT,
CreatedDate DATETIME DEFAULT GETDATE(),
);

Alter table Product Add Constraint FK_Product_Seller FOREIGN KEY (SellerId) REFERENCES Seller(SellerId)

CREATE TABLE Orders ( 
OrderId INT PRIMARY KEY IDENTITY(1,1),
CustomerId INT,
OrderDate DATETIME DEFAULT GETDATE(),
OrderStatus VARCHAR(50) DEFAULT 'Pending',
PaymentMode VARCHAR(50),
DeliveryCity VARCHAR(50));

Alter table Orders Add CONSTRAINT FK_Orders_Customer FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)

CREATE TABLE OrderItem (
OrderItemId INT PRIMARY KEY IDENTITY(1,1),
OrderId INT,
ProductId INT,
Quantity INT NOT NULL CHECK (Quantity > 0),
UnitPrice DECIMAL(10,2) NOT NULL)

Alter table OrderItem ADD CONSTRAINT FK_OrderItem_Order FOREIGN KEY (OrderId) REFERENCES Orders(OrderId)

Alter table OrderItem ADD CONSTRAINT FK_OrderItem_Product FOREIGN KEY (ProductId) REFERENCES Product(ProductId)



ALTER TABLE Customer ADD CONSTRAINT UQ_Customer_Email UNIQUE (Email);

ALTER TABLE Seller ADD CONSTRAINT UQ_Seller_Email UNIQUE (Email);



--insert query

INSERT INTO Customer (CustomerName, Email, MobileNo, City, Address)
VALUES 
('Dhoni','dhoni@gmail.com','9876543210','Chennai','Anna Nagar'),
('Rajpriyan','priyan@gmail.com','9876543211','Bangalore','Ashok nagar'),
('Sanjusamson','sanju@gmail.com','9876543212','Hyderabad','K.K Nager'),
('Jadeja','jaddu@gmail.com','9876543213','Chennai','T Nagar'),
('Raina','rain@gmail.com','9876543214','Chennai','vadapalani')

select * from Customer

INSERT INTO Seller (SellerName, Email, MobileNo, City, Rating) 
VALUES ('Tech Store','techworld@gmail.com','9000000001','Chennai',4.5),
('Mobile Hub','mobilehub@gmail.com','9000000002','Bangalore',4.2),
('Laptop Store','laptop@gmail.com','9000000003','Hyderabad',4.7),
('Digital Mart','dmart@gmail.com','9000000004','Delhi',4.1);

select * from Seller 

INSERT INTO Product (ProductName, Category, Price, StockQuantity, SellerId)
VALUES ('iPhone 15','Mobile',80000,15,1), 
('Samsung Galaxy S24','Mobile',70000,12,2),
('OnePlus Phone','Mobile',45000,8,2),
('Dell Inspiron','Laptop',60000,10,3),
('HP Pavilion','Laptop',75000,5,3),
('Lenovo ThinkPad','Laptop',55000,7,4),
('Boat Headset','Accessories',3000,25,1),
('Smart Watch','Accessories',12000,20,4);

select * from Product



INSERT INTO Orders (CustomerId, PaymentMode, DeliveryCity, OrderStatus) 
VALUES (1,'UPI','Chennai','Delivered'),
(2,'Card','Bangalore','Pending'),
(3,'Cash On Delivery','Hyderabad','Shipped'),
(1,'UPI','Chennai','Delivered'),
(4,'Card','Chennai','Pending');

select * from Orders

INSERT INTO OrderItem (OrderId, ProductId, Quantity, UnitPrice)
VALUES (1,1,1,80000),
(1,7,2,3000),
(2,2,1,70000),
(2,8,1,12000),
(3,4,1,60000),
(3,7,1,3000),
(4,5,1,75000),
(4,3,1,45000),
(5,6,1,55000),
(5,8,2,12000);

select * from OrderItem

UPDATE Customer SET City = 'Coimbatore' WHERE CustomerId = 2;

select * from Customer

UPDATE Product SET Price = 85000 WHERE ProductId = 1

select * from Product

UPDATE Orders SET OrderStatus = 'Shipping' WHERE OrderId = 3

select * from Orders

DELETE FROM Product WHERE ProductId=1 and  ProductId NOT IN ( SELECT ProductId FROM OrderItem );


SELECT * FROM Customer;

SELECT * FROM Seller; 

SELECT * FROM Product; 

SELECT * FROM Orders;

SELECT * FROM OrderItem;



select * from Customer where City='Chennai'

select * from Customer where City='Chennai' and IsActive =1


select * from Customer where City <>'Chennai'


Select * from Product where Price>50000

Select * from Product where Price between 10000 and 60000

Select * from Product where Price not between 10000 and 60000

Select * from Product where Category in('Mobile','Laptop')

select * from Customer where CustomerName like 'a%'

select * from Customer where Email like '%gmail%'

select * from Customer where City in('Chennai','Bangalore')

select * from Customer where City <>'Hyderabad'

SELECT City, COUNT(*) AS TotalCustomers FROM Customer GROUP BY City

SELECT Category, COUNT(*) AS TotalProducts FROM Product GROUP BY Category;

SELECT Category, SUM(StockQuantity) AS TotalStockQuantity FROM Product GROUP BY Category;


SELECT Category, MAX(Price) AS MaximumPrice FROM Product GROUP BY Category

SELECT Category, MIN(Price) AS MinimumPrice FROM Product GROUP BY Category

SELECT Category, AVG(Price) AS AveragePrice FROM Product GROUP BY Category



SELECT C.CustomerName, SUM(OI.Quantity * OI.UnitPrice) AS TotalOrderAmount 
FROM Customer C JOIN Orders O 
ON C.CustomerId = O.CustomerId 
JOIN OrderItem OI 
ON O.OrderId = OI.OrderId
GROUP BY C.CustomerName



SELECT C.CustomerName, SUM(OI.Quantity * OI.UnitPrice) AS TotalOrderAmount 
FROM Customer C JOIN Orders O 
ON C.CustomerId = O.CustomerId 
JOIN OrderItem OI 
ON O.OrderId = OI.OrderId
GROUP BY C.CustomerName
Having SUM(OI.Quantity * OI.UnitPrice) > 80000



SELECT P.ProductName, SUM(OI.Quantity * OI.UnitPrice) AS TotalSales 
FROM Product P 
JOIN OrderItem OI 
ON P.ProductId = OI.ProductId
GROUP BY P.ProductName;


SELECT S.SellerName, COUNT(P.ProductId) AS TotalProducts
FROM Seller S 
LEFT JOIN Product P
ON S.SellerId = P.SellerId
GROUP BY S.SellerName;


SELECT OrderStatus, COUNT(*) AS OrderCount
FROM Orders 
GROUP BY OrderStatus;

SELECT c.CustomerName,o.OrderId,o.OrderStatus
FROM Customer c
LEFT JOIN Orders o
ON c.CustomerId=o.CustomerId;

SELECT o.OrderId,c.CustomerName
FROM Customer c
RIGHT JOIN Orders o
ON c.CustomerId=o.CustomerId;

SELECT c.CustomerName,o.OrderId
FROM Customer c
FULL OUTER JOIN Orders o
ON c.CustomerId=o.CustomerId;

SELECT c.CustomerName,p.ProductName
FROM Customer c
CROSS JOIN Product p;

SELECT c.CustomerName
FROM Customer c
LEFT JOIN Orders o
ON c.CustomerId=o.CustomerId
WHERE o.OrderId IS NULL;

SELECT p.ProductName
FROM Product p
LEFT JOIN OrderItem oi
ON p.ProductId=oi.ProductId
WHERE oi.OrderItemId IS NULL;

SELECT s.SellerName,p.ProductName
FROM Seller s
INNER JOIN Product p
ON s.SellerId=p.SellerId;

SELECT c.CustomerName,p.ProductName
FROM Customer c
INNER JOIN Orders o
ON c.CustomerId=o.CustomerId
INNER JOIN OrderItem oi
ON o.OrderId=oi.OrderId
INNER JOIN Product p
ON oi.ProductId=p.ProductId;

SELECT o.OrderId,SUM(oi.Quantity*oi.UnitPrice) AS TotalAmount
FROM Orders o
INNER JOIN OrderItem oi
ON o.OrderId=oi.OrderId
GROUP BY o.OrderId;

SELECT s.SellerName,SUM(oi.Quantity*oi.UnitPrice) AS TotalSales
FROM Seller s
INNER JOIN Product p
ON s.SellerId=p.SellerId
INNER JOIN OrderItem oi
ON p.ProductId=oi.ProductId
GROUP BY s.SellerName;

SELECT p.ProductName,SUM(oi.Quantity) AS TotalSalesQuantity
FROM Product p
INNER JOIN OrderItem oi
ON p.ProductId=oi.ProductId
GROUP BY p.ProductName; 


