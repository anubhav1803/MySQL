use office;
-- 1) Write a sql query to display employee id, full name of employee and salary from office table.

select employee_id, concat(first_name,' ',last_name) 'full_name',salary from office;
select * from office where year(joining_date)=201;
select * from office;
-- 2) Write a sql query to display employee id and dept id of employees who have joined after the year 2015.
select employee_id, dept_id, joining_date from office 
where year(joining_date) >= (select year(joining_date) from office where year(joining_date)= 2017);

-- 3) Write a sql query to display first 4 characters of last name from office table.

select last_name,substring(last_name,1,4) from office;

-- 4) Write a sql query to display last 4 characters of first name from office table.

select first_name,substring(first_name,-4) from office;

-- 5) Write a sql query to display employees whose first name contains ‘mi’ for eg,Amisha.
select * from office where first_name like '%mi%';

-- 6) Write a sql query to display employee id and full name of employees in capitals.
select upper(employee_id),upper(concat(first_name,' ',last_name)) 'full_name' from office;

-- 7) Write a sql query to display only the second highest salary from office table.
select *,nth_value(salary,2) over (order by salary desc) 'second_highest'from office limit 2 ;

-- 8) Write a sql query to delete records from the office table in which job id is ACC.
delete from office where job_id ='acc';
select * from office;

-- 9) Write a sql query to display records average salary of employees in each departement.
select *,avg(salary) from office group by dept_id;

-- 10) Write a sql query to unique department id and corresponding job id.
select * from office;
select distinct dept_id, job_id from office order by dept_id;

-- 11) Write a sql query to display lowest 5 salaries from the office table.
select employee_id,salary from office order by salary limit 5;

-- 12) Write a sql query to add ‘Rs.’ before salary in the salary column.
select employee_id,first_name,last_name,concat('Rs.',salary) 'salary' from office;
-- 13) Write a sql query to remove ‘Rs.’ from the salary column.

-- 14) Write a sql query to display employees who were hired as clerk or IT programmer in the month of July and after the year 2012.
select * from office 
where year(joining_date) >= (select year(joining_date) from office where year(joining_date)= 2013) and monthname(joining_date)='july' 
and job_id in (select job_id from office where job_id= 'clerk' or job_id='it_prog');

-- 15) Write a sql query to display top 2 recently hired employees.
select *,datediff(now(),joining_date) from office order by datediff(now(),joining_date) limit 2;

-- 16) Write a sql query to add a record in the table with values- employee id=113, first name=
/*Garvit, last name= Sharma, salary= 13500, job id= SALES, department id= 25, and joining 
date is 14th November 2014.*/

insert into office values(113,'Grvit','Sharma',13500,'SALES',25,STR_TO_DATE('14-11-2014', '%d-%m-%Y'));
select * from office;

-- 17) Write a sql query to find number of employees with salary between 7000 and 15000 (both
/*exclusive) in each department.Write an sql query to display details of employees whose salary
is greater than the maximum salary of employees fromACC dept or less than the minimum
salary of employees from IT dept.*/
select count(*) from office where salary between 7000 and 15000 ;
select * from office where salary between (select max(salary) from office where job_id='acc') 
and ( select min(salary) from office where job_id='it_prog');

-- 18) Write a sql query to increase employee id by 25 where the current employee id is odd.
update office
set employee_id=employee_id+25 where mod(employee_id,2)=1;
select * from office;

-- 19) Write a sql query to delete all the records from the table while maintaining the schema of the table.
truncate table office;
select * from office;