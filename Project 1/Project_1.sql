create database project_work;

use project_work;

create table customers (
	customerID int primary key auto_increment,
    name varchar(50),
    email varchar(50),
    address varchar(100)
);

-- Q1. Insert at least 5 sample customers into customers table.
insert into customers (name, email, address) values
('Alice', 'alice@email.com', '123 Wonderland Ave'),
('Bob Smith', 'bob@email.com', '456 Builder St'),
('Charlie Brown', 'charlie@email.com', '789 Peanut Blvd'),
('David Miller', 'david@email.com', '321 Tech Park'),
('Eve Davis', 'eve@email.com', '654 Hacker Way');

-- Q2. Retrieve all customer's details.
select * from customers;

-- Q3. Update a custmoer's address.
update customers set address = "67 New Address" where customerID = 1;

-- Q4. Delete a customer using their customerID.
delete from customers where customerID = 5;

-- Q5. Display all customers whose name is 'Alice'
select * from customers where name = "Alice";




create table orders (
	orderID int primary key auto_increment,
    customerID int,
    order_Date date,
    total_amount decimal (10,2),
    foreign key (customerID) references customers(customerID)
);

-- Q1. Insert at least 5 sample order into Order table.
insert into orders (customerID, order_date, total_amount) values
(1, '2026-08-01', 1200.00),
(2, '2026-07-25', 1400.00),
(1, '2026-08-03', 600.00),
(3, '2026-06-15', 8500.00),
(4, '2026-08-02', 2600.00);

-- Q2. Retrieve all orders made by a specific customers.
select * from orders where customerID = 1;

-- Q3. Update an order's total amount.
update orders set total_amount = 6500.00 where orderID = 4;

-- Q4. Delete an order using its orderID
delete from orders where orderID = 5;

-- Q5. Retrieve orders placed in the last 30 days.
select * from orders where order_date >= date_sub(curdate(), interval 30 day);

-- Q6. Retrieve the highest, lowest and average order amount using aggregate functions.
select max(total_amount) as highest_amount,
	   min(total_amount) as lowest_amount,
       avg(total_amount) as average_amount from orders;
       
       

create table products (
	productID int primary key auto_increment,
    product_name varchar(50),
    price decimal(10,2),
    stock int
);

-- Q1. Insert at least 5 sample products into the products table.
insert into products (product_name, price, stock) values
('Wireless Mouse', 600.00, 50),
('Mechanical Keyboard', 1500.00, 30),
('Gaming Monitor', 8500.00, 15),
('USB-C Cable', 300.00, 0),
('Laptop Stand', 1200.00, 20);

-- Q2. Retrieve all products soreted by price in desending order.
select * from products order by price desc;

-- Q3. Update the price of a specific products.
update products set price = 1400.00 where productID = 2;

-- Q4. Delete a product if it's out of stock.
delete from products where stock = 0;

-- Q5. Retrieve products whose price is between 500 and 2000.
select * from products where price >= 500 and price <= 2000;

-- Q6. Retrieve the most expensive ans cheapest product using MAX() and MIN().
select MAX(price) as Most_Expensive,
	   MIN(price) as Cheapest from products;
       
       


create table order_details (
	orderDetailID int primary key auto_increment,
    orderID int,
    productID int,
    quantity int,
    subtotal decimal (10,2),
    foreign key (orderID) references orders(orderID),
    foreign key (productID) references products(productID)
);

-- Q1. Insert at least 5 sample refcords into the orderDetails table.
insert into order_details (orderID, productID, quantity, subtotal) values
(1, 5, 1, 1200.00),
(2, 2, 1, 1400.00),
(3, 1, 1, 600.00),
(4, 3, 1, 8500.00),
(1, 1, 2, 1200.00);

-- Q2. Retrieve all order details for specific order.
select * from order_details where orderdetailID = 1;

-- Q3. Calculate the total revenue generated from all orders using SUM().
select sum(subtotal) as total_revenue from order_details;

-- Q4. Retrieve the top 3 most ordered products.
select productID, sum(quantity) as quantity_sold from order_details
group by productID order by quantity_sold desc limit 3;

-- Q5. count how many times a specific product has been sold using COUNT().
select count(*) as times_sold from order_details where productID = 1;