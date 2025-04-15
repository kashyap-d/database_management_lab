/* --1
create table emp
(eno number(2) primary key,
ename varchar(20) not null,
gender char(1) not null check (gender in('M','F')),
sal number(10,2) not null,
addr varchar(40) not null
);

--2
create table dep(
    depno number(2) primary key,
    depname varchar(10) not null UNIQUE
);

--3//understand the exact working of foreign key and its purpose
alter table emp add (dno number(2));
alter table emp modify (dno number(4));
alter table dep modify (depno number(4));
alter table emp add CONSTRAINT fkdno FOREIGN key(dno) REFERENCES dep(depno);
desc emp;

--4
insert into dep values(1111,'cse');
insert into dep values(2222,'ece');
insert into dep values(3333,'dse');
insert into dep values(4444,'eee');
INSERT into emp VALUES(43,'kashyap','M',12345678.12,'hyd',1111);
INSERT into emp VALUES(22,'bun','M',1234567.12,'blr',2222);
INSERT into emp VALUES(55,'tanav','M',123456.12,'krl',3333);
INSERT into emp VALUES(60,'mudit','M',12345679.12,'bmb',4444);
select * from emp join dep on emp.dno=dep.DEPNO;

--5
--done

--6
--done

--7
alter table emp drop constraint fkdno;
alter table emp add constraint fkdno foreign key(dno) references dep(depno) on delete cascade;
--trying out cascade delete
delete from dep where depno=4444;

--8
alter table emp modify sal default 10000;
--if no value inserted default const makes sal 10000
INSERT into emp(eno,ename,gender,addr,dno) VALUES(44,'vinay','M','hyd',1111);
--if value inserted then there is no constraint acting here
INSERT into emp(eno,ename,gender,addr,dno,sal) VALUES(45,'vinay2','M','hyd',1111,1);
delete from emp where ename like '%vinay%'; */

--9 and 10 done

--11
select c.title
  from course c
 where dept_name = 'Comp. Sci.'
   and credits = 3;

--12
select c.course_id,
       c.title
  from student s
  join takes t
on s.id = t.id
  join course c
on t.course_id = c.course_id
 where s.id = 12345;

--13
select name
  from instructor
 where salary between 40000 and 90000;

--14
select i.id
  from instructor i
  left join teaches te
on i.id = te.id
 where te.id is null;

--15//on basis of what are 
select s.name,
       c.title,
       sec.year
  from student s
  join takes t
on s.id = t.id
  join course c
on t.course_id = c.course_id
  join section sec
on sec.sec_id = t.sec_id
   and sec.course_id = t.course_id
   and sec.year = t.year
   and sec.semester = t.semester
 where sec.room_number = 303;

--16//year hanged to 2009 as 2015 has no output
select name,
       title as c_name
  from student
  join takes
on student.id = takes.id
  join course
on takes.course_id = course.course_id
 where takes.year = 2009;

--17
select distinct i1.name,
                i1.salary as inst_salary
  from instructor i1
 where i1.salary > some (
   select i2.salary
     from instructor i2
    where i2.dept_name = 'Comp. Sci.'
);

--18
select name
  from instructor
 where name like '%ei%';

--19
select name,
       length(name)
  from student;

--20
select dept_name,
       substr(
          dept_name,
          3,
          3
       )
  from department;

--21
select upper(name)
  from instructor;

--22
insert into instructor (
   id,
   name
) values ( 123,
           'gopala' );
select name,
       nvl(
          salary,
          0
       ) as inst_salary
  from instructor;
delete from instructor
 where name = 'gopala';

--23
select salary,
       round(
          salary / 3,
          2
       )
  from instructor;

--24
alter table instructor add (
   dob date
);
update instructor
   set
   dob = '8-feb-2005'
 where dob is null;
--select * from instructor;
update instructor
   set
   dob = '18-feb-05'
 where dob = '8-feb-2005';
--select * from instructor;

select to_char(
   dob,
   'DD-MON-YYYY'
),
       to_char(
          dob,
          'DD-MON-YY'
       ),
       to_char(
          dob,
          'DD-MM-YY'
       )
  from instructor;

alter table instructor drop column dob;

--25
select to_char(
   dob,
   'YEAR'
) as first,
       to_char(
          dob,
          'year'
       ) as second,
       to_char(
          dob,
          'Year'
       ) as third
  from instructor;
--or
--in the below query no matter what you keep in 'year' we get same output as we're manually formatting it
select upper(to_char(
   dob,
   'YEAR'
)) as first,
       initcap(to_char(
          dob,
          'YEAR'
       )) as second,
       lower(to_char(
          dob,
          'YEAR'
       )) as third
  from instructor;
alter table instructor drop column dob;

--additional ex

--1
alter table teaches add (
   constraint check_year check ( year > 2000 )
);
alter table teaches drop constraint check_year;
select *
  from emp;
alter table emp add (
   constraint check_sal check ( sal > 5000 )
);
insert into emp values ( 1,
                         'kas',
                         'M',
                         20000,
                         'hyd',
                         2222 );

--2
select dob,
       to_char(
          dob,
          'Q'
       )
  from instructor;

--3 and 4 too random, not relevant

--5
select distinct dept_name
  from department
natural join instructor;
--note: in natural join the dept_name col of the 2 tables are merged unlike in inner join where they're still 2 distinct 
--columns, which is why we wont get an ambiguity error here

--6
select distinct i.name,
                c.course_id
  from instructor i
  join teaches te
on i.id = te.id
  join course c
on te.course_id = c.course_id;

--7
select distinct name,
                title
  from instructor
natural join teaches
natural join course;

--8
select s.name as std_name,
       s.dept_name,
       i.name as inst_name,
       count(*) as no_of_courses_taken
  from student s
  left join advisor a
on s.id = a.s_id
  left join instructor i
on a.i_id = i.id
  left join takes t
on s.id = t.id
 group by ( s.name,
            s.dept_name,
            i.name );