create database SaleManagerment;
use SaleManagerment;

create table clients (
	Client_number varchar(10),
    Client_name varchar(25) not null,
    Address varchar(30),
    City varchar(30),
    Pincode int not null,
    Province char(25),
    Amount_Paid decimal(15,4),
    Amount_Due decimal(15,4),
    check(Client_number like 'C%'),
    primary key (Client_number)
);

create table product(
	Product_Number varchar(15),
    Product_Name varchar(25) not null unique,
    Quantity_On_hand int not null,
    Quantity_Sell int not null,
    Sell_Price decimal(15,4) not null,
    Cost_Price decimal(15,4) not null,
    check(Product_Number like 'P%'),
    check(Cost_Price<>0),
    primary key(Product_Number)
);

create table Salesman(
	Salesman_Number varchar(15),
    Salesman_Name varchar(25) not null,
    Address varchar(30),
    City varchar(30),
    Pincode int not null,
    Province char(25) default ('Viet Nam'),
    Salary decimal(15,4) not null,
    Sales_target int not null,
    Target_Achieved int,
    Phone char(10) not null unique,
    check(Salesman_Number like 'S%'),
    check(Salary<>0),
    check(Sales_target<>0),
    primary key(Salesman_Number)
);

create table SalesOrder(
	Order_Number varchar(15),
    Order_Date date,
    Client_Number varchar(15),
    Salesman_Number varchar(15),
    Delivery_status varchar(15),
    Delivery_date date,
    Order_status varchar(15),
    primary key (Order_Number),
    foreign key (Client_Number) references clients(Client_Number),
    foreign key (Salesman_Number) references Salesman(Salesman_Number),
    check (Order_Number like 'O%'),
    check (Client_Number like 'C%'),
    check (Salesman_Number like 'S%'),
    check (Delivery_Status in ('Delivered', 'On way', 'Ready to ship')),
    check (Delivery_Date>Order_Date),
    check (Order_Status in ('In Process', 'Successful', 'Cancelled'))
);

create table SalesOrderDetails(
	Order_Number varchar(15),
    Product_Number varchar(15),
    Order_Quantity int,
    check (Order_number like 'O%'),
    check (Product_Number like 'P%'),
    foreign key (order_number) references salesorder(Order_Number),
    foreign key (Product_Number) references product (Product_Number)
);