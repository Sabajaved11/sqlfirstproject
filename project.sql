/* 
We have a database to costumer and products where we going to analysis the data uning sql. 
Here, 8 table are available 
1 customers
2 employees
3 offices
4 order details
5 orders
6 payments
7 productlines
8 products

Let's find the number of attributes and number of rows that each table contains with a query.

*/

SELECT 'costumers' as table_name,
13 as number_of_attributes,
count(*) as number_of_now
from customers 

union ALL

select 'product' as table_name,
9 as number_of_attributes,
count(*) as number_of_row
from products

union ALL

select 'productlines' as table_name,
4 as number_of_attributes,
count(*) as number_of_row
from productlines

union ALL


select 'orders' as table_name,
7 as number_of_attributes,
count(*) as number_of_row
from orders

union ALL

select 'orderdetails' as table_name,
5 as number_of_attributes,
count(*) as number_of_row
from orderdetails

union ALL

select 'payments' as table_name,
4 as number_of_attributes,
count(*) as number_of_row
from payments

union ALL

select 'employees' as table_name,
8 as number_of_attributes,
count(*) as number_of_row
from employees

union ALL

select 'offices' as table_name,
8 as number_of_attributes,  
count(*) as number_of_row
from offices

 


-- now let's find the Products Should We Order More of or Less of


SELECT productCode, 
 round (sum(quantityordered) *1.0/
(select quantityInStock 
from products p
where d.productcode = p.productcode),2)
 as low_stock
from orderdetails d
group by productCode
order by low_stock
limit 10;

-- product performance

select productCode,
sum(quantityOrdered * priceEach) as product_performance
FROM orderdetails 
group by productCode
order by product_performance DESC
limit 10;

-- Revenue by customer, Top 5 VIP  Engaged Customers

select o.customerNumber, contactLastName,
contactFirstName, city, country, sum(quantityOrdered * (priceeach - buyprice)) as revenue
from products p
join orderdetails d
on p.productCode = d.productCode
join orders o
on o.ordernumber = d.orderNumber
join customers c
on c.customerNumber = o.customerNumber
group by o.customerNumber
order by revenue DESC
limit 5
;

-- Top 5 less Engaged Customers

select o.customerNumber, contactLastName,
contactFirstName, city, country, sum(quantityOrdered * (priceeach - buyprice)) as revenue
from products p
join orderdetails d
on p.productCode = d.productCode
join orders o
on o.ordernumber = d.orderNumber
join customers c
on c.customerNumber = o.customerNumber
group by o.customerNumber
order by revenue 
limit 5
;

-- customer ltv

select o.customerNumber, contactLastName,
contactFirstName, city, country, avg(quantityOrdered * (priceeach - buyprice)) as ltv
from products p
join orderdetails d
on p.productCode = d.productCode
join orders o
on o.ordernumber = d.orderNumber
join customers c
on c.customerNumber = o.customerNumber
group by o.customerNumber


;







