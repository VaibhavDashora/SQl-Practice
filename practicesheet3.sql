CREATE TABLE sales1_data (
    sale_id INT,
    employee_id INT,
    region VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales1_data VALUES
(1, 101, 'North', 5000.00, '2023-01-10'),
(2, 102, 'South', 7000.00, '2023-01-12'),
(3, 101, 'North', 4500.00, '2023-01-15'),
(4, 103, 'East', 6200.00, '2023-01-18'),
(5, 102, 'South', 8000.00, '2023-01-20'),
(6, 101, 'North', 5000.00, '2023-01-22'),
(7, 103, 'East', 6100.00, '2023-01-25'),
(8, 104, 'West', 7500.00, '2023-01-28'),
(9, 104, 'West', 7000.00, '2023-01-30');




SELECT employee_id,
       SUM(sale_amount) AS total_sales,
       RANK() OVER (ORDER BY SUM(sale_amount) DESC) AS sales_rank
FROM sales_data
GROUP BY employee_id;

select employee_id , sale_date , sale_amount , region ,
sum(sale_amount) over ( partition by region order by sale_date) as runing_total
from sales_data;



select employee_id , sale_amount , 
rank() over ( order by sale_amount desc) as rnk
from sales1_data;

select employee_id , sale_amount , 
dense_rank() over ( order by sale_amount desc) as drnk
from sales1_data;

select employee_id , sale_amount , 
dense_rank() over ( order by sale_amount desc) as drnk
from sales1_data;


SELECT employee_id, sale_date, sale_amount,
       LEAD(sale_amount) OVER (PARTITION BY sale_amount ORDER BY sale_date) AS next_sale
FROM sales1_data;

SELECT employee_id, sale_date, sale_amount,
       Lag(sale_amount) OVER (PARTITION BY employee_id ORDER BY sale_date) AS next_sale
FROM sales1_data;
