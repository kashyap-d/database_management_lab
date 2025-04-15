--1
--done
select count(*) from takes group by course_id;

--2
--done
select dept_name from STUDENT 
group by dept_name having count(*)>=1;

--3
--done

--4
--done
select dept_name,avg(salary) from INSTRUCTOR 
group by dept_name having avg(salary)>42000;

--5
--q is vague
select s.sec_id,count(ID) as std_enrl
from section s join takes t on s.SEC_ID=t.SEC_ID
where s.SEMESTER='Spring' and s.YEAR=2009
group by s.sec_id;

--6
--done

--7
--done

--8
--method is working here only but in general its not allowed
select max(sum(salary)) from INSTRUCTOR group by DEPT_NAME;
--or
--simple way
select sum(i1.salary) from INSTRUCTOR i1 group by DEPT_NAME
having sum(i1.salary)>=all(
    select sum(i2.salary) from INSTRUCTOR i2 group by DEPT_NAME
);
--or

select sum(i1.salary) from INSTRUCTOR i1 group by DEPT_NAME
having sum(i1.salary)=(
    select max(tsal) from (select sum(i2.salary) as tsal from
    INSTRUCTOR i2 group by DEPT_NAME)
);

--9
--done

--10
--get clarity on these qs and then proceed later
select s.sec_id
from section s join takes t on s.SEC_ID=t.SEC_ID
where s.SEMESTER='Spring' and s.YEAR=2010
group by s.sec_id having count(t.id)=(
    select max() from
    section s1 join takes t1 on s1.SEC_ID=t1.SEC_ID
    where s1.SEMESTER='Spring' and s1.YEAR=2010
    group by s1.sec_id having count(t1.id)
);

--11 revise
select DISTINCT i.name from instructor i join teaches te on
i.id=te.id join TAKES t on te.COURSE_ID=t.COURSE_ID
join STUDENT s on s.id=t.ID
where s.dept_name='Comp. Sci.'--see why the dept_name is req here
group by i.NAME
having count(distinct s.id)=
(select count(distinct id) from 
student where dept_name='Comp. Sci.');
--or
select distinct i.name from INSTRUCTOR i
where not EXISTS(
    select s.id from student s
    where dept_name='Comp. Sci.'and not EXISTS(
        select 1
        from takes t join teaches te on t.COURSE_ID=te.COURSE_ID
        where t.id=s.id and te.id=i.ID
    )
);

--12
select DEPT_NAME,avg(salary) from INSTRUCTOR
group by DEPT_NAME having 
avg(SALARY)>50000 and count(ID)>5;

--13
select d.dept_name from DEPARTMENT d
where d.BUDGET=(select max(d1.BUDGET) from DEPARTMENT d1);

--or (using with clause)
with bigdep as(
    select max(budget) as maxval from DEPARTMENT
)
select dept_name from DEPARTMENT
where budget=(select maxval from bigdep);

--14
select i.dept_name from INSTRUCTOR i
group by i.dept_name HAVING
sum(i.SALARY)>(select avg(tsal) from(
    select sum(i1.salary) as tsal from INSTRUCTOR i1
    group by i1.DEPT_NAME
));

--or (using with clause)
with tsal as(
    select sum(salary) as dept_tsal from INSTRUCTOR
    group by dept_name
)
select dept_name from instructor
group by dept_name having sum(salary)>(select avg(dept_tsal) from tsal);