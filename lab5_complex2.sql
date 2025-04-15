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
select e.lname,
       w.pno
  from employee e
  join works_on w
on e.ssn = w.essn
 order by e.dno,
          e.lname,
          e.fname;



-- 7. Retrieve the name of each employee who has a dependent with the same first 
-- name and is the same sex as the employee.

-- Answer:
select distinct e.fname
  from employee e
  join dependent de
on e.ssn = de.essn
 where de.dependent_name = e.fname
   and e.sex = de.sex;


-- 8. Retrieve the names of employees who have no dependents.

-- Answer:
select e.fname
  from employee e
  left join dependent de
on e.ssn = de.essn
 where de.dependent_name is null;

-- 9. List the names of managers who have at least one dependent.

-- Answer:
select distinct e.fname
  from employee e
  join department d
on e.ssn = d.mgr_ssn
  join dependent de
on e.ssn = de.essn;


-- 10. Find the sum of the salaries of all employees, the maximum salary, the minimum 
-- salary, and the average salary.

-- Answer:
select sum(salary),
       max(salary),
       min(salary),
       avg(salary)
  from employee;

-- 11. For each project, retrieve the project number, the project name, and the number 
-- of employees who work on that project.

-- Answer:
select p.pnumber,
       p.pname,
       count(*)
  from project p
  join works_on w
on p.pnumber = w.pno
 group by p.pnumber,
          p.pname;

-- 12. For each project on which more than two employees work, retrieve the project 
-- number, the project name, and the number of employees who work on the project.

-- Answer:
select p.pnumber,
       p.pname,
       count(*)
  from project p
  join works_on w
on p.pnumber = w.pno
 group by p.pnumber,
          p.pname
having count(*) > 2;

-- 13. For each department that has more than five employees, retrieve the department 
-- number and the number of its employees who are making more than 40,000.

-- Answer:revise this
select d.dnumber,
       count(
          case
             when salary > 40000 then
                1
          end
       ) as rich_niggas
  from department d
  join employee e
on d.dnumber = e.dno
 group by d.dnumber
having count(*) > 0;