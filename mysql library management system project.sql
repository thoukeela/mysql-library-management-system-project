create database library;
use library;

create table branch(
branch_no int primary key,
manager_id int,
branch_address varchar(50),
contact_no int
);

insert into branch values (1, 101, '1st road library,mumbai',1112722 );
insert into branch values (2, 102, 'story spot,chennai',11300322 );
insert into branch values (3, 103, 'library lane,jaipur',1112444 );
insert into branch values (4, 104, 'book haven, bangalore',1199022 );
insert into branch values (5, 105, 'chapter house,kolkata',11134222 );

select * from branch;

create table employee(
emp_id int primary key,
emp_name varchar(20),
position varchar(20),
salary int,
branch_no int,
foreign key(branch_no) references branch (branch_no) on delete cascade
);

insert into employee values(201, 'alice jacob', 'accountant', 40000, 1);
insert into employee values(202, 'niya sharma', 'manager', 70000, 2);
insert into employee values(203, 'shane kapoor', 'sales', 30000, 3);
insert into employee values(204, 'prithvi raj', 'accountant', 50000, 4);
insert into employee values(205, 'kamal hasan', 'assistant', 45000, 5);
insert into employee values(206, 'nisham abdul', 'assistant', 80000, 5);
insert into employee values(207, 'dany maya', 'accountant', 90000, 5);
insert into employee values(208, 'sherin riza', 'HR', 65000, 5);
insert into employee values(209, 'lena toty', 'sales', 35000, 5);
insert into employee values(210, 'ameen zada', 'manager', 60000, 5);


select * from employee;

create table books(
ISBN varchar(20) primary key,
book_title varchar(50),
category varchar(50),
rental_price int,
status varchar(3),
author varchar(50),
publisher varchar(50)
);

insert into books values('1-86092-012-8','crime ','murder', 30, 'yes', 'arnold bennett','abc');
insert into books values('1-86092-055-1','From a View to a Kill','adventure', 20, 'no', 'Ian Fleming', 'rotardo');
insert into books values ('1-86092-038-1', 'The Signalman','suspense', 50, 'yes', 'Charles Dickens', 'dune');
insert into books values ('1-86092-025','The Open Boat','history',60, 'yes', 'Stephen Crane', 'feather');
insert into books values('1-86092-036-5', 'Irish Revel','romance',40, 'no', 'Edna OBrien', 'linda');

select* from books;

create table customer(
customer_id int primary key,
customer_name varchar(50),
customer_address varchar(100),
reg_date date
);

insert into customer values(301,'eva maryam', 'walter house, goa','2024-01-01');
insert into customer values(302,'john paul', 'haven,6th st,kolkata','2023-6-8');
insert into customer values(303, 'diya mirza', 'mannath, mysore','2020-05-4');
insert into customer values(304,'anil kapoor', 'abc,mumbai','2019-09-09');
insert into customer values(305,'faruk khan', 'fatima house, delhi','2021-03-06');

select * from customer;

create table IssueStatus(
issue_id int primary key,
issued_cust int,
foreign key (issued_cust) references customer(customer_id),
issued_book_name varchar(50),
issue_date date,  
isbn_book varchar(20),
foreign key (isbn_book) references books(isbn)
);

insert into issuestatus values(401,301,'crime','2024-1-1','1-86092-012-8' );
insert into issuestatus values(402,302,'From a View to a Kill','2024-3-3','1-86092-055-1');
insert into issuestatus values(403,303,'The Signalman','2024-1-3','1-86092-038-1');
insert into issuestatus values(404,304,'The Open Boat','2023-6-2','1-86092-025');

select * from issuestatus;

create table returnStatus(
return_id int primary key,
return_cust int,
return_book_name varchar(50),
return_date date,
isbn_book2 varchar(20),
foreign key (isbn_book2) references books (isbn)
);

insert into returnstatus values(501,301,'crime','2024-2-2','1-86092-012-8');
insert into returnstatus values(502,302,'From a View to a Kill','2024-4-3','1-86092-055-1');
insert into returnstatus values(503,303,'The Signalman','2024-5-3','1-86092-038-1');
insert into returnstatus values(504,304,'The Open Boat','2024-9-2','1-86092-025');
insert into returnstatus values(505,305,'Irish Revel','2024-3-5','1-86092-036-5');

select * from returnstatus;

-- 1. Retrieve the book title, category, and rental price of all available books. 

select book_title, category, rental_price from books 
where status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary. 

select emp_name,salary from employee
order by salary desc;

-- 3.Retrieve the book titles and the corresponding customers who have issued those books. 

SELECT Issued_Book_Name AS Book_Title, Customer_Name AS Customer 
FROM IssueStatus, Customer WHERE Customer_Id = Issued_Cust;

-- 4.Display the total count of books in each category. 

select category, count(*) as totalbooks from books
group by category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

select emp_name, position from employee where salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet

select customer_name from customer where reg_date < '2022-01-01'
and customer_id not in (select issued_cust from issuestatus);

-- 7.Display the branch numbers and the total count of employees in each branch.

select branch_no, count(*) as total_employees from employee
group by branch_no;

-- 8.  Display the names of customers who have issued books in the month of June 2023.

select customer_name from customer join issuestatus on customer_id = issued_cust
where issue_date between '2023-06-01' and '2023-06-30';

-- 9. Retrieve book_title from book table containing history. 

select Book_title from Books where category = 'history' ;

-- 10. Retrieve the branch numbers along with the count of employees for branches having more than 5 employees

SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee 
GROUP BY Branch_no HAVING COUNT(*) > 5;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.

select emp_name as empname, branch_address as branch
from employee, branch where employee.branch_no = branch.branch_no;

-- 12.Display the names of customers who have issued books with a rental price higher than Rs. 25.

select customer.customer_name from customer
join issuestatus on customer.customer_id = issuestatus.issued_cust
join books on issuestatus.isbn_book = books.isbn
where rental_price > 25;
