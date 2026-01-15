create database win_fun 
use win_fun

create table ineuron_students(
student_id int,
student_batch varchar(40),
student_name varchar(40),
student_stream varchar(30),
students_marks int,
student_mail_id varchar(50))

insert into ineuron_students values(101,'fsda','saurabh','CS',80,'saurabh@gmail.com'),
(102,'fsda','raunak','CS',80,'raunak@gmail.com'),
(103,'fsds','rishi','CS',81,'rishi@gmail.com'),
(104,'fsds','vivek','me',84,'vivek@gmail.com'),
(105,'fsda','atishay','CS',40,'atishay@gmail.com'),
(106,'fsds','manoj','me',50,'manoj@gmail.com'),
(107,'fsda','shrey','ee',88,'shrey@gmail.com'),
(108,'fsds','arpit','me',76,'arpit@gmail.com'),
(109,'fsda','shivam','CS',54,'shivam@gmail.com')

select * from ineuron_students

select student_batch, sum(students_marks) from ineuron_students
group by student_batch
select student_batch, min(students_marks) from ineuron_students
group by student_batch
select student_batch, max(students_marks) from ineuron_students
group by student_batch
select student_batch, avg(students_marks) from ineuron_students
group by student_batch
select count(student_batch) from ineuron_students
select count(distinct student_batch) from ineuron_students
select student_batch, count(*) from ineuron_students group by student_batch

select * from ineuron_students

select student_name from ineuron_students where student_batch='fsda' order by students_marks DESC limit 2

select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 1,1;

select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 2,2
select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 2 , 1
select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 3, 1
select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 4 , 1
select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 5 , 1
select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 6 , 1

select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 3, 3

select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 3

select * from ineuron_students where student_batch = 'fsda' order by students_marks desc limit 2, 3

select * from ineuron_students where students_marks=(
select min(students_marks) from 
(select students_marks from ineuron_students
where student_batch = "fsda"
order by students_marks desc
limit 3) as top);

#windowing function 

select * from ineuron_students
select student_id, student_batch, student_stream, students_marks,
 row_number() over (partition by student_batch order by students_marks) as 'row_number' from ineuron_students

select * from (select student_id , student_batch , student_stream,students_marks ,
row_number() over(partition by student_batch order by students_marks desc) as 'row_num' 
from ineuron_students ) as test where row_num = 1

select student_id , student_batch , student_stream,students_marks ,
row_number() over(partition by student_batch order by students_marks desc ) as 'row_num' 
from ineuron_students 

select student_id , student_batch , student_stream,students_marks ,
row_number() over(order by students_marks desc) as 'row_number',
rank() over(order by students_marks desc ) as 'row_rank' 
from ineuron_students 



select * from (select student_id , student_batch , student_stream,students_marks ,
row_number() over(partition by student_batch order by students_marks desc) as 'row_number',
rank() over(partition by student_batch order by students_marks desc ) as 'row_rank',
dense_rank() over( partition by student_batch order by students_marks desc) as 'dense_rank'
from ineuron_students ) as test where `dense_rank` = 3




