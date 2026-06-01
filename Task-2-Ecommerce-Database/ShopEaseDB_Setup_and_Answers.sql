CREATE DATABASE ShopEaseDB;

USE ShopEaseDB;
GO

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    join_date DATE NOT NULL,
    is_premium BIT DEFAULT 0
);

CREATE INDEX idx_customers_city
ON customers(city);

CREATE INDEX idx_customers_state
ON customers(state);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    stock_qty INT NOT NULL DEFAULT 0 CHECK (stock_qty >= 0)
);


CREATE INDEX idx_products_category
ON products(category);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending'
        CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')),
    total_amount DECIMAL(12,2) NOT NULL CHECK (total_amount >= 0),

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

CREATE INDEX idx_orders_date
ON orders(order_date);

CREATE INDEX idx_orders_status
ON orders(status);


CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    discount_pct DECIMAL(5,2) DEFAULT 0
        CHECK (discount_pct BETWEEN 0 AND 100),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id)
);


INSERT INTO customers VALUES
(101,'Aarav','Sharma','aarav.s@email.com','Mumbai','Maharashtra','2024-01-15',1),
(102,'Priya','Patel','priya.p@email.com','Ahmedabad','Gujarat','2024-02-20',0),
(103,'Rohan','Gupta','rohan.g@email.com','Delhi','Delhi','2024-03-10',1),
(104,'Sneha','Reddy','sneha.r@email.com','Hyderabad','Telangana','2024-04-05',0),
(105,'Vikram','Singh','vikram.s@email.com','Jaipur','Rajasthan','2024-05-12',1),
(106,'Ananya','Iyer','ananya.i@email.com','Chennai','Tamil Nadu','2024-06-18',0),
(107,'Karan','Mehta','karan.m@email.com','Pune','Maharashtra','2024-07-22',1),
(108,'Divya','Nair','divya.n@email.com','Kochi','Kerala','2024-08-30',0);


INSERT INTO products VALUES
(201,'Wireless Earbuds','Electronics','BoAt',1499.00,250),
(202,'Cotton T-Shirt','Clothing','Levis',799.00,500),
(203,'Smart Watch','Electronics','Noise',2999.00,150),
(204,'Running Shoes','Clothing','Nike',4599.00,120),
(205,'Bluetooth Speaker','Electronics','JBL',3499.00,200),
(206,'Bedsheet Set','Home','Spaces',1299.00,300),
(207,'Laptop Stand','Electronics','AmazonBasics',899.00,180),
(208,'Cushion Covers (Set)','Home','HomeCenter',599.00,400);


INSERT INTO orders VALUES
(1001,101,'2024-08-01','Delivered',4498.00),
(1002,102,'2024-08-03','Delivered',799.00),
(1003,103,'2024-08-05','Shipped',7498.00),
(1004,101,'2024-08-10','Delivered',3499.00),
(1005,104,'2024-08-12','Cancelled',2999.00),
(1006,105,'2024-08-15','Delivered',5898.00),
(1007,106,'2024-08-18','Pending',1299.00),
(1008,103,'2024-08-20','Delivered',899.00),
(1009,107,'2024-08-25','Shipped',6098.00),
(1010,108,'2024-08-28','Delivered',1598.00);

INSERT INTO order_items VALUES
(5001,1001,201,2,1499.00,0),
(5002,1001,207,1,899.00,10),
(5003,1002,202,1,799.00,0),
(5004,1003,203,1,2999.00,0),
(5005,1003,204,1,4599.00,5),
(5006,1004,205,1,3499.00,0),
(5007,1005,203,1,2999.00,0),
(5008,1006,201,1,1499.00,10),
(5009,1006,204,1,4599.00,5),
(5010,1007,206,1,1299.00,0),
(5011,1008,207,1,899.00,0),
(5012,1009,205,1,3499.00,0),
(5013,1009,208,2,599.00,15),
(5014,1010,206,1,1299.00,0),
(5015,1010,208,1,599.00,0);


SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;


SELECT *
FROM customers;

--Question 1 
SELECT * 
FROM customers; 

--Question 2
SELECT first_name, last_name, city 
FROM customers;

-- Question 3
SELECT DISTINCT category 
FROM products; 

-- Question 5
INSERT INTO customers 
VALUES ( 
109, 
'Test', 
'User', 
'aarav.s@email.com', 
'Delhi', 
'Delhi', 
'2024-09-01', 
1 
); 

--Quetion 6
INSERT INTO products 
VALUES ( 
209, 
'Test Product', 
'Electronics', 
'TestBrand', 
-50, 
100 
); 

--Question 7 
select * from  orders where status ='Delivered'

--Question 8
select * from products where category = 'Electronics' and unit_price > 2000

--Question 9 
select * from customers where join_date between '2024-01-01' and '2024-12-31' and state = 'Maharashtra';

--Question 10
select * from orders where order_date BETWEEN '2024-08-10' and '2024-08-25' and status <> 'Cancelled'

--Question 11
SELECT *
FROM orders
WHERE order_date BETWEEN '2024-08-01' AND '2024-08-31';

--Question 12
SELECT * 
FROM customers 
WHERE join_date >= '2024-01-01' 
AND join_date < '2025-01-01'; 

--Question 13
select COUNT(*) As total_orders from orders

--Question 14
select SUM(total_amount)  AS total_revenue from orders where status = 'Delivered'

--Question 15
SELECT 
category, 
AVG(unit_price) AS Average_Price 
FROM products 
GROUP BY category; 

--Question 16
SELECT 
status, 
COUNT(order_id) AS Order_Count, 
SUM(total_amount) AS Total_Revenue 
FROM orders 
GROUP BY status 
ORDER BY Total_Revenue DESC; 

--Question 17

--most expensive product name
SELECT
    category,
    product_name,
    unit_price
FROM products p
WHERE unit_price = (
    SELECT MAX(unit_price)
    FROM products
    WHERE category = p.category
);

--cheapest product name
SELECT 
    Category,
    product_name,
    unit_price
FROM products p
WHERE unit_price = (
    SELECT MIN(unit_price)
    FROM products
    WHERE category = p.category
);

--Question 18
SELECT 
category, 
AVG(unit_price) AS Average_Price 
FROM products 
GROUP BY category 
HAVING AVG(unit_price) > 2000; 

--Question 19
select o.order_id, o.order_date, c.first_name, c.last_name,
o.total_amount from customers AS c INNER JOIN orders As o on c.customer_id = o.customer_id

--Question 20
SELECT
c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

--Question 21
select * from orders
select * from order_items
select * from products

select oi.order_id , p.product_name , oi.quantity , oi.unit_price , oi.discount_pct
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.product_id;

--Question 23
INSERT INTO orders
VALUES
(1011,999,GETDATE(),'Pending',1000);

--Question 24
SELECT 
product_name, unit_price, 
CASE 
WHEN unit_price < 1000 THEN 'Budget' 
WHEN unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range' 
ELSE 'Premium' 
END AS price_tier  FROM products; 

--Question 25
select SUM(
CASE 
    WHEN status = 'Delivered' THEN 1
    ELSE 0
    END
) AS Delivered_orders ,

SUM(
CASE 
    WHEN status <> 'Delivered' THEN 1
    ELSE 0
    END
) AS NOT_Delivered_orders 

from orders

--Question 28
BEGIN TRY 
BEGIN TRANSACTION; 
-- Step 1: Insert New Order 
INSERT INTO orders 
( 
   order_id, 
   customer_id, 
   order_date, 
   status, 
   total_amount 
) 
VALUES 
( 
   1011, 
   102, 
   GETDATE(), 
   'Pending', 
   1598.00 
); 
 
-- Step 2: Insert Order Items 
INSERT INTO order_items 
( 
   item_id, 
   order_id, 
   product_id, 
   quantity, 
   unit_price, 
   discount_pct 
) 
VALUES 
(5016,1011,206,1,1299.00,0); 
 
INSERT INTO order_items 
( 
   item_id, 
   order_id, 
   product_id, 
   quantity, 
   unit_price, 
   discount_pct 
) 
VALUES 
(5017,1011,208,1,599.00,0); 
 
-- Step 3: Update Product Stock 
UPDATE products 
SET stock_qty = stock_qty - 1 
WHERE product_id = 206; 
UPDATE products 
SET stock_qty = stock_qty - 1 
WHERE product_id = 208; 
 
-- Step 4: Commit Transaction 
COMMIT TRANSACTION; 
PRINT 'Transaction Completed Successfully'; 
END TRY 
BEGIN CATCH 
ROLLBACK TRANSACTION; 
PRINT 'Transaction Failed - Changes Rolled Back'; 
END CATCH; 