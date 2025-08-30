CREATE DATABASE EcommerceDB;
USE EcommerceDB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    join_date DATE
);
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE OrderItems (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers VALUES
(1, 'Alice Smith', 'alice@example.com', 'New York', '2024-01-15'),
(2, 'Bob Johnson', 'bob@example.com', 'Chicago', '2024-03-22'),
(3, 'Charlie Lee', 'charlie@example.com', 'San Francisco', '2024-05-10'),
(4, 'Diana Wong', 'diana@example.com', 'Seattle', '2024-07-01'),
(5, 'Ethan Brown', 'ethan@example.com', 'Austin', '2024-08-05');

INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 1200.00),
(102, 'Headphones', 'Electronics', 150.00),
(103, 'Coffee Maker', 'Home Appliances', 80.00),
(104, 'Desk Chair', 'Furniture', 200.00),
(105, 'Notebook', 'Stationery', 5.00);

INSERT INTO Orders VALUES
(1001, 1, '2025-08-01', 1350.00),
(1002, 2, '2025-08-03', 205.00),
(1003, 1, '2025-08-05', 85.00),
(1004, 3, '2025-08-07', 1200.00),
(1005, 4, '2025-08-09', 5.00);

INSERT INTO OrderItems VALUES
(1, 1001, 101, 1),
(2, 1001, 102, 1),
(3, 1002, 104, 1),
(4, 1003, 103, 1),
(5, 1004, 101, 1),
(6, 1005, 105, 1);



Find the name of the customer who placed the highest total order.


select * from customers;
select * from orders;


-- List all customers who have placed at least one order.

SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT DISTINCT customer_id
    FROM Orders);


-- Show the product name with the highest price.
select name 
from products
where price = (select max(price) from products);

-- Find the total amount spent by 'Alice Smith'
SELECT SUM(total_amount) AS total_spent_by_alice
FROM Orders
WHERE customer_id = (
    SELECT customer_id
    FROM Customers
    WHERE name = 'Alice Smith');


-- Display customers who joined after the customer with the earliest join date.
SELECT customer_id
FROM Customers
WHERE join_date > (
    SELECT MIN(join_date)
    FROM Customers);


 Intermediate Subquery Questions

-- List customers who placed orders worth more than the average order amount.


SELECT c.customer_id, c.name, MAX(o.total_amount) AS max_order
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING MAX(o.total_amount) > (
    SELECT AVG(total_amount)
    FROM orders
);




-- Find products that were never ordered.
SELECT product_id, name
FROM Products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM OrderItems
);



-- Show the names of customers who ordered a product in the 'Electronics' category
SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM Orders o
    JOIN OrderItems oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    WHERE p.category = 'Electronics'
);


-- Find customers who placed more than one order.

select customer_id , name
	from customers
	where customer_id IN 
				(select customer_id 
                from orders 
                group by customer_id 
                having count(*) > 1);

-- Display the product(s) ordered in the most expensive order.

SELECT distinct p.name
FROM Products p
JOIN OrderItems oi ON p.product_id = oi.product_id
WHERE oi.order_id in (
    SELECT order_id
    FROM Orders
    ORDER BY total_amount DESC
);



💼 Business Logic Subquery Challenges
List customers whose total spending exceeds that of 'Bob Johnson'.

Find the category with the highest average product price.

Show the names of customers who ordered more than 2 items in a single order.

Display the most frequently ordered product.

List customers who ordered products from more than one category.


