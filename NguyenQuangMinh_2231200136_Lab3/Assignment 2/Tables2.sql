create database Humanresources;
use Humanresources;

create table employees (
	employee_id varchar(3) primary key,
    lastname varchar(20) not null,
    middle_name varchar(20),
    first_name varchar(20) not null,
    dateOfBirth date not null,
    gender varchar(5) not null,
    salary decimal(18,2) not null,
    address varchar(100) not null
);

create table departments (
	department_id int primary key,
    department_name varchar(10) not null,
    dateOfEmployment date not null
);

create table departmentAddress (
	department_id int,
    address varchar(30),
    foreign key (department_id) references departments(department_id),
    primary key(department_id,address)
);

create table projects (
	project_id int,
    project_name varchar(30) not null,
    project_address varchar(100) not null,
    department_id int,
    foreign key (department_id) references departments(department_id),
    primary key (project_id)
);

create table assignment (
	employee_id varchar(3),
    project_Id int,
    working_hour float not null,
    primary key (employee_id, project_id),
    foreign key (employee_id) references employees(employee_id),
    foreign key (project_id) references projects(project_id)
);

create table relative(
	employee_id varchar(3),
    relative_name varchar(50),
    gender varchar(5) not null,
    dateOfBirth date,
    relationship varchar(30) not null,
    primary key (employee_id, relative_name),
    foreign key (employee_id) references employees (employee_id)
);

alter table employees add (
foreign key (manager_id)references employees(employee_id),
foreign key (department_id) references departments (department_id)
);

select * from employees where manager_id not in (select employee_id from employees);
update employees set manager_id = NULL where manager_id = '';
alter table employees drop foreign key employees_ibfk_1;
alter table employees drop foreign key employees_ibfk_2;

