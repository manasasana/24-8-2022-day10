create or alter  function Employeesalaryincrement(@des varchar(50))
returns @EmpSalary table  
(EmpId int,Salary float) as
begin  
    insert into @EmpSalary
	select e.EmpId,s.Salary from EmpInfo e inner join EmpSalary s
	on s.EmpId=e.EmpId where e.Designation=@des;

if(@des='Manager')
begin
update @EmpSalary set Salary=Salary+((Salary*10)/100)
end
if(@des='Backend Developer')
begin
update @EmpSalary set Salary=Salary+((Salary*5)/100)
end
	return;
	end;


select * from Employeesalaryincrement('Backend Developer')

select * from EmpSalary



create or alter function bankinterest(@n int,@at varchar(29))
returns @AccInfo table 
(Cid int,Amt float) as
begin
	insert into @AccInfo
	select Cid, Amt from AccInfo where AccType=@at;

if(@at='savings')
begin
update @AccInfo set Amt=Amt+((Amt*@n*(5/100))/100)
end
return;
end;



select  bankinterest(4,'savings',1)

select * from AccInfo




