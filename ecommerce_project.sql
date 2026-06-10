#Create Customers Table

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    CustomerName VARCHAR2(50),
    City VARCHAR2(50)
);

#Check:

DESC Customers;

#Create Products Table

CREATE TABLE Products (
    ProductID NUMBER PRIMARY KEY,
    ProductName VARCHAR2(50),
    Category VARCHAR2(50),
    Price NUMBER(10,2)
);

#Check:

DESC Products;

#Create Orders Table


CREATE TABLE Orders (
    OrderID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    ProductID NUMBER,
    Quantity NUMBER,
    OrderDate DATE,
    
    CONSTRAINT fk_customer
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID),
    
    CONSTRAINT fk_product
    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);

#Check:

DESC Orders;


#Insert Customer Records

INSERT INTO Customers VALUES (1,'Danisha','Chennai');

INSERT INTO Customers VALUES (2,'Darni','Bangalore');

INSERT INTO Customers VALUES (3,'Darbiya','Coimbatore');

INSERT INTO Customers VALUES (4,'Daniya','Madurai');

INSERT INTO Customers VALUES (5,'Daniel','Trichy');

COMMIT;

#Check:

select *
from Customers;

#Insert Product Records

INSERT INTO Products VALUES
(101,'Laptop','Electronics',50000);

INSERT INTO Products VALUES
(102,'Mobile','Electronics',25000);

INSERT INTO Products VALUES
(103,'Shirt','Clothing',1200);

INSERT INTO Products VALUES
(104,'Sofa','Furniture',30000);

INSERT INTO Products VALUES
(105,'Headphones','Electronics',3000);

COMMIT;

#Check:

select *
from Products;


#Insert Orders

INSERT INTO Orders VALUES
(1001,1,101,1,DATE '2025-01-10');

INSERT INTO Orders VALUES
(1002,2,102,2,DATE '2025-01-15');

INSERT INTO Orders VALUES
(1003,3,103,5,DATE '2025-02-01');

INSERT INTO Orders VALUES
(1004,4,104,1,DATE '2025-02-12');

INSERT INTO Orders VALUES
(1005,5,105,3,DATE '2025-03-05');

COMMIT;

#Check:

select *
from Orders;

#Customer Orders(JOIN Concept)


SELECT
    c.CustomerName,
    p.ProductName,
    o.Quantity,
    o.OrderDate
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Products p
ON o.ProductID = p.ProductID;

#Revenue by Product(GROUPBY+SUM)

SELECT
    p.ProductName,
    SUM(o.Quantity * p.Price) Revenue
FROM Orders o
JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY p.ProductName;

#Revenue by Category

SELECT
    p.Category,
    SUM(o.Quantity * p.Price) Revenue
FROM Orders o
JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY p.Category;


#Top Customer(ORDERBY)

SELECT
    c.CustomerName,
    SUM(o.Quantity * p.Price) TotalSpent
FROM Orders o
JOIN Customers c
ON o.CustomerID = c.CustomerID
JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC;

#HAVING Clause

SELECT
    p.Category,
    SUM(o.Quantity * p.Price) Revenue
FROM Orders o
JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY p.Category
HAVING SUM(o.Quantity * p.Price) > 10000;

#Window Function(Advance SQL)

SELECT
    ProductName,
    Price,
    RANK() OVER (ORDER BY Price DESC) ProductRank
FROM Products;



