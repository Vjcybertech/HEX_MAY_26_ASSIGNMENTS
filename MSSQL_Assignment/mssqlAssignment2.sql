--Subquery--

SELECT * FROM Product WHERE Price >
(SELECT AVG(Price) FROM Product);

SELECT * FROM Product WHERE StockQuantity<
(SELECT AVG(StockQuantity) FROM Product)


SELECT * FROM Customer WHERE CustomerId IN ( SELECT CustomerId FROM Orders );

SELECT * FROM Customer WHERE CustomerId NOT IN ( SELECT CustomerId FROM Orders )

SELECT * FROM Product WHERE ProductId IN ( SELECT ProductId FROM OrderItem )

SELECT * FROM Product WHERE ProductId NOT IN ( SELECT ProductId FROM OrderItem )

SELECT * FROM Seller WHERE SellerId IN ( SELECT SellerId FROM Product )

SELECT * FROM Seller WHERE SellerId NOT IN ( SELECT SellerId FROM Product)

SELECT * FROM Orders 
WHERE CustomerId IN
(SELECT CustomerId FROM Customer 
WHERE City = 'Chennai')

SELECT * FROM Product 
WHERE SellerId IN 
(SELECT SellerId FROM Seller
WHERE City = 'Bangalore')

SELECT * FROM Customer
WHERE CustomerId IN 
(SELECT CustomerId FROM Orders)

SELECT * FROM Customer
WHERE CustomerId NOT IN
(SELECT CustomerId FROM Orders)

SELECT * FROM Product
WHERE ProductId IN 
(SELECT ProductId FROM OrderItem)

SELECT * FROM Product WHERE ProductId NOT IN ( SELECT ProductId FROM OrderItem )

SELECT * FROM Seller WHERE SellerId IN ( SELECT SellerId FROM Product )

SELECT * FROM Seller WHERE SellerId NOT IN ( SELECT SellerId FROM Product )


SELECT * FROM Orders WHERE OrderId IN 
( SELECT OrderId FROM OrderItem 
WHERE ProductId IN 
( SELECT ProductId FROM Product WHERE Category = 'Mobile' ) )


SELECT * FROM Orders WHERE OrderId NOT IN
( SELECT OrderId FROM OrderItem
WHERE ProductId IN 
( SELECT ProductId FROM Product WHERE Category = 'Laptop' ) )

SELECT * FROM Product WHERE Price = ( SELECT MAX(Price) FROM Product )

SELECT * FROM Product WHERE Price = ( SELECT MIN(Price) FROM Product )

SELECT * FROM Product WHERE Price > ( SELECT AVG(Price) FROM Product )

SELECT * FROM Product WHERE Price < ( SELECT AVG(Price) FROM Product )

SELECT C.* FROM Customer C WHERE C.CustomerId IN 
( SELECT O.CustomerId FROM Orders O 
JOIN OrderItem OI ON O.OrderId = OI.OrderId
GROUP BY O.CustomerId
HAVING SUM(OI.Quantity * OI.UnitPrice) > ( SELECT AVG(OrderAmount)
FROM ( SELECT SUM(OI.Quantity * OI.UnitPrice) AS OrderAmount 
FROM Orders O
JOIN OrderItem OI
ON O.OrderId = OI.OrderId 
GROUP BY O.CustomerId ) A ) )


SELECT * FROM Seller WHERE SellerId IN 
( SELECT P.SellerId FROM Product P
JOIN OrderItem OI 
ON P.ProductId = OI.ProductId 
GROUP BY P.SellerId 
HAVING SUM(OI.Quantity * OI.UnitPrice) > 50000 )

SELECT P.* FROM Product P 
JOIN OrderItem OI 
ON P.ProductId = OI.ProductId
GROUP BY P.ProductId, P.ProductName, P.Category, P.Price, P.StockQuantity, P.SellerId, P.CreatedDate 
HAVING SUM(OI.Quantity) > ( SELECT AVG(TotalQty) FROM
( SELECT SUM(Quantity) AS TotalQty FROM OrderItem 
GROUP BY ProductId )A )

SELECT * FROM Customer 
WHERE CustomerId = ( SELECT TOP 1 O.CustomerId FROM Orders O
JOIN OrderItem OI 
ON O.OrderId = OI.OrderId 
GROUP BY O.CustomerId 
ORDER BY SUM(OI.Quantity * OI.UnitPrice) DESC )

SELECT * FROM Product 
WHERE ProductId = ( SELECT TOP 1 ProductId FROM OrderItem 
GROUP BY ProductId
ORDER BY SUM(Quantity * UnitPrice) DESC )

SELECT * FROM Seller 
WHERE SellerId = ( SELECT TOP 1 P.SellerId FROM Product P 
JOIN OrderItem OI
ON P.ProductId = OI.ProductId 
GROUP BY P.SellerId
ORDER BY SUM(OI.Quantity * OI.UnitPrice) DESC )

SELECT * FROM Product P1 
WHERE Price > ( SELECT AVG(P2.Price)
FROM Product P2 
WHERE P1.Category = P2.Category )


SELECT * FROM Product P1 
WHERE Price < ( SELECT AVG(P2.Price)
FROM Product P2
WHERE P1.Category = P2.Category )


SELECT *
FROM Seller S
WHERE
(
    SELECT COUNT(*)
    FROM Product P
    WHERE P.SellerId = S.SellerId
) > 2;


SELECT *
FROM Customer C
WHERE
(
    SELECT COUNT(*)
    FROM Orders O
    WHERE O.CustomerId = C.CustomerId
) > 1;


SELECT O.OrderId,
       O.CustomerId,
       O.OrderDate,
       O.OrderStatus
FROM Orders O
JOIN OrderItem OI
ON O.OrderId = OI.OrderId
GROUP BY O.OrderId,
         O.CustomerId,
         O.OrderDate,
         O.OrderStatus
HAVING SUM(OI.Quantity * OI.UnitPrice) >
(
    SELECT AVG(OrderAmount)
    FROM
    (
        SELECT SUM(Quantity * UnitPrice) AS OrderAmount
        FROM OrderItem
        GROUP BY OrderId
    ) X
)



SELECT *
FROM Product P1
WHERE StockQuantity >
(
    SELECT AVG(P2.StockQuantity)
    FROM Product P2
    WHERE P1.Category = P2.Category
);



SELECT *
FROM Seller S
WHERE
(
    SELECT AVG(P.Price)
    FROM Product P
    WHERE P.SellerId = S.SellerId
) >(SELECT AVG(Price) FROM Product)




SELECT *
FROM Customer C
WHERE EXISTS
(
    SELECT 1
    FROM Orders O
    WHERE O.CustomerId = C.CustomerId
)



SELECT *
FROM Customer C
WHERE NOT EXISTS
(
    SELECT 1
    FROM Orders O
    WHERE O.CustomerId = C.CustomerId
)


SELECT *
FROM Product P
WHERE EXISTS
(
    SELECT 1
    FROM OrderItem OI
    WHERE OI.ProductId = P.ProductId
)


SELECT *
FROM Product P
WHERE NOT EXISTS
(
    SELECT 1
    FROM OrderItem OI
    WHERE OI.ProductId = P.ProductId
)


SELECT *
FROM Seller S
WHERE EXISTS
(
    SELECT 1
    FROM Product P
    WHERE P.SellerId = S.SellerId
)


SELECT *
FROM Seller S
WHERE NOT EXISTS
(
    SELECT 1
    FROM Product P
    WHERE P.SellerId = S.SellerId
)



SELECT *
FROM Customer C
WHERE EXISTS
(
    SELECT 1
    FROM Orders O
    JOIN OrderItem OI ON O.OrderId = OI.OrderId
    JOIN Product P ON OI.ProductId = P.ProductId
    WHERE O.CustomerId = C.CustomerId
    AND P.Category = 'Mobile'
)


SELECT *
FROM Customer C
WHERE NOT EXISTS
(
    SELECT 1
    FROM Orders O
    JOIN OrderItem OI ON O.OrderId = OI.OrderId
    JOIN Product P ON OI.ProductId = P.ProductId
    WHERE O.CustomerId = C.CustomerId
    AND P.Category = 'Laptop'
)

--Stored Procedure



CREATE PROC sp_GetAllCustomers
AS
SELECT * FROM Customer;


CREATE PROC sp_GetAllProducts
AS
SELECT * FROM Product


CREATE PROC sp_GetAllSellers
AS
SELECT * FROM Seller


CREATE PROC sp_GetAllOrders
AS
SELECT * FROM Orders

CREATE PROC sp_GetAllOrderItems
AS
SELECT * FROM OrderItem;


CREATE PROC sp_GetCustomerById
@CustomerId INT
AS
SELECT * FROM Customer WHERE CustomerId=@CustomerId;



CREATE PROC sp_GetProductById
@ProductId INT
AS
SELECT * FROM Product WHERE ProductId=@ProductId;

CREATE PROC sp_GetSellerById
@SellerId INT
AS
SELECT * FROM Seller WHERE SellerId=@SellerId

CREATE PROC sp_GetOrderById
@OrderId INT
AS
SELECT * FROM Orders WHERE OrderId=@OrderId

CREATE PROC sp_GetCustomersByCity
@City VARCHAR(50)
AS
SELECT * FROM Customer WHERE City=@City;

CREATE PROC sp_GetProductsByCategory
@Category VARCHAR(50)
AS
SELECT * FROM Product WHERE Category=@Category;


CREATE PROC sp_GetProductsBySeller
@SellerId INT
AS
SELECT * FROM Product WHERE SellerId=@SellerId;


CREATE PROC sp_GetOrdersByCustomer
@CustomerId INT
AS
SELECT * FROM Orders WHERE CustomerId=@CustomerId;


CREATE PROC sp_GetOrderItemsByOrder
@OrderId INT
AS
SELECT * FROM OrderItem WHERE OrderId=@OrderId


CREATE PROC sp_GetProductsGreaterThanPrice
@Price DECIMAL(10,2)
AS
SELECT * FROM Product WHERE Price>@Price;



CREATE PROC sp_InsertCustomer
@CustomerName VARCHAR(100),
@Email VARCHAR(100),
@MobileNo VARCHAR(15),
@City VARCHAR(50),
@Address VARCHAR(200)
AS
INSERT INTO Customer(CustomerName,Email,MobileNo,City,Address)
VALUES(@CustomerName,@Email,@MobileNo,@City,@Address)


CREATE PROC sp_InsertSeller
@SellerName VARCHAR(100),
@Email VARCHAR(100),
@MobileNo VARCHAR(15),
@City VARCHAR(50),
@Rating DECIMAL(2,1)
AS
INSERT INTO Seller(SellerName,Email,MobileNo,City,Rating)
VALUES(@SellerName,@Email,@MobileNo,@City,@Rating);


CREATE PROC sp_InsertProduct
@ProductName VARCHAR(100),
@Category VARCHAR(50),
@Price DECIMAL(10,2),
@StockQuantity INT,
@SellerId INT
AS
INSERT INTO Product(ProductName,Category,Price,StockQuantity,SellerId)
VALUES(@ProductName,@Category,@Price,@StockQuantity,@SellerId);


CREATE PROC sp_InsertOrder
@CustomerId INT,
@PaymentMode VARCHAR(50),
@DeliveryCity VARCHAR(50)
AS
INSERT INTO Orders(CustomerId,PaymentMode,DeliveryCity)
VALUES(@CustomerId,@PaymentMode,@DeliveryCity);



CREATE PROC sp_InsertOrderItem
@OrderId INT,
@ProductId INT,
@Quantity INT,
@UnitPrice DECIMAL(10,2)
AS
INSERT INTO OrderItem(OrderId,ProductId,Quantity,UnitPrice)
VALUES(@OrderId,@ProductId,@Quantity,@UnitPrice);



CREATE PROC sp_UpdateCustomerCity
@CustomerId INT,@City VARCHAR(50)
AS
UPDATE Customer SET City=@City WHERE CustomerId=@CustomerId;



CREATE PROC sp_UpdateCustomerMobile
@CustomerId INT,@MobileNo VARCHAR(15)
AS
UPDATE Customer SET MobileNo=@MobileNo WHERE CustomerId=@CustomerId


CREATE PROC sp_UpdateProductPrice
@ProductId INT,@Price DECIMAL(10,2)
AS
UPDATE Product SET Price=@Price WHERE ProductId=@ProductId;


CREATE PROC sp_UpdateProductStock
@ProductId INT,@StockQuantity INT
AS
UPDATE Product SET StockQuantity=@StockQuantity WHERE ProductId=@ProductId;



CREATE PROC sp_UpdateOrderStatus
@OrderId INT,@OrderStatus VARCHAR(50)
AS
UPDATE Orders SET OrderStatus=@OrderStatus WHERE OrderId=@OrderId;



CREATE PROC sp_UpdateSellerRating
@SellerId INT,@Rating DECIMAL(2,1)
AS
UPDATE Seller SET Rating=@Rating WHERE SellerId=@SellerId;


CREATE PROC sp_UpdateCustomerStatus
@CustomerId INT,@IsActive BIT
AS
UPDATE Customer SET IsActive=@IsActive WHERE CustomerId=@CustomerId;


CREATE PROC sp_UpdateSellerStatus
@SellerId INT,@IsActive BIT
AS
UPDATE Seller SET IsActive=@IsActive WHERE SellerId=@SellerId;

CREATE PROC sp_DeleteCustomer
@CustomerId INT
AS
DELETE FROM Customer WHERE CustomerId=@CustomerId;


CREATE PROC sp_DeleteSeller
@SellerId INT
AS
DELETE FROM Seller WHERE SellerId=@SellerId


CREATE PROC sp_DeleteProduct
@ProductId INT
AS
DELETE FROM Product WHERE ProductId=@ProductId;


CREATE PROC sp_DeleteOrder
@OrderId INT
AS
DELETE FROM Orders WHERE OrderId=@OrderId

CREATE PROC sp_DeleteOrderItem
@OrderItemId INT
AS
DELETE FROM OrderItem WHERE OrderItemId=@OrderItemId;



CREATE PROC sp_CustomerWiseOrderDetails
AS
SELECT C.CustomerId,
       C.CustomerName,
       O.OrderId,
       O.OrderDate,
       O.OrderStatus
FROM Customer C
JOIN Orders O
ON C.CustomerId = O.CustomerId;



CREATE PROC sp_SellerWiseProductDetails
AS
SELECT S.SellerId,
       S.SellerName,
       P.ProductId,
       P.ProductName,
       P.Price
FROM Seller S
JOIN Product P
ON S.SellerId = P.SellerId;



CREATE PROC sp_OrderWiseProductDetails
AS
SELECT O.OrderId,
       P.ProductId,
       P.ProductName,
       OI.Quantity,
       OI.UnitPrice
FROM Orders O
JOIN OrderItem OI
ON O.OrderId = OI.OrderId
JOIN Product P
ON OI.ProductId = P.ProductId;



CREATE PROC sp_CompleteOrderReport
AS
SELECT C.CustomerName,
       O.OrderId,
       P.ProductName,
       S.SellerName,
       OI.Quantity,
       OI.UnitPrice,
       (OI.Quantity * OI.UnitPrice) AS TotalAmount
FROM Orders O
JOIN Customer C
ON O.CustomerId = C.CustomerId
JOIN OrderItem OI
ON O.OrderId = OI.OrderId
JOIN Product P
ON OI.ProductId = P.ProductId
JOIN Seller S
ON P.SellerId = S.SellerId;



CREATE PROC sp_CustomerWiseTotalOrderAmount
AS
SELECT C.CustomerId,
       C.CustomerName,
       SUM(OI.Quantity * OI.UnitPrice) AS TotalOrderAmount
FROM Customer C
JOIN Orders O
ON C.CustomerId = O.CustomerId
JOIN OrderItem OI
ON O.OrderId = OI.OrderId
GROUP BY C.CustomerId, C.CustomerName;



CREATE PROC sp_SellerWiseTotalSales
AS
SELECT S.SellerId,
       S.SellerName,
       SUM(OI.Quantity * OI.UnitPrice) AS TotalSalesAmount
FROM Seller S
JOIN Product P
ON S.SellerId = P.SellerId
JOIN OrderItem OI
ON P.ProductId = OI.ProductId
GROUP BY S.SellerId, S.SellerName;


CREATE PROC sp_ProductWiseSalesQuantity
AS
SELECT P.ProductId,
       P.ProductName,
       SUM(OI.Quantity) AS TotalSalesQuantity
FROM Product P
JOIN OrderItem OI
ON P.ProductId = OI.ProductId
GROUP BY P.ProductId, P.ProductName;



CREATE PROC sp_TotalCustomers
@TotalCustomers INT OUTPUT
AS
BEGIN
    SELECT @TotalCustomers = COUNT(*)
    FROM Customer;
END;


CREATE PROC sp_TotalProducts
@TotalProducts INT OUTPUT
AS
BEGIN
    SELECT @TotalProducts = COUNT(*)
    FROM Product;
END;



CREATE PROC sp_TotalOrders
@TotalOrders INT OUTPUT
AS
BEGIN
    SELECT @TotalOrders = COUNT(*)
    FROM Orders;
END;



CREATE PROC sp_ProductSalesAmount
@ProductId INT,
@TotalSales DECIMAL(18,2) OUTPUT
AS
BEGIN
    SELECT @TotalSales = SUM(Quantity * UnitPrice)
    FROM OrderItem
    WHERE ProductId = @ProductId;
END;



CREATE PROC sp_CustomerPurchaseAmount
@CustomerId INT,
@TotalPurchase DECIMAL(18,2) OUTPUT
AS
BEGIN
    SELECT @TotalPurchase = SUM(OI.Quantity * OI.UnitPrice)
    FROM Orders O
    JOIN OrderItem OI
    ON O.OrderId = OI.OrderId
    WHERE O.CustomerId = @CustomerId;
END
