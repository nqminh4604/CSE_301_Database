use salemanagerment;

#1. SQL statement returns the cities (only distinct values) from both the "Clients" and the "salesman"
#table.
select city from clients
union
select city from salesman;

#2. SQL statement returns the cities (duplicate values also) both the "Clients" and the "salesman" table.
select city from clients
union all
select city from salesman;

#3. SQL statement returns the Ho Chi Minh cities (only distinct values) from the "Clients" and the
#"salesman" table.
select city from clients where city = "Ho Chi Minh"
union
select city from salesman;

#4. SQL statement returns the Ho Chi Minh cities (duplicate values also) from the "Clients" and the
#"salesman" table.
select city from clients where city = "Ho Chi Minh"
union all
select city from salesman;

#5. SQL statement lists all Clients and salesman.
select client_name `Name`, 'client' `type` from clients
union
select salesman_name `Name`, 'salesman' `type` from salesman;

#6. Write a SQL query to find all salesman and clients located in the city of Ha Noi on a table with
#information: ID, Name, City and Type.
select client_number, Client_name, city, 'client' `Type` from clients where city = "Hanoi"
union
select salesman_number, salesman_name, city, 'salesman' `Type` from salesman where city = "Hanoi";

#7. Write a SQL query to find those salesman and clients who have placed more than one order. Return
#ID, name and order by ID.
select c.client_number, c.Client_name, 'client' `Type` from clients c 
inner join salesorder so on c.Client_number = so.client_number
group by c.client_number
having count(so.Client_number) > 1
union
select sm.salesman_number, sm.salesman_name, 'salesman' `Type` from salesman sm
inner join salesorder so on so.Salesman_Number = sm.Salesman_Number
group by sm.salesman_number
having count(so.salesman_number) > 1;

#8. Retrieve Name, Order Number (order by order number) and Type of client or salesman with the client
#names who placed orders and the salesman names who processed those orders.
select c.client_number, c.Client_name, so.order_number, sm.Salesman_Name, 'client' `Type` from clients c 
inner join salesorder so on c.Client_number = so.client_number
inner join salesman sm on sm.Salesman_Number = so.Salesman_Number
order by so.Order_Number;

#9. Write a SQL query to create a union of two queries that shows the salesman, cities, and
#target_Achieved of all salesmen. Those with a target of 60 or greater will have the words 'High
#Achieved', while the others will have the words 'Low Achieved'.
select salesman_name, city, target_achieved, case when Target_Achieved >= 60 then "High Achieved" end "Rate"
from salesman where Target_Achieved >= 60
union
select salesman_name, city, target_achieved, case when Target_Achieved < 60 then "Low Achieved" end "Rate"
from salesman where Target_Achieved < 60;

-- 10. Write query to creates lists all products (Product_Number AS ID, Product_Name AS Name,
-- Quantity_On_Hand AS Quantity) and their stock status. Products with a positive quantity in stock are
-- labeled as 'More 5 pieces in Stock'. Products with zero quantity are labeled as ‘Less 5 pieces in Stock'.
select product_number id, product_name `name`, quantity_on_hand quantity, 
case when quantity_on_hand > 0 then "More 5 pieces in Stock" else "Less 5 pieces in Stock" end "Stock status"
from product;

#11. Create a procedure stores get_clients _by_city () saves the all Clients in table. Then Call procedure
#stores.
Delimiter $$
Create procedure get_clients_by_city (in city_name varchar(30))
begin
	select * from clients
    where city = city_name;
end$$
delimiter ;
call get_clients_by_city("Hanoi");

#12. Drop get_clients _by_city () procedure stores.
drop procedure get_clients_by_city;

#13. Create a stored procedure to update the delivery status for a given order number. Change value
#delivery status of order number “O20006” and “O20008” to “On Way”.
select * from salesorder where order_number = "O20006" or order_number = "O20008";
delimiter $$
create procedure update_status()
begin
	update salesorder set delivery_status = "On way"
    where order_number = "O20006" or order_number = "O20008";
end$$
delimiter ;
call update_status();


#14. Create a stored procedure to retrieve the total quantity for each product.
delimiter  $$
create procedure show_quantity()
begin
	select product_number, product_name, total_quantity from product;
end$$
delimiter ;
call show_quantity();
salesman
#15. Create a stored procedure to update the remarks for a specific salesman.
delimiter  $$
create procedure update_remark_salesman(in sm_number varchar(15), in sm_remark varchar(10))
begin
	update salesman set remark = sm_remark
    where salesman_number = sm_number;
end$$
delimiter ;
select * from salesman;
call update_remark_salesman("S001", "Good");

#16. Create a procedure stores find_clients() saves all of clients and can call each client by client_number.
delimiter  $$
create procedure find_client(c_number varchar(10))
begin
	select * from clients
    where Client_number = c_number;
end$$
delimiter ;


#17. Create a procedure stores salary_salesman() saves all of clients (salesman_number, salesman_name,
#salary) having salary >15000. Then execute the first 2 rows and the first 4 rows from the salesman
#table.
delimiter  $$
create procedure salary_salesman(in limit_number int)
begin
	select salesman_number, salesman_name, salary from salesman
    where salary > 15000
    order by salary desc limit limit_number;
end$$
delimiter ;
call salary_salesman(4);

#18. Procedure MySQL MAX() function retrieves maximum salary from MAX_SALARY of salary table.
delimiter  $$
create procedure max_salary()
begin
	select max(salary) from salesman;
end$$
delimiter ;
call max_salary();

#19. Create a procedure stores execute finding amount of order_status by values order status of salesorder
#table.
delimiter  $$
create procedure amount_order_status()
begin
	select order_status, count(*) amount from salesorder
	group by order_status;
end$$
delimiter ;
call amount_order_status();

#21. Count the number of salesman with following conditions : SALARY < 20000; SALARY > 20000; 
delimiter  $$
create procedure amount_salary()
begin
	select count(*) amount, 'under_20000' `Condition` from salesman where salary < 20000
    union all
    select count(*) amount, 'above_20000' `Condition` from salesman where salary > 20000;
end$$
delimiter ;
drop procedure amount_salary;
call amount_salary();


#22. Create a stored procedure to retrieve the total sales for a specific salesman.
select * from salesorder;
delimiter  $$
create procedure total_sales_of_salesman(sm_number varchar(15))
begin
	select sum(order_quantity) total from salesorder so, salesorderdetails sod
where so.Order_Number = sod.Order_Number and so.Salesman_Number = sm_number;
end$$
delimiter ;
drop procedure total_sales_of_salesman;
call total_sales_of_salesman("S005");


#23. Create a stored procedure to add a new product:
#Input variables: Product_Number, Product_Name, Quantity_On_Hand, Quantity_Sell, Sell_Price,
#Cost_Price.
delimiter  $$
create procedure add_product(in p_number varchar(15), in p_name varchar(25), in p_quantity_on_hand int,
								in p_quantity_sell int, in p_sell_price decimal(15,4), in p_cost_price decimal(15,4))
begin
	insert into product value (p_number, p_name, p_quantity_on_hand, p_quantity_sell, p_sell_price, p_cost_price);
end$$
delimiter ;


#24. Create a stored procedure for calculating the total order value and classification:
#- This stored procedure receives the order code (p_Order_Number) và return the total value
#(p_TotalValue) and order classification (p_OrderStatus).
#- Using the cursor (CURSOR) to browse all the products in the order (SalesOrderDetails ).
#- LOOP/While: Browse each product and calculate the total order value.
#- CASE WHEN: Classify orders based on total value:
#Greater than or equal to 10000: "Large"
#Greater than or equal to 5000: "Midium"
#Less than 5000: "Small"