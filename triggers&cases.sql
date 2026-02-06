## TRIGGERS AND CASES

create database ineuron
use ineuron 

create table course2(
course_id int ,
course_desc varchar(50),
course_mentor varchar(50),
course_price int,
course_discount int ,
create_date date ,
user_info varchar(50))

create table course_update(
course_mentor_update varchar(50),
course_price_update int,
course_discount_update int )

delimiter //
create trigger course_before_insert121
before insert 
on course2 for each row
begin
	declare user_val varchar(50);
	set new.create_date=sysdate();
    select user() into user_val;
	set new.user_info=user_val;
    insert into ref_course values(sysdate(),user_val);
end ; //


create table ref_course(
record_insert_date date,
record_insert_user varchar (50)
)

insert into course2 (course_id,course_desc,course_mentor,course_price,course_discount)  values(101,'Fsda','sudhanshu',4000,10)

select * from course1 #date was automaticallly inserted . This is how triggers work.
select * from ref_course

select user()

select * from course2
select sysdate()

#if i insert something or update in test1 then it should do somthing in test2 and test3 as well. (using before insert)
create table test1(
c1 varchar(50),
c2 date,
c3 int )

create table test2(
c1 varchar(50),
c2 date,
c3 int )

create table test3(
c1 varchar(50),
c2 date,
c3 int )

#so we create a trigger 

delimiter //
create trigger to_update_others
before insert on test1 for each row
begin 
insert into test2 values("xyz", sysdate(),234);
insert into test3 values("xyz", sysdate(),234);
end ;//

insert into test1 values ("radhika",sysdate(),54)
select * from test1;
select * from test2;
select * from test3;   #the trigger automatically puts values in test2 and test3 ie ("xyz", sysdate(),2340)

#now lets see how after insert works.


delimiter //
create trigger to_update_others_table
after insert on test1 for each row
begin 
update test2 set c1= 'abc' where c1='xyz';
delete from test3 where c1='xyz';
end ;//

insert into test1 values ("prakrati",sysdate(),54)

SET SQL_SAFE_UPDATES = 0; #to turn off safe mode

select * from test1;
select * from test2;
select * from test3;

##types of triggers
#there are 6 kinds of triggers
#after-before insert, after-before update, after-before delete


delimiter //
create trigger to_delete_others_table
after delete on test1 for each row
begin 
insert into test3 values("after delete", sysdate(),546437);
end ;//

select * from test1

delete from test1 where c1='prakrati'

select * from test3


delimiter //
create trigger to_delete_others_before
before delete on test1 for each row
begin 
insert into test3 values("after delete", sysdate(),546437);
end ;//

delete from test1 where c1='radhika'
select * from test3


#how to know what tasks triggers are performing, now we observe 

delimiter //
create trigger to_delete_others_observation2
before delete on test1 for each row
begin 
insert into test2(c1,c2,c3) values(old.c1, old.c2,old.c3);
end ;//

insert into test11 values("shrey", sysdate(),546437);
select * from test11
delete from test11 where c1='prakku'

create table test11(
c1 varchar(50),
c2 date,
c3 int )

create table test12(
c1 varchar(50),
c2 date,
c3 int )

create table test13(
c1 varchar(50),
c2 date,
c3 int )


delimiter //
create trigger to_delete_others_observation5
after delete on test11 for each row
begin 
insert into test12(c1,c2,c3) values(old.c1, old.c2,old.c3);
end ;//

delete from test11 where c1='prakku'
select * from test12

delimiter //
create trigger to_update_others_observation5
before update on test11 for each row
begin 
insert into test12(c1,c2,c3) values(old.c1, old.c2,old.c3);
end ;//


delimiter //
create trigger to_update_others_observation5
after update on test11 for each row
begin 
insert into test12(c1,c2,c3) values(old.c1, old.c2,old.c3);
end ;//
select * from test11

insert into test11 values("rishi", sysdate(),546437);


##CASES

use ineuron_partition;

SELECT * FROM ineuron_partition.ineuron_course;

select * , 
case 
when course_name='fsda' then "this is my batch"
when course_name='fsds' then "this is my batch"
else "this is not my batch"
end as statement
from ineuron_course

#to know the length of course_name

select * , 
case 
when length(course_name)=4 then "len 4"
when length(course_name)=2 then "len 2"
else "other length"
end as statement
from ineuron_course

select * ,
case 
	when course_name = 'fsda' then sysdate()
    when course_name = 'fsds' then system_user()
    else "this is not your batch"
end as statement 
from ineuron_course

