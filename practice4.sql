create database key_prim
use key_prim 
create table ineuron(
course_id int NOT NULL,
course_name varchar(60),
course_status varchar(40),
number_of_enro int ,
primary key(course_id));

insert into ineuron values(01, 'FSDA','active',100)
insert into ineuron values(02, 'FSDA','not-active',100) #error because primary key cannot be repeated

 create table students_ineuron(
 student_id int,
 course_name varchar(60),
 student_mail varchar(60),
 student_status varchar(40),
 course_id1 int,
 foreign key (course_id1)references ineuron(course_id)
 )
 
 insert into students_ineuron values (101, 'FSDA', 'test2gmail.com','active',05)
  insert into students_ineuron values (101, 'FSDA', 'test2gmail.com','active',01)
    insert into students_ineuron values (101, 'FSDA', 'test2gmail.com','active',01)
    
  create table payment (
  course_name varchar(50),
  course_id int,
  course_live_status varchar(50),
  course_launch_date varchar (50),
  foreign key (course_id) references ineuron(course_id))           #ineuron becomes the parent table here and payment is the child table 
  
 insert into payment values('FSDA',06,'NOT ACTIVE','7TH AUG')  #throw error
insert into payment values ('FSDA',01,'NOT ACTIVE','7TH AUG')
insert into payment values ('FSDA',01,'NOT ACTIVE','7TH AUG')


create table class (
course_id int,
class_name varchar(60),
class_topic varchar(60),
class_duration int,
primary key (course_id),
foreign key(course_id) references ineuron(course_id)      #course_id is behaving like a primary key as well as a foreign key
)
alter table ineuron drop primary key 
alter table class drop primary key
alter table ineuron add constraint  test_prim primary key(course_id,course_name)     #wont work because their can be only 1 primary key in one table

 
drop table ineuron 
drop table class    #we can drop a child table but not a parent table

create table test(
id int not null,
name varchar(60),
email_id varchar(60),
mobile_no varchar (9),
address varchar(50))


alter table test add primary key(id)

alter table test drop primary key

alter table test add constraint test_prim primary key(id,email_id)

create table parent(
id int not null,
primary key(id))

create table child (
id int ,
parent_id int,
foreign key (parent_id) references parent(id))

insert into parent values (1)
select * from parent 
insert into child values(1,1)
select * from child 
insert into child values(2,2)
delete from parent where id=1
delete from child where id=1


drop table child 
create table child (
id int ,
parent_id int,
foreign key (parent_id) references parent(id) on delete cascade)

f  
  