create database TestEmployeeDB

go

use TestEmployeeDB

go

create table StateMaster
(
StateId int primary key identity,
StateName varchar(100)
)

go

insert into StateMaster values ('Maharashtra'), ('Gujrat')

go

create table DistrictMaster
(
DistrictId int primary key identity,
DistrictName varchar(100),
StateId int foreign key references StateMaster(StateId)
)

go

insert into DistrictMaster values ('Pune', 1), ('Thane', 1), ('Sangali', 1), ('Ahmedabad', 2), ('Surat', 2)

go

create table Employee
(
EmployeeId int primary key identity,
Name varchar(200) not null,
DateOfBirth date not null,
Address varchar(500) not null,
DistrictId int not null foreign key references DistrictMaster(DistrictId),
Salary numeric check (Salary > 0) not null
)

go

create proc usp_Employees
as
begin
	begin try
		select e.EmployeeId, e.Name, e.DateOfBirth, e.Address, e.Salary, 
		isnull(dm.DistrictName, 'NA') as DistrictName, 
		isnull(sm.StateName, 'NA') as StateName
		from employee e left join DistrictMaster dm on e.DistrictId = dm.DistrictId
		left join StateMaster sm on dm.StateId = sm.StateId
	end try
	begin catch
		print error_message()
	end catch
end

go

select * from StateMaster
select * from DistrictMaster
select * from Employee