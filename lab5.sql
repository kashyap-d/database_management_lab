-- 1. Retrieve the birth date and address of the employee(s) whose name is ‘John B. Smith’.
-- Retrieve the name and address of all employees who work for the ‘Research’ department.


-- Answer:done


-- 2. For every project located in ‘Stanford’, list the project number, the controlling 
-- department number, and the department manager’s last name, address, and birth date.

-- Answer:done


-- 3. For each employee, retrieve the employee’s first and last name and the first and 
-- last name of his or her immediate supervisor.

-- Answer:done


-- 4. Make a list of all project numbers for projects that involve an employee whose 
-- last name is ‘Smith’, either as a worker or as a manager of the department that 
-- controls the project.

-- Answer:done


-- 5. Show the resulting salaries if every employee working on the ‘ProductX’ project 
-- is given a 10 percent raise.

-- Answer:done


-- 6. Retrieve a list of employees and the projects they are working on, ordered by 
-- department and, within each department, ordered alphabetically by last name, 
-- then first name.

-- Answer:
SELECT e.Lname, w.Pno
FROM EMPLOYEE e
JOIN WORKS_ON w ON e.Ssn = w.Essn
ORDER BY e.Dno, e.Lname, e.Fname;



-- 7. Retrieve the name of each employee who has a dependent with the same first 
-- name and is the same sex as the employee.

-- Answer:
select distinct e.fname from employee e 
join DEPENDENT de on e.SSN=de.ESSN
where de.DEPENDENT_NAME=e.fname and e.SEX=de.SEX;


-- 8. Retrieve the names of employees who have no dependents.

-- Answer:
select e.fname from employee e 
left join DEPENDENT de on e.SSN=de.ESSN
where de.DEPENDENT_NAME is null;

-- 9. List the names of managers who have at least one dependent.

-- Answer:
select distinct e.fname from EMPLOYEE e
join DEPARTMENT d on e.ssn=d.MGR_SSN
join DEPENDENT de on e.ssn=de.ESSN;


-- 10. Find the sum of the salaries of all employees, the maximum salary, the minimum 
-- salary, and the average salary.

-- Answer:
SELECT 
    SUM(Salary), MAX(Salary), MIN(Salary), AVG(Salary)
FROM EMPLOYEE;

-- 11. For each project, retrieve the project number, the project name, and the number 
-- of employees who work on that project.

-- Answer:
select p.pnumber, p.pname, count(*) from project p
join WORKS_ON w on p.PNUMBER=w.PNO
group by p.pnumber,p.PNAME;

-- 12. For each project on which more than two employees work, retrieve the project 
-- number, the project name, and the number of employees who work on the project.

-- Answer:
select p.pnumber, p.pname, count(*) from project p
join WORKS_ON w on p.PNUMBER=w.PNO
group by p.pnumber,p.PNAME having count(*)>2;

-- 13. For each department that has more than five employees, retrieve the department 
-- number and the number of its employees who are making more than 40,000.

-- Answer:revise this
select d.dnumber,count(case when salary>40000 then 1 end) as rich_niggas
from DEPARTMENT d join
employee e on d.DNUMBER=e.DNO
group by d.dnumber having count(*)>0;