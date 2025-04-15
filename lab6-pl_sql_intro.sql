   set SERVEROUTPUT ON;
--trial run
declare
   msg varchar2(20) := 'Hello, World!';
begin
   dbms_output.put_line(msg);
end;
/
--1
create table std (
   rno number(2),
   gpa number(4,2)
);

insert into std values ( 1,
                         5.8 );
insert into std values ( 2,
                         6.5 );
insert into std values ( 3,
                         3.4 );
insert into std values ( 4,
                         7.8 );
insert into std values ( 5,
                         9.5 );

declare
   rollno std.rno%type;
   n      number(
      4,
      2
   );
begin
   rollno := '&enter_roll_no';
   select s.gpa
     into n
     from std s
    where s.rno = rollno;
   dbms_output.put_line('the gpa of the student with rno '
                        || rollno
                        || ' is: '
                        || n);
end;
/
--2
declare
   rollno std.gpa%type;
   n      number(
      4,
      2
   );
   c      char(2);
begin
   rollno := ( '&enter_roll_no' );
   select s.gpa
     into n
     from std s
    where s.rno = rollno;

   if n <= 4 then
      c := 'F';
      dbms_output.put_line('the grade of the student with rno '
                           || rollno
                           || ' is: '
                           || c);
   elsif n <= 5 then
      c := 'E';
      dbms_output.put_line('the grade of the student with rno '
                           || rollno
                           || ' is: '
                           || c);
   elsif n <= 6 then
      c := 'D';
      dbms_output.put_line('the grade of the student with rno '
                           || rollno
                           || ' is: '
                           || c);
   elsif n <= 7 then
      c := 'C';
      dbms_output.put_line('the grade of the student with rno '
                           || rollno
                           || ' is: '
                           || c);
   elsif n <= 8 then
      c := 'B';
      dbms_output.put_line('the grade of the student with rno '
                           || rollno
                           || ' is: '
                           || c);
   elsif n <= 9 then
      c := 'A';
      dbms_output.put_line('the grade of the student with rno '
                           || rollno
                           || ' is: '
                           || c);
   else
      c := 'A+';
      dbms_output.put_line('the grade of the student with rno '
                           || rollno
                           || ' is: '
                           || c);
   end if;
end;
/
--helper function
create or replace function getgrade (
   srno std.rno%type
) return char as
   c char(2);
   n number(
      4,
      2
   );
begin
   select gpa
     into n
     from std
    where rno = srno;

   if n <= 4 then
      c := 'F';
   elsif n <= 5 then
      c := 'E';
   elsif n <= 6 then
      c := 'D';
   elsif n <= 7 then
      c := 'C';
   elsif n <= 8 then
      c := 'B';
   elsif n <= 9 then
      c := 'A';
   else
      c := 'A+';
   end if;
   return c;
end;
/
--3
declare
   d1   date;
   d2   date;
   fine number(
      7,
      2
   );
   days pls_integer;
begin
   d1 := to_date ( '&enter_the_date_of_issue','DD-MON-YYYY' );
   d2 := to_date ( '&enter_the_return_date','DD-MON-YYYY' );
   days := d2 - d1;
   if days <= 7 then
      fine := 0;
      dbms_output.put_line('the fine is: ' || fine);
   elsif days <= 15 then
      fine := ( days - 7 ) * 1;
      dbms_output.put_line('the fine is: ' || fine);
   elsif days <= 30 then
      fine := ( 15 - 8 ) * 1 + ( days - 16 ) * 2;
      dbms_output.put_line('the fine is: ' || fine);
   else
      fine := ( 15 - 8 ) * 1 + ( 30 - 16 ) * 2 + ( days - 30 ) * 5;
      dbms_output.put_line('the fine is: ' || fine);
   end if;
end;
/
--4
declare
   srno number(
      4,
      2
   );
   c    char(2);
   i    pls_integer := 1;
begin
   loop
      srno := i;
      dbms_output.put_line(getgrade(srno));
      i := i + 1;
      if i = 6 then
         exit;
      end if;
   end loop;
end;
/
select *
  from std;

alter table std add (
   grade char(2)
);
--5
declare
   c char(2);
   i pls_integer := 1;
begin
   while i <= 5 loop
      c := getgrade(i);
      update std
         set
         grade = c
       where rno = i;
      i := i + 1;
   end loop;
end;
/
--6
declare
   n number(
      4,
      2
   );
   m number(
      4,
      2
   ) := -1;
   i pls_integer;
begin
   for i in 1..5 loop
      select gpa
        into n
        from std
       where rno = i;
      if n > m then
         m := n;
      end if;
   end loop;
   dbms_output.put_line('the maximum gpa is: ' || m);
end;
/
--8 wanted me to use some other database i couldnt be bothered so i made my own custom exception
declare
   stupid_nigga exception;
   srno std.rno%type;
   n    number(
      4,
      2
   );
begin
   srno := ( &enter_roll_no );
   select gpa
     into n
     from std
    where rno = srno;
   if n < 5 then
      raise below_avg;
   else
      dbms_output.put_line('good job');
   end if;
exception
   when below_avg then
      dbms_output.put_line('bad job');
   when no_data_found then
      dbms_output.put_line('roll number doesnt exist');
   when others then
      dbms_output.put_line('unexpected error');
end;
/
--rest in anay1440 labs check kro