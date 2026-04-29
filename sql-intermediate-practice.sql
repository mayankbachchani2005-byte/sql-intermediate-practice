CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    city VARCHAR(50),
    join_date DATE
);

INSERT INTO employees (emp_name, department, salary, city, join_date) VALUES
('Amit', 'HR', 30000, 'Delhi', '2022-01-10'),
('Rohit', 'IT', 50000, 'Mumbai', '2021-03-15'),
('Neha', 'Finance', 45000, 'Pune', '2020-07-20'),
('Simran', 'HR', 32000, 'Delhi', '2023-02-11'),
('Karan', 'IT', 60000, 'Bangalore', '2019-11-05'),
('Priya', 'Finance', 48000, 'Chennai', '2022-06-25'),
('Rahul', 'IT', 52000, 'Hyderabad', '2021-08-30'),
('Sneha', 'HR', 31000, 'Delhi', '2020-09-17'),
('Arjun', 'IT', 70000, 'Mumbai', '2018-12-01'),
('Pooja', 'Finance', 46000, 'Pune', '2023-01-12'),
('Vikas', 'IT', 55000, 'Noida', '2022-04-18'),
('Anjali', 'HR', 33000, 'Gurgaon', '2021-05-22'),
('Deepak', 'Finance', 47000, 'Delhi', '2020-10-10'),
('Meena', 'HR', 34000, 'Jaipur', '2023-03-03'),
('Suresh', 'IT', 62000, 'Bangalore', '2019-07-07'),
('Kavita', 'Finance', 49000, 'Mumbai', '2022-11-19'),
('Manoj', 'IT', 58000, 'Hyderabad', '2021-12-25'),
('Ritu', 'HR', 30000, 'Delhi', '2020-06-14'),
('Nikhil', 'Finance', 51000, 'Pune', '2019-02-28'),
('Komal', 'IT', 53000, 'Chennai', '2023-04-01');

select * from employees ;

--Find employees whose salary is above their department average
select * from employees e1 where salary > (select avg(salary) from employees e2
where e1.department = e2.department ) order by department 

--Get second highest salary in the company
select emp_name , salary from employees where salary = (select max(salary) from employees where 
salary < (select max(salary) from employees ))

--Find top 2 highest-paid employees in each department
with mycte as (	
	select emp_name , department , salary,
	dense_rank() over(partition by department order by salary desc) as rankk
	from employees 
)
select * from mycte where rankk <=2

--Show department-wise total salary and average salary
select department , sum(salary) as total, round(avg(salary),2) as avg_
from employees group by department

--Find employees who joined after 2021 and salary > 50,000
select * from employees where join_date > '2020-12-31' and salary > 50000

--Count number of employees in each city, only show cities with more than 1 employee
select city,count(*) from employees group by city having count(*) > 1

--Find highest salary employee in each department
select department, max(salary) as maximum from employees group by department 

--Show employees along with salary difference from highest salary
select emp_name, salary ,
max(salary) over() as maximum,
(max(salary) over() - salary ) as diff
from employees 

--Find employees whose salary is greater than at least one employee in IT department
select * from employees where department = 'IT' and salary > ANY (select salary from employees where department = 'IT' ) 

--Rank employees based on salary (highest first)
select emp_name , department , salary ,
dense_rank() over(order by salary desc) as rankk
from employees 



