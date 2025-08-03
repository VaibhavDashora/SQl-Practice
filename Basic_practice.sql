select * from customers;
alter table customers rename column `Customer ID` to customer_id; 

-- query will return the 3 customers with the lowest balances

select customer_id 
from customers 
order by balance 
desc limit 3;

-- query will select customers with non-null balances

select customer_id
from customers 
where balance is not null;

-- query will retrieve customers from northern ireland with a balance column over 30K

select customer_id , region , balance
from customers 
where region = "Northern Ireland" and balance > 30000;

-- query will group customers by job and display the average balance for each group

select job , avg(balance) as avgbalance
from customers
group by job;

-- query lists only unique job types from the table

select distinct job
from customers;

-- query list the top 5 customers with the highest balance

select customer_id , Name, balance
from customers
order by balance desc limit 5;

-- query to find customers from regions starting with the letter 'N'

select customer_id , region
from customers
where region like "N%";

-- query finds regions where more than 2 customers have a balance between 30k  and 70k

select region 
from customers 
where balance between 50000 and 70000
group by region
having count(*) > 2 ;

-- query to retrieve customers names that contain an 'e' as the second character

select customer_id , Name
from customers
where name like "_e%";

-- query lists regions with more than 5 customers whose balance exceeds 50000

select region 
from customers 
where balance > 50000
group by region
having count(*) > 5 ;

-- query retrieves regions that have at least one customer whose balance is between 10k and 30K

select region 
from customers 
where balance between 10000 and 30000
group by region
having count(*) > 1 ;

-- query finds the total number of customer in each region, but only for regions with a name that ends with 'd'


select count(customer_id) , region
from customers
group by region
having region like "%d";

-- query return regions where the avergae balance is greater than 40K for customer with names starting with s

select region
from customers
where name like 'S%'
group by region
having avg(Balance) > 40000;


-- query returns the names of customers where the name end with 'n' and the age is not between 20 and 40

select name,age
from customers
where name like "%n" and age not between 20 and 40;



