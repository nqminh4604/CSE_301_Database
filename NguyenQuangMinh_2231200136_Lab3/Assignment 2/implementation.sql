insert into employees values 
('123', 'Dinh', 'Ba', 'Tien', '1995-09-01', 'Nam', '30000', '731 Tran Hung Dao Q1 TPHCM', '333', '5'),
('333', 'Nguyen', 'Thanh', 'Tung', '1945-08-12', 'Nam', '40000', '638 Nguyen Van Cu Q5 TPHCM', '888', '5'),
('453', 'Tran', 'Thanh', 'Tam', '1962-07-31', 'Nam', '25000', '543 Mai Thi Luu Ba Dinh Ha Noi', '333', '5'),
('666', 'Nguyen', 'Manh', 'Hung', '1952-09-15', 'Nam', '38000', '975 Le Lai P3 Vung Tau', '333', '5'),
('777', 'Tran', 'Hong', 'Quang', '1959-03-29', 'Nam', '25000', '980 Le Hong Phong Vung Tau', '987', '4'),
('888', 'Vuong', 'Ngoc', 'Quyen', '1927-10-10', 'Nu', '55000', '450 Trung Vuong My Tho TG', '', '1'),
('987', 'Le', 'Thi', 'Nhan', '1931-06-20', 'Nu', '43000', '291 Ho Van Hue Q.PN TPHCM', '888', '4'),
('999', 'Bui', 'Thuy', 'Vu', '1958-07-19', 'Nam', '25000', '332 Nguyen Thai Hoc Quy Nhon', '987', '4');

insert into departments values 
('1','Quan ly', '1971-06-19', '888'),
('4', 'Dieu hanh', '1985-01-01', '777'),
('5', 'Nghien cuu', '1978-05-22', '333');

insert into departmentaddress values
('1', 'TP HCM'),
('4', 'HA NOI'),
('5', 'NHA TRANG'),
('5', 'TP HCM'),
('5', 'VUNG TAU');

INSERT INTO Projects values 
('1', 'San pham X', 'VUNG TAU', '5'),
('2', 'San pham Y', 'NHA TRANG', '5'),
('3', 'San pham Z', 'TP HCM', '5'),
('10', 'Tin hoc hoa', 'HA NOI', '4'),
('20', 'Cap Quang', 'TP HCM', '1'),
('30', 'Dao tao', 'HA NOI', '4');

INSERT INTO Assignment values 
('123', '1', '22.5'),
('123', '2', '7.5'),
('123', '3', '10'),
('333', '10', '10'),
('333', '20', '10'),
('453', '1', '20'),
('453', '2', '20'),
('666', '3', '40'),
('888', '20', '0'),
('987', '20', '15');

INSERT INTO relative values 
('123', 'Chau', 'Nu', '1978-12-31', 'Con gai'),
('123', 'Duy', 'Nam', '1978-01-01', 'Con trai'),
('123', 'Phuong', 'Nu', '1957-05-05', 'Vo chong'),
('333', 'Duong', 'Nu', '1948-03-05', 'Vo chong'),
('333', 'Quang', 'Nu', '1976-04-05', 'Con gai'),
('333', 'Tung', 'Nam', '1973-10-25', 'Con trai'),
('987', 'Dang', 'Nam', '1932-02-29', 'Vo chong');

select * from employees;
select * from assignment;
select * from departments;
select * from departmentaddress;
select * from projects;
select * from relative;

