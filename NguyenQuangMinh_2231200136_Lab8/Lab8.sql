use salemanagerment;

#1. Create a trigger before_total_quantity_update to update total quantity of product when
#Quantity_On_Hand and Quantity_sell change values. Then Update total quantity when Product P1004
#have Quantity_On_Hand = 30, quantity_sell =35
delimiter //
create trigger before_total_quantity_update 
before update on product
for each row
begin 
	if new.quantity_on_hand <> old.quantity_on_hand or new.quantity_sell <> old.quantity_sell 
    then set new.total_quantity = new.quantity_on_hand + new.quantity_sell;
    end if;
end//
delimiter ;
drop trigger before_total_quantity_update;
update product set quantity_on_hand = 30, quantity_sell = 35
where product_number = "P1004";

#2. Create a trigger before_remark_salesman_update to update Percentage of per_remarks in a salesman
#table (will be stored in PER_MARKS column) : per_remarks = target_achieved*100/sales_target.
select * from salesman;
alter table salesman add column Per_marks int;
update salesman 
set per_marks = target_achieved*100/sales_target;
delimiter //
create trigger before_remark_salesman_update
before update on salesman
for each row
begin 
	if new.sales_target <> old.sales_target or new.target_achieved <> old.target_achieved then
	update salesman set new.per_marks = new.target_achieved*100/new.sales_target;
    end if;
end//
delimiter ;
drop trigger before_remark_salesman_update;


#3. Create a trigger before_product_insert to insert a product in product table.
select * from product;
delimiter //
create trigger before_product_insert
before insert on product
for each row
begin 
insert into product value (new.product_number, new.product_name, new.quantity_on_hand, 
new.quantity_sell, new.sell_price, new.cost_price, new.profit, new.total_quantity, new.exp_date);
end//
delimiter ;
drop trigger before_product_insert;
insert into product value ("P1009", "Test", 1, 1, 100, 20, 0, 2, "2024-4-3");
delete from product where Product_Number = "P1009";

#4. Create a trigger to before update the delivery status to "Delivered" when an order is marked as
#"Successful"
select * from salesorder;
delimiter //
create trigger before_delivery_status
before update on salesorder
for each row
begin 
	if new.order_status = "Successful" then 
    set new.delivery_status = "Delivery";
    end if;
end//
delimiter ;


#5. Create a trigger to update the remarks "Good" when a new salesman is inserted.
select * from salesman;
delimiter //
create trigger salesman_inserted
before insert on salesman
for each row
begin 
	set new.remark = "Good";
end//
delimiter ;


#6. Create a trigger to enforce that the first digit of the pin code in the "Clients" table must be 7.
select * from clients;
delimiter //
create trigger before_pincode_update
before update on clients
for each row
begin 
	if (new.pincode like "7%") then
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pincode must start with 7';
    end if;
end//
delimiter ;
drop trigger before_pincode_update;

#7. Create a trigger to update the city for a specific client to "Unknown" when the client is deleted
select * from clients;
delimiter //
create trigger before_client_delete
before delete on clients
for each row
begin 
	update clients set city = "Unknown";
end//
delimiter ;

#8. Create a trigger after_product_insert to insert a product and update profit and total_quantity in product
#table
select * from product;
delimiter //
create trigger after_product_insert
after insert on product
for each row
begin 
	update product
	set new.profit = new.sell_price - new.cost_price,
     new.total_quantity = new.quantity_on_hand + new.quantity_sell;
end//
delimiter ;


#9. Create a trigger to update the delivery status to "On Way" for a specific order when an order is inserted.
select * from salesorder;
delimiter //
create trigger after_delivery_inserted
after insert on salesorder
for each row
begin 
	update salesorder set delivery_status = "On way"
    where Order_Number = NEW.Order_Number;
end//
delimiter ;
drop trigger after_delivery_inserted;

#10. Create a trigger before_remark_salesman_update to update Percentage of per_remarks in a salesman
#table (will be stored in PER_MARKS column) If per_remarks >= 75%, his remarks should be ‘Good’.
#If 50% <= per_remarks < 75%, he is labeled as 'Average'. If per_remarks <50%, he is considered
#'Poor'.
select * from salesman;
delimiter //
create  trigger before_remark_salesman_update
before update on salesman
for each row
begin
	if( new.target_achieved <> old.target_achieved or new.sales_target <> old.sales_target) then
		set new.per_marks = (new.target_achieved *100)/new.sales_target;
    if(new.per_marks>=75) then
		set new.remark= 'Good';
    else if (new.per_marks>=50) then
		set new.remark = 'Average';
    else 
		set new.remark = 'Poor';
    end if;
    end if;
    end if;
end //
delimiter ;
drop trigger before_remark_salesman_update;

#11. Create a trigger to check if the delivery date is greater than the order date, if not, do not insert it.
delimiter //
create trigger check_delivery_date
after insert on salesorder
for each row
begin 
	if(new.delivery_date < new.order_date) then
    SIGNAL SQLSTATE '45000' set message_text = 'Invalid';
    end if;
end//
delimiter ;

#12. Create a trigger to update Quantity_On_Hand when ordering a product (Order_Quantity).
delimiter //
create trigger after_ordering_update 
after update on salesorderdetails
for each row
begin 
	update product
    set Quantity_On_Hand = Quantity_On_Hand - new.order_quantity,
     Quantity_Sell = Quantity_Sell + new.order_quantity;
end//
delimiter ;


