--wont run because of some sys bs on vscode but it will run in reg env
create table lct(
    toc date,
    ID varchar(5),
    course_id varchar(8),
    section_id varchar(8)
);
create or replace trigger takes_trig 
before insert or update of ID, course_id, sec_id or delete 
on takes
for each row
begin
CASE
when inserting then
insert into lct 
values(SYSDATE,:new.id,:new.course_id,:new.sec_id);
when deleting or updating THEN
insert into lct 
values(SYSDATE,:old.id,:old.course_id,:old.sec_id);
end case;
end;
/
create table old_inst(
    id varchar(5),
    salary number(8,2)
);
create or replace trigger sal_track
before update of salary on instructor
for each ROW
BEGIN
    CASE
        when updating THEN
        insert into old_inst 
        values(:old.id,:old.salary);
    end case;
end;
/
