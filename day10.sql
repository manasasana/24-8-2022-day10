use demo;
go

select * from EmpSalary;

create or alter function tempfunction(@id int) 
returns varchar(10) as 
begin
declare @salslab varchar(10)
declare @salary float
select @salary=Salary from EmpSalary where EmpId=@id;
if(@salary>=60000) set @salslab='high';
if(@salary<60000) set @salslab='low';
return @salslab;
end;

select dbo.tempfunction(4) as salslab

create or alter function fn(@dt date, @dt1 date,@check float) 
returns varchar(30) as
begin
declare @orderslab varchar(30)
declare @total float
select @total=sum(purch_amt) from orders  where ord_date between @dt and @dt1;
if(@total>=@check) set @orderslab='highest';
if(@total<@check) set @orderslab='lowest';
return @orderslab;
end;

select demo.dbo.fn('2012-06-01','2012-10-31',20000)

create or alter function fn1(@id int,@dt date, @dt1 date) 
returns varchar(30) as
begin
declare @custslab varchar(30)
declare @count int
select @count=count(ord_no) from orders  where @id=customer_id and ord_date between @dt and @dt1 group by customer_id;
if(@count>=3) set @custslab='regular customer';
if(@count<3) set @custslab='new customer';
return @custslab;
end;

drop function fn1
select demo.dbo.fn1(3002,'2012-10-01','2012-10-31')
select * from orders;

create or alter function resultinfo(@id int) 
returns varchar(10) as
begin
declare @res varchar(30)
declare @maxmark int
select @maxmark=sum(Maths+Economics+Commerce+English+ComputerScience) from results where id=@id group by id;
if(@maxmark>=400) set @res='A+';
if(@maxmark<400 and @maxmark>=300) set @res='A';
if(@maxmark<300) set @res='B';
return @res;
end;

select student.dbo.resultinfo(5) as grade

select  sum(Maths+Economics+Commerce+English+ComputerScience)from results group by id;

create or alter function resultdetails(@id int)  
returns @results table  
(id int, Name varchar(50)) as 
begin  
    insert into @results  
	select r.id,r.name from results r where r.id>@id;
    return  
end; 

select * from resultdetails(4)
