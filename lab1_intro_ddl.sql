--1. Create a table employee_temp with ( emp_no, emp_name, emp_address)
create table employee_temp (
   emp_no      number(2),
   emp_name    varchar(20),
   emp_address varchar(40)
);

--2. Insert five employees information.
insert into employee_temp values ( 43,
                                   'kashyap',
                                   'hyd' );
insert into employee_temp values ( 45,
                                   'vinay',
                                   'hyd' );
insert into employee_temp values ( 44,
                                   'sajith',
                                   'blr' );
insert into employee_temp values ( 35,
                                   'sunil',
                                   'krl' );
insert into employee_temp values ( 43,
                                   'satyanarayan',
                                   'tml' );

--3. Display names of all employees.

select emp_name
  from employee_temp;

--4. Display all the employees from ‘MANIPAL’.

update employee_temp
   set
   emp_address = 'mpl'
 where emp_no = 44;
select emp_name
  from employee_temp
 where emp_address = 'mpl';

--5. Add a column named salary to employee table.

alter table employee_temp add (
   sal number(10,2)
);

--6. Assign the salary for all employees.

update employee_temp
   set
   sal = 10000
 where sal is null;

--7. View the structure of the table employee using describe.

desc employee_temp;
select *
  from employee_temp;

--8. Delete all the employees from 'mpl'

delete from employee_temp
 where emp_address = 'mpl';

--9. Rename employee_temp as emp.

alter table employee_temp rename to emp;

--10. Drop the table emp.

drop table emp;