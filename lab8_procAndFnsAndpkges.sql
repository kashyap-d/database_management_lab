   set serveroutput on;
create or replace procedure dopl (
   msg varchar2
) is
begin
   dbms_output.put_line(msg);
end;
/
/*was just playing around wuth packages
create or replace package emp_bonus AS
PROCEDURE calc_bonus;
PROCEDURE calcc_bonus;
end emp_bonus;
/

create or replace package body emp_bonus AS
PROCEDURE calc_bonus is
BEGIN
    dopl('lol');
end;
end emp_bonus;
/
*/
--1
create or replace procedure p is
begin
   dopl('good day to you');
end;
/

begin
   p;
end;
/

--2
create or replace procedure p (
   dname in varchar
) is
   cursor c1 is
   select name
     from instructor i
    where i.dept_name = dname;
   cursor c2 is
   select title
     from course
    where course.dept_name = dname;
begin
   for i in c1 loop
      dopl(i.name);
   end loop;
   for i in c2 loop
      dopl(i.title);
   end loop;
end;
/

begin
   p('Comp. Sci.');
end;
/

--3
create or replace procedure cpop (
   dname varchar,
   pop   out varchar
) is
   n number := 0;
   cursor c is
   select c.title,
          count(*) as tcount
     from takes t
     join course c
   on t.course_id = c.course_id
    where c.dept_name = dname
    group by c.title;
begin
   for i in c loop
      if i.tcount > n then
         pop := i.title;
         n := i.tcount;
      end if;
   end loop;
end;
/

declare
   pop   course.title%type;
   dname department.dept_name%type;
   cursor c is
   select *
     from department;
begin
   for i in c loop
      cpop(
         to_char(i.dept_name),
         pop
      );
      dopl(pop);
   end loop;
end;
/

--4 easy

--5
create or replace function f (
   n number
) return number as
   m number(5);
begin
   m := n * n;
   return m;
end;
/
begin
   dopl(f(25));
end;
/

--6


--7
/*
Based on the University Database Schema in Lab 2, 
create a package to include the following:
a) A named procedure to list the instructor_names of 
given department
b) A function which returns the max salary for the given department
c) Write a PL/SQL block to demonstrate the 
usage of above package components
*/
create or replace package tempuni as
   procedure inst_name_from_dep (
      dname varchar
   );
   function get_maxsal (
      dname varchar
   ) return number;
end;
/
create or replace package body tempuni as
   procedure inst_name_from_dep (
      dname varchar
   ) is
      cursor c is
      select name
        from instructor i
       where i.dept_name = dname;
   begin
      for j in c loop
         dopl(j.name);
      end loop;
   end;
   function get_maxsal (
      dname varchar
   ) return number as
      n instructor.salary%type;
      cursor c is
      select salary
        from instructor i
       where i.dept_name = dname
         and i.salary >= all (
         select salary
           from instructor
          where dept_name = dname
      );
   begin
      for i in c loop
         n := i.salary;
      end loop;
      return n;
   end;
end tempuni;
/

begin
   dopl(tempuni.get_maxsal('Comp. Sci.'));
   tempuni.inst_name_from_dep('Comp. Sci.');
end;
/