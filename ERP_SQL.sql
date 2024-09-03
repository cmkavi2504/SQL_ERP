ERP_SQL
-------

1.Finance Module:
create database Finance;
use Finance;

[ Accounts_table ]

create table Accounts ( account_id int Auto_increment primary key,
account_name varchar(100) not null,
account_type enum('Asset', 'Liability', 'Equity', 'Revenue', 'Expense') not null ,
balance decimal (15,2) default 0.00
);

INSERT INTO Accounts (account_name, account_type, balance)
VALUES
('Cash', 'Asset', 100000.00),
('Accounts Receivable', 'Asset', 50000.00),
('Accounts Payable', 'Liability', 20000.00),
('Revenue', 'Revenue', 150000.00),
('Operating Expenses', 'Expense', 30000.00);

select * from Accounts;
-------------------------------------------------------------

[ Transactions_table ]

create table Transactions ( transaction_id int Auto_increment primary key,
account_id int,
transaction_date date,
amount decimal(15,2),
transaction_description enum('credit','debit'), 
foreign key (account_id) references Accounts (account_id));

INSERT INTO Transactions (account_id, transaction_date, amount, transaction_description)
VALUES
(1, '2024-08-01', 20000.00, 'credit'),
(2, '2024-08-05', 15000.00, 'debit'),
(3, '2024-08-10', 10000.00, 'credit'),
(4, '2024-08-15', 50000.00, 'debit'),
(5, '2024-08-20', 12000.00, 'credit');

select * from Transactions;
-------------------------------------------------------------
 
 [ Budgets_table ]
 use finance
 create table Budgets ( budget_id int Auto_increment primary key,
 department_id int,
 fiscal_year year,
 budget_amount decimal(15,2),
 FOREIGN KEY (department_id) REFERENCES `supply_chain_and_logistics_module`.Departments(department_id));
 
 INSERT INTO Budgets (department_id, fiscal_year, budget_amount)
VALUES
(1, 2024, 1000000.00),
(2, 2024, 500000.00),
(3, 2024, 300000.00);


select * from Budgets;
-------------------------------------------------------------

 [ Invoices_table ]
 
 create table Invoices ( invoice_id int Auto_increment primary key,
 customer_id int,
 invoice_date date,
 due_date date,
 amount_due decimal(15,2),
 invoice_status enum('Paid', 'Unpaid', 'Overdue'),
 FOREIGN KEY (customer_id) REFERENCES `supply_chain_and_logistics_module`.Customers(customer_id));
 
 INSERT INTO Invoices (customer_id, invoice_date, due_date, amount_due, invoice_status)
VALUES
(1, '2024-08-01', '2024-08-15', 15000.00, 'Unpaid'),
(2, '2024-08-10', '2024-08-24', 20000.00, 'Paid');

select * from Invoices;
--------------------------------------------------------------

[ Payments_table ]

create table Payments( payment_id int Auto_increment primary key, 
invoice_id int,
payment_date date,
amount_paid decimal(15, 2),
FOREIGN KEY (invoice_id) REFERENCES Invoices(invoice_id) );

INSERT INTO Payments (invoice_id, payment_date, amount_paid)
VALUES
(2, '2024-08-15', 20000.00);

select * from Payments;
----------------------------------------------------------------
****************************************************************

      2.Human Resources Module
create database Human_Resources_Module ;
use Human_Resources_Module;

[ Employees_table ]

create table Employees ( employee_id int Auto_increment primary key,
first_name varchar(100),
last_name varchar(100),
department_id int,
hire_date date,
salary decimal(15,2),
job_title varchar(300), 
FOREIGN KEY (department_id) REFERENCES `supply_chain_and_logistics_module`.Departments(department_id) );

INSERT INTO Employees (first_name, last_name, department_id, hire_date, salary, job_title)
VALUES
('John', 'Doe', 1, '2020-01-15', 75000.00, 'Accountant'),
('Jane', 'Smith', 2, '2019-03-20', 80000.00, 'HR Manager'),
('Alice', 'Johnson', 3, '2022-06-10', 60000.00, 'Logistics Coordinator');

select * from Employees;
-------------------------------------------------------------------

[ Payroll_table ]

create table Payroll ( payroll_id  int Auto_increment primary key,
employee_id int,
pay_date date,
gross_pay decimal(15,2),
deductions decimal(15,2),
net_pay decimal(15,2),
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) );

INSERT INTO Payroll (employee_id, pay_date, gross_pay, deductions, net_pay)
VALUES
(1, '2024-08-31', 6250.00, 1000.00, 5250.00),
(2, '2024-08-31', 6666.67, 1200.00, 5466.67),
(3, '2024-08-31', 5000.00, 800.00, 4200.00);

select * from Payroll;
--------------------------------------------------------------------

[ Attendance_table ]

create table Attendance ( attendance_id int Auto_increment primary key,
employee_id int, 
attendance_date date,
attendance_status enum('Present', 'Absent', 'Leave', 'Late'),
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) );

INSERT INTO Attendance (employee_id, attendance_date, attendance_status)
VALUES
(1, '2024-08-01', 'Present'),
(2, '2024-08-01', 'Absent'),
(3, '2024-08-01', 'Present');
select * from Attendance;
----------------------------------------------------------------------

[ Benefits_table ]

create table Benefits ( benefit_id int Auto_increment primary key, 
employee_id int,
benefit_type varchar(300),
benefit_value decimal(15,2),
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) );

INSERT INTO Benefits (employee_id, benefit_type, benefit_value)
VALUES
(1, 'Health Insurance', 5000.00),
(2, 'Pension Plan', 3000.00),
(3, 'Health Insurance', 4000.00);
select * from Benefits;
-------------------------------------------------------------------------
[ Performance_Reviews_table ]

create table PerformanceReviews ( review_id INT AUTO_INCREMENT PRIMARY KEY, 
employee_id int,
review_date date,
score int,
comments text,
FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) );

INSERT INTO PerformanceReviews (employee_id, review_date, score, comments)
VALUES
(1, '2024-08-20', 85, 'Consistent performance'),
(2, '2024-08-20', 90, 'Exceeded expectations'),
(3, '2024-08-20', 75, 'Needs improvement in time management');
select * from PerformanceReviews;
----------------------------------------------------------------------------
****************************************************************************

    3. Supply_Chain & Logistics Module
create database Supply_Chain_and_Logistics_Module;
use Supply_Chain_and_Logistics_Module;  
    
    
 [ Inventory_table ]
 
 create table Inventory ( inventory_id INT AUTO_INCREMENT PRIMARY KEY,
product_name varchar(200),
quantity int, 
unit_price decimal (15,2),
warehouse_id int,
supplier_id int,
FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) );

INSERT INTO Inventory (product_name, quantity, unit_price, warehouse_id, supplier_id)
VALUES
    ('Product A', 100, 50.00, 1, 1),
    ('Product B', 200, 30.00, 2, 2),
    ('Product C', 150, 20.00, 1, 3);
----------------------------------------------------------------------------

[ Orders_table ]

create table Orders ( order_id INT AUTO_INCREMENT PRIMARY KEY,
customer_id int,
order_date date,
status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled'),total_amount DECIMAL(15, 2),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) );

INSERT INTO Orders (customer_id, order_date, status, total_amount)
VALUES
(1, '2024-08-01', 'Shipped', 15000.00),
(2, '2024-08-10', 'Delivered', 20000.00);
------------------------------------------------------------------------------

[ Shipments_table ]

create table Shipments ( shipment_id INT AUTO_INCREMENT PRIMARY KEY,
order_id INT,
shipment_date DATE,
delivery_date DATE,
status ENUM('In Transit', 'Delivered', 'Delayed'),
FOREIGN KEY (order_id) REFERENCES Orders(order_id) );

INSERT INTO Shipments (order_id, shipment_date, delivery_date, status)
VALUES
(1, '2024-08-02', '2024-08-05', 'Delivered'),
(2, '2024-08-11', '2024-08-14', 'Delivered');
-------------------------------------------------------------------------------

[ Suppliers_table ]

create table Suppliers ( supplier_id INT AUTO_INCREMENT PRIMARY KEY,
supplier_name VARCHAR(255),
contact_info VARCHAR(255) );

INSERT INTO Suppliers (supplier_name, contact_info)
VALUES
('Supplier A', 'supplierA@example.com'),
('Supplier B', 'supplierB@example.com'),
('Supplier C', 'supplierC@example.com');
--------------------------------------------------------------------------------

[ Warehouses_table ]

 CREATE TABLE Warehouses (warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
warehouse_name VARCHAR(255),
location VARCHAR(255)  );

INSERT INTO Warehouses (warehouse_name, location)
VALUES
('Warehouse A', 'Location A'),
('Warehouse B', 'Location B');
select * from Warehouses;
--------------------------------------------------------------------------------

[  Delivery Routes_Table ]

CREATE TABLE DeliveryRoutes (route_id INT AUTO_INCREMENT PRIMARY KEY,
route_name VARCHAR(255),
warehouse_id INT,
destination VARCHAR(255),
distance DECIMAL(10, 2),
estimated_time TIME,
FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id) );

INSERT INTO DeliveryRoutes (route_name, warehouse_id, destination, distance, estimated_time)
VALUES
('Route A', 1, 'Destination A', 150.00, '02:30:00'),
('Route B', 2, 'Destination B', 200.00, '03:00:00');
-----------------------------------------------------------------------------------
***********************************************************************************
[ Deoartments_table ]

CREATE TABLE Departments ( department_id INT AUTO_INCREMENT PRIMARY KEY,
department_name VARCHAR(255));
INSERT INTO Departments (department_name)
VALUES
('Finance'),
('Human Resources'),
('Logistics');

select * from Departments;

[ Customer_table ]

CREATE TABLE Customers (customer_id INT AUTO_INCREMENT PRIMARY KEY,
customer_name VARCHAR(255),
contact_info VARCHAR(255) );
INSERT INTO Customers (customer_name, contact_info)
VALUES
('Customer A', 'customerA@yahoo.com'),
('Customer B', 'customerB@gamil.com');

select * from Customers;

---basic_select_query---
Select * from Human_Resources_Module.Attendance;
Select * from Finance.Accounts;
Select * from  supply_chain_and_logistics_module.Inventory;

---select_query_with_where_condition---
Select * from Human_Resources_Module.performancereviews where score>80;
Select * from Finance.invoices where invoice_status='paid';
Select * from  supply_chain_and_logistics_module.orders where customer_id=1;

---aggregate_function---
select sum(balance) as total_balance from finance.Accounts;
select sum(gross_pay) AS total_payroll FROM human_resources_module.Payroll WHERE pay_date BETWEEN '2024-08-01' AND '2024-08-31';
select count(transaction_id),account_id from finance.transactions group by account_id;

---update_query---
use supply_chain_and_logistics_module;
UPDATE supply_chain_and_logistics_module.Inventory SET quantity = quantity + 50 WHERE warehouse_id = 2 AND product_name = 'Product A';
UPDATE supply_chain_and_logistics_module.Inventory SET quantity = quantity - 50 WHERE warehouse_id = 2 AND product_name = 'Product A';

---query_using_joins---
	---display_employee_details---
select a.employee_id,a.first_name,a.last_name,a.salary,b.department_id,b.department_name from human_resources_module.employees as a 
inner join supply_chain_and_logistics_module.departments as b on a.department_id = b.department_id;
	---display_account_&_transaction_details---
use finance;
select a.transaction_id,a.transaction_date,a.transaction_description,a.amount,b.account_id,b.Account_name,b.balance
from transactions as a join accounts as b on a.account_id=b.account_id;

---GROUP_BY_FUNCTION---
	use supply_chain_and_logistics_module;
    SELECT c.customer_name, COUNT(o.order_id) AS total_orders 
FROM customers c 
JOIN Orders o ON c.customer_id = o.customer_id 
GROUP BY c.customer_name;
	use supply_chain_and_logistics_module;
	SELECT w.warehouse_name, SUM(i.quantity * i.unit_price) AS total_revenue 
FROM Inventory i 
inner JOIN Warehouses w ON i.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name;

---___stored_procedures___---
---___fetch_order_details___---
USE `supply_chain_and_logistics_module`;
DELIMITER $$
USE `supply_chain_and_logistics_module`$$
CREATE PROCEDURE `order_details` (in num int)
BEGIN
select * from orders where order_id = num ;
END$$
DELIMITER ;

use `supply_chain_and_logistics_module`;
call order_details(2);

---___check_quantity___---
USE `supply_chain_and_logistics_module`;
DELIMITER $$
USE `supply_chain_and_logistics_module`$$
CREATE PROCEDURE `qua_check` ()
BEGIN
select * from inventory;
END$$
DELIMITER ;

call qua_check;

    
---___create_trigger___---

USE `finance`;
DELIMITER $$
CREATE trigger update_amount
after insert on transactions
for each row
BEGIN
	IF NEW.transaction_description = 'credit' THEN
        UPDATE accounts 
        SET balance = accounts.balance + NEW.amount 
        WHERE accounts.account_id = NEW.account_id;
    ELSEIF NEW.transaction_description = 'debit' THEN
        UPDATE accounts 
        SET balance = accounts.balance - NEW.amount 
        WHERE accounts.account_id = NEW.account_id;
end if;
END$$
DELIMITER ;

---drop_trigger---
drop trigger update_amount;

INSERT INTO finance.transactions (account_id, transaction_date,amount, transaction_description)
VALUES(4, '2024-10-01', 20000.00, 'credit');
use finance;
select * from accounts;
select * from transactions;
