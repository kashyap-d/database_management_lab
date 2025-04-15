SET SERVEROUTPUT ON;
--solved example for trying out
declare
dname student.DEPT_NAME%TYPE:='Biology';
sname student.NAME%TYPE;
cursor c1 is select name from STUDENT s where s.DEPT_NAME=dname;
BEGIN
    DBMS_OUTPUT.PUT_LINE('student names in '||dname||' department:');
open c1;
    LOOP
        fetch c1 into sname;
        exit when c1%notfound;
        DBMS_OUTPUT.PUT_LINE(sname);
    end loop;
close c1;
end;
/
COMMIT;

--1
create table sr(
    id VARCHAR2(5) PRIMARY KEY,
    rdate date,
    ramt number(8,2)
);
select salary from INSTRUCTOR where DEPT_NAME='Comp. Sci.';
SAVEPOINT s1;
DECLARE
d instructor.DEPT_NAME%TYPE;
CURSOR c1(dname instructor.DEPT_NAME%TYPE) IS
select * from INSTRUCTOR where DEPT_NAME=dname for UPDATE;
BEGIN
    d:=TO_CHAR('&enter_department_name');
    for c in c1(d) LOOP
    UPDATE INSTRUCTOR SET SALARY=SALARY*1.05 where current of c1;
    INSERT into sr values(c.id,SYSDATE,c.salary*1.05);
    end LOOP;
end;
/
UNDEFINE enter_department_name;--some goofy vscode+oracle issue
--where it stops taking input after the first time unless we do the
--undefine command
ROLLBACK to SAVEPOINT s1;
select * from sr;

--2
declare 
cursor c is 
select * from (select * from student order by TOT_CRED) 
where rownum<11;
BEGIN
    FOR i in c LOOP
    dbms_output.put_line(
        i.ID||','||i.name||','||i.dept_name||','||i.tot_cred);
    end loop;
end;
/

select name,tot_cred from student order by TOT_CRED;

--3 this one is crazy

--4
savepoint s1;

select * from takes where takes.COURSE_ID='CS-101';

DECLARE
cursor c is select * from takes t where t.COURSE_ID='CS-101' for UPDATE;
tcred student.TOT_CRED%TYPE;
BEGIN
    for i in c LOOP
    select tot_cred into tcred from student where id=i.ID;
    if tcred<60 then 
    delete from takes where current of c;
    end if;
    end loop;
end;
/

ROLLBACK to SAVEPOINT s1;--to not change 
--input data

select * from takes where takes.COURSE_ID='CS-101';

--5
select * from std;
update std set std.GRADE='F';

DECLARE
cursor c IS
select * from std for UPDATE;
ch char(2);
BEGIN
    for i in c LOOP
    ch:=GETGRADE(i.rno);
    UPDATE std set std.GRADE=ch where current of c;
    end loop;
end;
/

--6
DECLARE
ch teaches.COURSE_ID%TYPE;
cursor c(cid teaches.COURSE_ID%TYPE) IS
select distinct(te.id) from teaches te where te.COURSE_ID=cid;
iname instructor.NAME%TYPE;
BEGIN
    ch:=('&enter_course_id');
    for i in c(ch) LOOP
    select name into iname from INSTRUCTOR inst where inst.ID=i.ID;
    DBMS_OUTPUT.PUT_LINE(iname);
    end loop;
end;
/
UNDEFINE enter_course_id;
--7
DECLARE
ch course.COURSE_ID%TYPE;
cursor c(ch course.COURSE_ID%TYPE) IS
select distinct(t.ID) from takes t 
where t.COURSE_ID=ch and ch in(
    select COURSE_ID from teaches te 
    where te.ID in(
        select i_id from ADVISOR ad where ad.S_ID=t.ID
    )
);
sname student.NAME%TYPE;
BEGIN
    ch:=('&enter_course_id');
    for i in c(ch) LOOP
    select name into sname from STUDENT s where s.ID=i.ID;
    dbms_output.PUT_LINE(sname);
    end loop;
END;
/