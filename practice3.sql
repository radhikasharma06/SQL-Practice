create database sales
use sales 
CREATE TABLE sales1 (
	order_id VARCHAR(15) NOT NULL, 
	order_date VARCHAR(15) NOT NULL, 
	ship_date VARCHAR(15) NOT NULL, 
	ship_mode VARCHAR(14) NOT NULL, 
	customer_name VARCHAR(22) NOT NULL, 
	segment VARCHAR(11) NOT NULL, 
	state VARCHAR(36) NOT NULL, 
	country VARCHAR(32) NOT NULL, 
	market VARCHAR(6) NOT NULL, 
	region VARCHAR(14) NOT NULL, 
	product_id VARCHAR(16) NOT NULL, 
	category VARCHAR(15) NOT NULL, 
	sub_category VARCHAR(11) NOT NULL, 
	product_name VARCHAR(127) NOT NULL, 
	sales DECIMAL(38, 0) NOT NULL, 
	quantity DECIMAL(38, 0) NOT NULL, 
	discount DECIMAL(38, 3) NOT NULL, 
	profit DECIMAL(38, 8) NOT NULL, 
	shipping_cost DECIMAL(38, 2) NOT NULL, 
	order_priority VARCHAR(8) NOT NULL, 
	`year` DECIMAL(38, 0) NOT NULL
);
SET SESSION sql_mode = ''
load data LOCAL infile  
'/Users/radhikasharma/Developer/sales_data_final.csv'
into table sales1
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows

select * from sales1

select str_to_date(order_date,'%m/%d/%Y') from sales1
alter table sales1
add column order_date_new date after order_date
select* from sales1

update sales1
set order_date_new=str_to_date(order_date,'%m/%d/%Y') 

SET SQL_SAFE_UPDATES = 0;

alter table sales1
add column ship_date_new date after ship_date

update sales1 
set ship_date_new = str_to_date(ship_date, '%m/%d/%Y')

select * from sales1
SET SQL_SAFE_UPDATES = 0;

select * from sales1 where ship_date_new='2011-01-05'
select * from sales1 where ship_date_new>'2011-01-05'
select * from sales1 where ship_date_new<'2011-01-05'
select * from sales1 where shipment_date_new between '2011-01-05' and '2011-08-30'

select now()  #to find current time 
select curtime()
select curdate()

select * from sales1 where ship_date_new<date_sub(now(), interval 1 week)
select date_sub(now(), interval 1 week)
select date_sub(now(), interval 30 day)
select year(now())
select dayname('2022-09-20 21:10:30')

alter table sales1
add column flag date after order_id
select *from sales1

alter table sales1
modify column year datetime 

alter table sales1
modify column year_new int;

alter table sales1
modify column month_new int;

alter table sales1
modify column day_new int;

select * from sales1 limit 4


update sales1 set Month_new= month(order_date_new)
update sales1 set day_new= day(order_date_new);
update sales1 set year_new= year(order_date_new);

select year_new,avg(sales) from sales1 group by year_new

select (sales*discount + shipping_cost) as CTC from sales1
select order_id,discount, if(discount>0, 'no','yes') as discount_flag from sales1 


alter table sales1
modify column discount_flag varchar (20) after discount

select * from sales1

select discount_flag, count(*) from sales1 group by discount_flag

select count(*) from sales1 where discount>0




#class 13
use sales
select*from sales1

DELIMITER $$
create function add_to_col4(a int)
returns INT
DETERMINISTIC
BEGIN
	DECLARE b int;
    set b=a+10;
    return b;
END $$


select*from sales1

select max(sales) from sales1

DELIMITER $$
create function final_profits(profit int, discount int)
returns int 
deterministic
begin
declare final_profit int ;
set final_profit= profit-discount;
return final_profit;
end $$


select profit,discount,final_profits(profit,discount) from sales1;

delimiter $$
create function final_profits_real(profit decimal(20,6), discount decimal(20,6), sales decimal(20,6))
returns int 
deterministic
begin 

declare final_profit int ;
set final_profit=profit-sales*discount; 
return final_profit;
end $$

select profit, discount, sales ,final_profits_real(profit,discount, sales)from sales1;

delimiter $$
create function int_to_str(a int)
returns varchar(30)
deterministic
begin
declare b varchar(30);
set b=a ;
return b ;
end $$

select int_to_str(50)

 select quantity, int_to_str(quantity) from sales1
select max(sales), min(sales) from sales1

DELIMITER $$

CREATE FUNCTION mark_sales(sales INT)
RETURNS VARCHAR(30)
DETERMINISTIC
NO SQL
BEGIN
    DECLARE flag_sales VARCHAR(30);

    IF sales < 100 THEN
        SET flag_sales = 'super affordable product';
    ELSEIF sales >= 100 AND sales < 300 THEN
        SET flag_sales = 'affordable';
    ELSEIF sales >= 300 AND sales < 600 THEN
        SET flag_sales = 'moderate price';
    ELSE
        SET flag_sales = 'expensive';
    END IF;

    RETURN flag_sales;
END $$

DELIMITER ;


SELECT mark_sales(200);

SELECT sales, mark_sales(sales)
FROM sales1;



#creating a procedure with a loop


create table loop_table(val int)

delimiter $$
create procedure insert_data()
begin
set @var=10;
generate_data : loop
insert into loop_table values(@var);
set @var=@var+1;
if @var=100 then 
	leave generate_data;
end if ;
end loop generate_data;
end $$

DROP PROCEDURE IF EXISTS insert_data;
call insert_data()
select * from loop_table


