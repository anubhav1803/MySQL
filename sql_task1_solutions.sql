-- 1. Write a query to find the addresses (location_id, street_address, city,
-- state_province, country_name) of all the departments
use hr;

select l.location_id, l.street_address,l.city,l.state_province,c.country_name from locations l 
	join
countries c on l.country_id=c.country_id;


-- 2. Write a query to find the name (first_name, last name), department ID and
-- name of all the employees 

select first_name,last_name,department_id,department_name from employees 
	join
departments using (department_id) ;

-- 3. Write a query to find the name (first_name, last_name), job, department ID
-- and name of the employees who works in London 

select e.first_name,e.last_name,e.job_id,d.department_id from employees e 
join departments d on e.department_id=d.department_id
join locations l on d.location_id=l.location_id
where l.city='London';

-- 4. Write a query to find the employee id, name (last_name) along with their
-- manager_id and name (last_name) 

select a.employee_id,a.last_name 'emp_lastname',b.employee_id 'manager_id', b.last_name 'mgr_last_name'  from employees a join 
	employees b on  a.manager_id=b.employee_id;
    
-- 5. Write a query to find the name (first_name, last_name) and hire date of the
-- employees who was hired after 'Jones' 

select e.first_name,e.last_name,e.hire_date from employees e
	join
    employees a on a.last_name='Jones'
    where e.hire_date>a.hire_date;
    
-- 6. Write a query to get the department name and number of employees in the department

select d.department_name, count(e.employee_id) from departments d join employees e using (department_id) group by d.department_name;

-- 7.  Write a query to display department name, name (first_name, last_name),
/*hire date, salary of the manager for all managers whose experience is more
than 15 years */

select department_name,first_name,last_name,hire_date,salary,(datediff(now(),hire_date))/365 experience from departments d join  employees e
	on d.manager_id=e.employee_id
    where ((datediff(now(),hire_date))/365) > 15;

-- 8.  Write a query to find the name (first_name, last_name) and the salary of the
/*employees who have a higher salary than the employee whose
last_name='Bull' */

select e.first_name,e.last_name,e.salary from employees e 
	join 
		employees a on a.last_name='Bull' 
			where e.salary>a.salary;

select FIRST_NAME, LAST_NAME, SALARY 
from employees 
where SALARY > 
(select salary from employees where last_name = 'Bull');

-- 9. Write a query to find the name (first_name, last_name) of all employee who works in the IT department 
select first_name,last_name from employees e join departments d using (department_id) where department_name='IT' ;

select first_name, last_name 
from employees 
where department_id 
in (select department_id from departments where department_name='IT');

-- 10. Write a query to find the name (first_name, last_name) of the employees
-- who have a manager and worked in a USA based department

 select first_name,last_name from employees 
 where manager_id in 
 (select employee_id  from employees where department_id 
 in (select department_id from departments where location_id 
 in (select location_id from locations where country_id='US' ) ));
 
-- 11. Write a query to find the name (first_name, last_name), and salary of the
-- employees whose salary is greater than the average salary 

select first_name,last_name,salary from employees where salary > ALL(select avg(salary) from employees group by department_id );


-- 12. Write a query to find the name (first_name, last_name), and salary of the
-- employees whose salary is equal to the minimum salary for their job grade 

select first_name,last_name,salary from employees where salary = all(select min_salary from jobs 
	where 
		employees.job_id=jobs.job_id);
             
             
-- 13. Write a query to find the name (first_name, last_name), and salary of the
/*employees who earns more than the average salary and works in any of the IT
departments */

    
select first_name, last_name, salary from employees where department_id in 
(select department_id from departments where department_name like 'IT%') 
and salary > (select avg(salary) from employees);

-- 14. Write a query to find the name (first_name, last_name), and salary of the
-- employees who earn the same salary as the minimum salary for all 

select first_name,last_name,salary from employees where salary = (select min(salary) from employees);

