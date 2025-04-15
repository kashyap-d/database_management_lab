-- Set Operations

-- UNION (Use UNION ALL to retain duplicates)
-- 1. Find courses that ran in Fall 2009 or in Spring 2010
select c.title from course c join
section s on c.COURSE_ID=s.COURSE_ID
where s.SEMESTER='Fall' and s.YEAR=2009
UNION
select c.title from course c join
section s on c.COURSE_ID=s.COURSE_ID
where s.SEMESTER='Spring' and s.YEAR=2010;

-- INTERSECT (Use INTERSECT ALL to retain duplicates)
-- 2. Find courses that ran in Fall 2009 and in Spring 2010
select c.title from course c join
section s on c.COURSE_ID=s.COURSE_ID
where s.SEMESTER='Fall' and s.YEAR=2009
INTERSECT
select c.title from course c join
section s on c.COURSE_ID=s.COURSE_ID
where s.SEMESTER='Spring' and s.YEAR=2010;

-- MINUS
-- 3. Find courses that ran in Fall 2009 but not in Spring 2010
select c.title from course c join
section s on c.COURSE_ID=s.COURSE_ID
where s.SEMESTER='Fall' and s.YEAR=2009
minus
select c.title from course c join
section s on c.COURSE_ID=s.COURSE_ID
where s.SEMESTER='Spring' and s.YEAR=2010;

-- Null values

-- 4. Find the name of the course for which none of the students registered.
select title from course c
left join takes t on c.COURSE_ID=t.COURSE_ID
where t.COURSE_ID is null;

-- Nested Subqueries

-- Set Membership (IN / NOT IN)
-- 5. Find courses offered in Fall 2009 and in Spring 2010.
select c.title from course c join
section s on c.COURSE_ID=s.COURSE_ID
where s.SEMESTER='Fall' and s.YEAR=2009
and c.title in(
    select c.title from course c join
    section s on c.COURSE_ID=s.COURSE_ID
    where s.SEMESTER='Spring' and s.YEAR=2010
);

-- 6. Find the total number of students who have taken a course taught by the instructor with ID 10101.
select count(distinct t.id) from teaches te
join course c on te.course_id=c.COURSE_ID
join takes t on t.COURSE_ID=c.COURSE_ID
where te.id=10101;

-- 7. Find courses offered in Fall 2009 but not in Spring 2010.
select c.title from course c join
section s on c.COURSE_ID=s.COURSE_ID
where s.SEMESTER='Fall' and s.YEAR=2009
and c.title not in(
    select c.title from course c join
    section s on c.COURSE_ID=s.COURSE_ID
    where s.SEMESTER='Spring' and s.YEAR=2010
);

-- 8. Find the names of all students whose name is the same as the instructor’s name.
select distinct name from student WHERE
name in(select distinct name from INSTRUCTOR);

-- Set Comparison (>= SOME / ALL)
-- 9. Find names of instructors with salary greater than that of some (at least one) instructor in the Biology department.
select name from INSTRUCTOR
where SALARY>some(select salary from instructor where dept_name='Biology');

-- 10. Find the names of all instructors whose salary is greater than the salary of all instructors in the Biology department.
select name from INSTRUCTOR
where SALARY>all(select salary from instructor where dept_name='Biology');

-- 11. Find the departments that have the highest average salary.
select dept_name from INSTRUCTOR
group by dept_name having avg(SALARY)>=all(
    select avg(salary) from INSTRUCTOR
    group by dept_name );

-- 12. Find the names of those departments whose budget is lesser than the average salary of all instructors.
--done

-- Test for Empty Relations (EXISTS / NOT EXISTS)
-- 13. Find all courses taught in both the Fall 2009 semester and in the Spring 2010 semester.
select distinct title from course c
where exists(
    select 1 from
    section s where s.year=2009 and s.semester='Fall' and c.COURSE_ID=s.course_id
)
and EXISTS(
    select 1 from
    section s where s.year=2010 and s.semester='Spring' and c.COURSE_ID=s.course_id
);

-- 14. Find all students who have taken all courses offered in the Biology department.
select s.name from student s
where not EXISTS(
    select c.title from course c where c.DEPT_NAME='Biology'
    and not exists(
        select 1
        from takes t where t.id=s.id and t.COURSE_ID = c.COURSE_ID
    )
);
--or
select s.name from student s
where not exists(
    select c.course_id from course c where c.dept_name='Biology'
    MINUS
    select t.COURSE_ID from takes t where t.ID = s.ID
);

-- Test for Absence of Duplicate Tuples
-- 15. Find all courses that were offered at most once in 2009.
select c.title from COURSE c join section sec on c.COURSE_ID=sec.COURSE_ID
where sec.YEAR=2009
group by c.TITLE having count(*)<=1;

-- 16. Find all the students who have opted for at least two courses offered by the CSE department.
select s.name from student s join takes t on s.id=t.ID
join course c on t.course_id=c.COURSE_ID where  c.DEPT_NAME='Comp. Sci.'
group by s.name having count(*)>=2;

-- Subqueries in the FROM Clause
-- 17. Find the average instructor salary of those departments where the average salary is greater than 42000.


-- Views
-- 18. Create a view all_courses consisting of course sections offered by the Physics department in the Fall 2009, with the building and room number of each section.


-- 19. Select all the courses from the all_courses view.


-- 20. Create a view department_total_salary consisting of department name and total salary of that department.
