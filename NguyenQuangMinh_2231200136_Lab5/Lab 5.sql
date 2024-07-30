USE salemanagerment;
-- 1. Display the clients (name) who lives in same city.
SELECT a.client_name, a.city from clients a 
INNER join clients b on a.city = b.city AND a.client_name <> b.client_name
order by a.city;

-- 2. Display city, the client names and salesman names who are lives in “Thu Dau Mot” city.
SELECT a.city, a.client_name, b.salesman_name from clients a 
INNER JOIN salesman b on b.city = "Thu Dau Mot" and a.city = "Thu Dau Mot";

#3. Display client name, client number, order number, salesman number, and product number for each 
#order.
SELECT c.client_name, so.client_number, so.order_number, so.salesman_number, sod.product_number from salesorder so
inner join salesorderdetails sod on so.order_number = sod.order_number 
inner join clients c on so.client_number = c.client_number;

#4. Find each order (client_number, client_name, order_number) placed by each client. 
SELECT c.client_number, c.client_name, so.order_number from salesorder so 
inner join clients c on so.client_number = c.client_number;

#5. Display the details of clients (client_number, client_name) and the number of orders which is paid by 
#them.
SELECT * from salesorder;
select c.client_number, c.client_name, count(so.order_status) number_of_orders from salesorder so 
inner join clients c on c.client_number = so.client_number 
where so.order_number in (select order_number from salesorder where order_status like "Successful")
group by c.client_number;

#6. Display the details of clients (client_number, client_name) who have paid for more than 2 orders. 
select c.client_number, c.client_name, count(so.order_status) number_of_orders from salesorder so 
inner join clients c on c.client_number = so.client_number 
where so.order_number in (select order_number from salesorder where order_status like "Successful")
group by c.client_number
having number_of_orders > 2;

#7. Display details of clients who have paid for more than 1 order in descending order of client_number.
select c.* from clients c 
inner join salesorder so on c.client_number = so.client_number
group by so.client_number
having count(so.client_number) > 1
order by c.client_number DESC;

#8. Find the salesman names who sells more than 20 products.
select sm.salesman_name, sum(sod.order_quantity) total_sell_product from salesman sm 
inner join salesorder so on so.salesman_number = sm.salesman_number 
inner join salesorderdetails sod on sod.order_number = so.order_number
group by sm.salesman_name
having total_sell_product > 20;

#9. Display the client information (client_number, client_name) and order number of those clients who 
#have order status is cancelled.
select so.client_number, c.client_name, so.order_number from clients c 
inner join salesorder so on so.client_number = c.client_number
where so.order_number in (select order_number from salesorder where order_status = "Cancelled");

#10. Display client name, client number of clients C101 and count the number of orders which were 
#received “successful”.
select c.client_number, c.client_name, count(*) successful_order from clients c
inner join salesorder so on so.client_number = c.client_number
where so.order_number in (select order_number from salesorder where order_status = "Successful")
and c.client_number = "C101";

#11. Count the number of clients orders placed for each product.
select p.product_number, p.product_name, count(so.client_number) number_of_ordered_clients from salesorder so
inner join salesorderdetails sod on so.order_number = sod.order_number
inner join product p on sod.product_number = p.product_number
group by sod.product_number;

#12. Find product numbers that were ordered by more than two clients then order in descending by product 
#number.
select p.product_number, count(so.client_number) number_of_ordered_clients from salesorder so
inner join salesorderdetails sod on so.order_number = sod.order_number
inner join product p on sod.product_number = p.product_number
group by sod.product_number
having number_of_ordered_clients > 2
order by p.product_number desc;

#13. Find the salesman’s names who is getting the second highest salary.
select salesman_name from salesman 
where salary = (select max(salary) from salesman where salary < (select max(salary) from salesman));

#14. Find the salesman’s names who is getting second lowest salary.
select salesman_name from salesman 
where salary = (select min(salary) from salesman where salary > (select min(salary) from salesman));

#15. Write a query to find the name and the salary of the salesman who have a higher salary than the 
#salesman whose salesman number is S001.
select salesman_name, salary from salesman
where salary > (select salary from salesman where salesman_number = "S001");

#16. Write a query to find the name of all salesman who sold the product has number: P1002.
select sm.salesman_name from salesman sm
inner join salesorder so on so.salesman_number = sm.salesman_number
inner join salesorderdetails sod on sod.order_number = so.order_number
where sod.product_number = "P1002";

#17. Find the name of the salesman who sold the product to client C108 with delivery status is “delivered”.
select sm.salesman_name from salesman sm
inner join salesorder so on sm.salesman_number = so.salesman_number
where so.client_number = "C108" and so.delivery_status = "Delivered";

#18. Display lists the ProductName in ANY records in the sale Order Details table has Order Quantity equal 
#to 5.
select p.product_name from product p
inner join salesorderdetails sod on p.product_number = sod.product_number
where sod.order_quantity = 5;

#19. Write a query to find the name and number of the salesman who sold pen or TV or laptop.
select sm.salesman_name, sm.salesman_number from salesman sm
inner join salesorder so on so.salesman_number = sm.salesman_number
inner join salesorderdetails sod on so.order_number = sod.order_number
inner join product p on p.product_number = sod.product_number
where p.product_name = "pen" or p.product_name = "TV" or p.product_name = "laptop"; 
select * from salesorderdetails;

#20. Lists the salesman’s name sold product with a product price less than 800 and Quantity_On_Hand
#more than 50.
select sm.salesman_name from salesman sm
inner join salesorder so on so.salesman_number = sm.salesman_number
inner join salesorderdetails sod on sod.order_number = so.order_number
inner join product p on p.product_number = sod.product_number
where p.sell_price < 800 and p.quantity_on_hand > 50;

#21. Write a query to find the name and salary of the salesman whose salary is greater than the average 
#salary.
select salesman_name, salary from salesman 
where salary > (select avg(salary) from salesman);

#22. Write a query to find the name and Amount Paid of the clients whose amount paid is greater than the 
#average amount paid.
select client_name, amount_paid from clients
where amount_paid > (select avg(amount_paid) from clients);

#23. Find the product price that was sold to Le Xuan.
select p.sell_price from product p
inner join salesorderdetails sod on p.product_number = sod.product_number
inner join salesorder so on sod.order_number = so.order_number
inner join clients c on so.client_number = c.client_number
where c.client_name = "Le Xuan";

#24. Determine the product name, client name and amount due that was delivered.
select p.product_name, c.client_name, c.amount_due from clients c
inner join salesorder so on so.client_number = c.client_number
inner join salesorderdetails sod on sod.order_number = so.order_number
inner join product p on p.product_number = sod.product_number
where so.delivery_status = 'Delivered';

#25. Find the salesman’s name and their product name which is cancelled.
select sm.salesman_name, p.product_name from salesman sm
inner join salesorder so on so.salesman_number = sm.salesman_number
inner join salesorderdetails sod on sod.order_number = so.order_number
inner join product p on p.product_number = sod.product_number
where so.order_status = 'Cancelled';

#26. Find product names, prices and delivery status for those products purchased by Nguyen Thanh.
select p.product_name, p.sell_price, so.delivery_status from clients c
inner join salesorder so on so.client_number = c.client_number
inner join salesorderdetails sod on sod.order_number = so.order_number
inner join product p on p.product_number = sod.product_number
where c.client_name = 'Nguyen Thanh ';

#27. Display the product name, sell price, salesperson name, delivery status, and order quantity information 
#for each customer.
select p.product_name, p.sell_price, sm.salesman_name, so.delivery_status, sod.order_quantity from clients c
inner join salesorder so on so.client_number = c.client_number
inner join salesorderdetails sod on sod.order_number = so.order_number
inner join product p on p.product_number = sod.product_number
inner join salesman sm on sm.salesman_number = so.salesman_number
group by c.client_number;

#28. Find the names, product names, and order dates of all sales staff whose product order status has been 
#successful but the items have not yet been delivered to the client.
select sm.salesman_name, p.product_name, so.order_date from clients c
inner join salesorder so on so.client_number = c.client_number
inner join salesorderdetails sod on sod.order_number = so.order_number
inner join product p on p.product_number = sod.product_number
inner join salesman sm on sm.salesman_number = so.salesman_number
where so.order_status = 'Successful' and so.delivery_status <> 'Delivered';

#29. Find each clients’ product which in on the way.
select p.* from clients c
inner join salesorder so on so.client_number = c.client_number
inner join salesorderdetails sod on sod.order_number = so.order_number
inner join product p on p.product_number = sod.product_number
where so.delivery_status = 'On way';

#30. Find salary and the salesman’s names who is getting the highest salary.
select salary, salesman_name from salesman 
where salary = (select max(salary) from salesman);

#31. Find salary and the salesman’s names who is getting second lowest salary.
select salary, salesman_name from salesman 
where salary = (select min(salary) from salesman);

#32. Display lists the ProductName in ANY records in the sale Order Details table has Order Quantity more 
#than 9.
select p.product_name from product p
inner join salesorderdetails sod on sod.product_number = p.product_number
where sod.order_quantity > 9;

#33. Find the name of the customer who ordered the same item multiple times.
select c.client_name from clients c
inner join salesorder so on so.client_number = c.client_number
inner join salesorderdetails sod on sod.order_number = so.order_number
inner join product p on p.product_number = sod.product_number
inner join salesman sm on sm.salesman_number = so.salesman_number
where (select count(product_number) from salesorderdetails) > 1
group by c.client_name;

#34. Write a query to find the name, number and salary of the salemans who earns less than the average 
#salary and works in any of Thu Dau Mot city.
select sm.salesman_name, sm.salesman_number, sm.salary from salesman sm
where sm.salary < (select avg(salary) from salesman) and sm.city = 'Thu Dau Mot';

#35. Write a query to find the name, number and salary of the salemans who earn a salary that is higher than 
#the salary of all the salesman have (Order_status = ‘Cancelled’). Sort the results of the salary of the lowest to 
#highest.
select sm.salesman_name, sm.salesman_number, sm.salary from salesman sm
inner join salesorder so on sm.salesman_number = so.salesman_number
where sm.salary > sm.salary in (select sm.salary from salesman sm
inner join salesorder so on sm.salesman_number = so.salesman_number 
where so.order_status = 'Cancelled') order by sm.salary asc;

#36. Write a query to find the 4th maximum salary on the salesman’s table.
select salary from salesman
where salary = (select max(salary) from salesman 
where salary < (select max(salary) from salesman 
where salary < (select max(salary) from salesman 
where salary < (select max(salary) from salesman))));

#37. Write a query to find the 3th minimum salary in the salesman’s table
select salary from salesman
where salary = (select min(salary) from salesman 
where salary > (select min(salary) from salesman 
where salary > (select min(salary) from salesman)));