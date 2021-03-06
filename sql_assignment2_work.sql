/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$******TASK 1********$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
-- Task 1:- Understanding the Data
-- 1. Describe the data in hand in your own words. 
/* Superstores data consists of five tables cust_dimen, market_fact, orders_dimen, product_dimen, shipping_dimen.
In which cust_dimen table store details like customer name, province, region, customer segment, and cust_id, in simple way it
stores information about customer details, address and customer id. 

market_fact table stores details like store sales, profit,
shipping cost, order quantity and foreign keys which connects market_fact table with different tables. 
	
orders_dimen table stores information of order date, order priority, and order id.

prod_dimen stores data about products that is product category, and product sub category, product id.alter

shipping_dimen stores data like shipping mode, shipping date, and shipping id    */


/* 2. Identify and list the Primary Keys and Foreign Keys for this dataset provided to
you(In case you don’t find either primary or foreign key, then specially mention
this in your answer)*/

/*
primary key:- 'cust_id' in cust_dimen 
primary key:- 'ord_id' in orders_dimen   
primary key:- 'prod_id' in prod_dimen
primary key:- 'ship_id' , foreign_key:- 'Order_id' in shipping_dimen
foreign keys:- 'ord_id' from orders_dimen, 'prod_id' from prod_dimen, 'ship_id' from shipping_dimen,
 'cust_id' from cust_dimen, all present these foreign keys are present in market_fact, and there is no primary key present in this table
 */
-- ---------------------------------------------------------------------------------------
/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$************TASK 2************$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
-- Task 2:- Basic & Advanced Analysis

use superstores;
-- 1. Write a query to display the Customer_Name and Customer Segment using alias
-- name “Customer Name", "Customer Segment" from table Cust_dimen. 

select customer_name 'Customer Name', customer_segment 'Customer Segment' from cust_dimen;

-- 2. Write a query to find all the details of the customer from the table cust_dimen
-- order by desc.

select * from cust_dimen order by cust_id desc;
select * from cust_dimen order by customer_name desc;

-- 3. Write a query to get the Order ID, Order date from table orders_dimen where
-- ‘Order Priority’ is high.
select order_id, order_date from orders_dimen 
	where order_priority= 'high';

-- 4. Find the total and the average sales (display total_sales and avg_sales) 
select sum(sales) 'total_sales', avg(sales) 'avg_sales' from market_fact;

-- 5. Write a query to get the maximum and minimum sales from maket_fact table.
select max(sales) 'max_sales', min(sales) 'min_sales' from market_fact;

-- 6. Display the number of customers in each region in decreasing order of
-- no_of_customers. The result should contain columns Region, no_of_customers.
select region, count(cust_id) 'no_of_customers'from cust_dimen group by region order by no_of_customers desc;

-- 7. Find the region having maximum customers (display the region name and
-- max(no_of_customers)

select region, count(cust_id) 'no_of_customers'from cust_dimen group by region order by no_of_customers desc limit 1;

-- 8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’
/*and the number of tables purchased (display the customer name, no_of_tables
purchased)*/

select c.customer_name, count(p.product_sub_category) over(partition by c.customer_name) 'no_of_tables'
from cust_dimen c 
	join market_fact m on c.cust_id=m.cust_id 
	join prod_dimen p on m.prod_id= p.prod_id 
    where c.region like '%atlantic%' and p.product_sub_category like '%tables%' ;


-- 9. Find all the customers from Ontario province who own Small Business. (display
-- the customer name, no of small business owners)
select c.customer_name, count(c.customer_segment) 'no_of_small_business_owners' from cust_dimen c 
join market_fact m on c.cust_id=m.cust_id
where c.province= 'ontario' and c.customer_segment='small business' group by c.customer_name;

-- or

select customer_name,count(customer_segment) 'no_of_small_business' from cust_dimen 
where 
customer_segment like '%small business%' and province like '%ontario%'
group by customer_name;

-- 10. Find the number and id of products sold in decreasing order of products sold
-- (display product id, no_of_products sold)

select prod_id, count(prod_id) 'no_of_products' from market_fact group by prod_id  order by count(prod_id) desc;

-- 11. Display product Id and product sub category whose produt category belongs to
/*Furniture and Technlogy. The result should contain columns product id, product
sub category.*/

select * from prod_dimen;
select prod_id, product_sub_category from prod_dimen 
where 
product_category = 'furniture' or product_category = 'technology' 
order by product_category;

-- 12. . Display the product categories in descending order of profits (display the product
-- category wise profits i.e. product_category, profits)?

select product_category,profit from market_fact 
	join 
	prod_dimen using (prod_id) 
group by product_category order by profit desc;

-- 13. Display the product category, product sub-category and the profit within each
-- subcategory in three columns. 

select product_category,product_sub_category,profit from market_fact 
	join 
	prod_dimen using (prod_id) 
group by product_sub_category order by product_category asc, profit desc;

-- 14. Display the order date, order quantity and the sales for the order.

select order_date, order_quantity, sales from market_fact join orders_dimen using (ord_id) order by sales desc;

-- 15. Display the names of the customers whose name contains the
 /*i) Second letter as ‘R’
 ii) Fourth letter as ‘D’*/
 
 -- i) Second letter as ‘R’
 select * from cust_dimen where customer_name like '_r%';

-- ii) Fourth letter as ‘D’
select * from cust_dimen where customer_name like '___d%';

-- 16. Write a SQL query to to make a list with Cust_Id, Sales, Customer Name and
-- their region where sales are between 1000 and 5000.

select cust_id, sales, customer_name, region from cust_dimen c 
join market_fact m using (cust_id) 
where sales between 1000 and 5000 
order by region asc, sales desc;

-- 17. Write a SQL query to find the 3rd highest sales.
select ord_id, cust_id, sales, nth_value(sales,3) over(order by sales desc) 'third_highest_sales' from market_fact ;
 
 -- 18. Where is the least profitable product subcategory shipped the most? For the least
/*profitable product sub-category, display the region-wise no_of_shipments and the 
profit made in each region in decreasing order of profits (i.e. region,
no_of_shipments, profit_in_each_region)
 → Note: You can hardcode the name of the least profitable product subcategory*/
 SELECT 
    c.region, COUNT(distinct s.ship_id) AS no_of_shipments, SUM(m.profit) AS profit_in_each_region
	FROM
    market_fact m
	INNER JOIN
    cust_dimen c ON m.cust_id = c.cust_id
	INNER JOIN
    shipping_dimen s ON m.ship_id = s.ship_id
	INNER JOIN
    prod_dimen p ON m.prod_id = p.prod_id
	WHERE
    p.product_sub_category IN 
    (	SELECT 							
		p.product_sub_category
        FROM
		market_fact m
		INNER JOIN
		prod_dimen p ON m.prod_id = p.prod_id
        GROUP BY p.product_sub_category
        HAVING SUM(m.profit) <= ALL
										(	SELECT 
											SUM(m.profit) AS profits
											FROM
											market_fact m
											INNER JOIN
											prod_dimen p ON m.prod_id = p.prod_id
											GROUP BY p.product_sub_category
										)
	)
	GROUP BY c.region
	ORDER BY profit_in_each_region DESC;
 
 
 
 select c.region, count(m.ship_id) 'no_of_shipments' , m.profit, p.product_sub_category from cust_dimen c 
	join 
 market_fact m using (cust_id)
	join
prod_dimen p using (prod_id)
group by c.region
    order by profit desc;
show tables;
    
