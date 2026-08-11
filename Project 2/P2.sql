create database project_work_2;

use project_work_2;

create table customers (
    customerID int primary key,
    firstname varchar(50),
    lastname varchar(50),
    email varchar(100),
    registrationdate date
);

insert into customers (customerid, firstname, lastname, email, registrationdate) values
(1, 'amit', 'sharma', 'amit.sharma@email.com', '2022-03-15'),
(2, 'priya', 'patel', 'priya.patel@email.com', '2021-11-02'),
(3, 'rahul', 'verma', 'rahul.verma@email.com', '2023-01-10'),
(4, 'sneha', 'gupta', 'sneha.gupta@email.com', '2023-05-20'),
(5, 'vikram', 'singh', 'vikram.singh@email.com', '2023-08-05');


create table orders (
    orderID int primary key,
    customerID int,
    orderdate date,
    totalamount decimal(10, 2),
    foreign key (customerID) references customers(customerID)
);

insert into orders (orderid, customerid, orderdate, totalamount) values
(101, 1, '2023-07-01', 150.50),
(102, 2, '2023-07-03', 200.75),
(103, 3, '2023-07-10', 1200.00),
(104, 4, '2023-07-15', 600.00),
(105, 1, '2023-07-20', 50.00);


create table employees (
    employeeID int primary key,
    firstname varchar(50),
    lastname varchar(50),
    department varchar(50),
    hiredate date,
    salary decimal(10, 2)
);

insert into employees (employeeid, firstname, lastname, department, hiredate, salary) values
(1, 'kiran', 'kumar', 'sales', '2020-01-15', 50000.00),
(2, 'pooja', 'sharma', 'hr', '2021-03-20', 55000.00),
(3, 'rohan', 'mehta', 'it', '2019-06-10', 75000.00),
(4, 'neha', 'joshi', 'marketing', '2022-02-01', 45000.00),
(5, 'arjun', 'reddy', 'finance', '2018-11-15', 65000.00);

-- Q1. INNER JOIN:- Retrieve all orders and customer details where orders exist.
select o.orderID, o.orderdate, o.totalamount, c.customerID, c.firstname, c.lastname, c.email, registrationdate
from orders o
inner join customers c on o.customerid = c.customerid;

-- Q2. LEFT JOIN:- retrieve all customers and their corresponding orders (if any).
select c.customerid, c.firstname, c.lastname, c.email, c.registrationdate , o.orderid, o.orderdate, o.totalamount
from customers c
left join orders o on c.customerid = o.customerid;

-- Q3. RIGHT JOIN:- retrieve all orders and their corresponding customers (if any).
select o.orderid, o.orderdate, o.totalamount ,c.customerid, c.firstname, c.lastname, c.email, c.registrationdate 
from customers c
right join orders o on c.customerid = o.customerid;

-- Q4. FULL OUTER JOIN:- retrieve all customers and all orders, regardless of matching.
select c.customerid, c.firstname, c.lastname, c.email, c.registrationdate , o.orderid, o.orderdate, o.totalamount
from customers c
left join orders o on c.customerid = o.customerid

union

select c.customerid, c.firstname, c.lastname, c.email, c.registrationdate , o.orderid, o.orderdate, o.totalamount
from customers c
right join orders o on c.customerid = o.customerid;

-- Q5. find customers who have placed orders worth more than the average order amount.
select distinct c.customerID, c.firstname, c.lastname, o.totalamount from customers c
join orders o on  c.customerID = o.customerID
where o.totalamount > (select avg(totalamount) average_amount from orders);

-- Q6. find employees with salaries above the average salary.
select * from employees e1 cross join (select avg(salary) average_salary from employees) e2 where e1.salary > e2.average_salary;

-- Q7. extract year and month from orderdate
select orderid, orderdate, 
	extract(year from orderdate) as orderyear, 
	extract(month from orderdate) as ordermonth from orders;
    
-- Q8. calculate the difference in days between two dates (orderdate and current date).
select orderid, orderdate,
    current_date as currentdate,
    (current_date - orderdate) days_difference from orders;
    
-- Q9. format the orderdate to a readable format("DD-MMM-YYYY").
select orderid, date_format(orderdate, '%d-%M-%y') as formatted_orderdate from orders;

-- Q10. concatenate firstname and lastname to form a full name.
select firstname, lastname, concat(firstname, ' ' ,lastname) full_name from customers;

-- Q11. replace part of a string (replace 'amit' with 'amitabh').
select customerID, firstname, replace(firstname, 'amit', 'amitabh') updated_firstname from customers;

-- Q12. convert firstname to uppercase and lastname to lowercase.
select firstname, upper(firstname) upper_firstname, lastname, lower(lastname) lower_lastname from customers;

-- Q13. trim extra spaces from the email field.
select email, trim(email) clean_email from customers;

-- Q14. calculate the running total of totalamount for each order.
select orderid, orderdate, totalamount, sum(totalamount) over (order by orderdate, orderid) runningtotal from orders; 

-- Q15. rank orders based on totalamount using the rank() function.
select orderid, totalamount, rank() over (order by totalamount desc) as order_rank from orders;

-- Q16. assign a discount based on totalamount in orders.
select orderid, totalamount,
    case 
        when totalamount > 1000 then '10% off'
        when totalamount > 500  then '5% off'
        else 'no discount'
    end as discount
from orders;

-- Q17. categorize employees' salaries as high, medium, or low.
select employeeID, firstname, lastname, salary,
    case 
        when salary >= 60000 then 'high'
        when salary >= 50000 then 'medium'
        else 'low'
    end as salary_category
from employees;