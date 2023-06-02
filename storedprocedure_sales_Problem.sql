create database SP_Sales;
use SP_Sales;
----
create table Sales(
ID int primary key,
Name varchar(50),
SaleDate Date,
Quantity int,
Amount decimal(10,2)
);
insert into Sales values(1,'lap','2023-05-29',1,49999.99);
insert into Sales values(2,'Mobile','2023-05-30',2,35999.99);
insert into Sales values(3,'AC','2023-05-20',1,45999.99);
insert into Sales values(4,'TV','2023-05-25',1,60999.99);
select * from Sales;
--stored procedure
create procedure UpdateSales
@ID int,@Amount decimal(10,2)
as 
begin
	update Sales set Amount=@Amount where ID=@ID;
end
--
EXEC UpdateSales @ID=2,@Amount=40999.99;
---retrive b/w dates
Alter procedure RetreiveSales
@StartDate Date,@EndDate Date
as
begin
declare @MSG nvarchar(100);
	select * from Sales where SaleDate>=@StartDate and SaleDate<=@EndDate;
	if exists(select * from Sales)
	begin
		select * from Sales;
	end
	else
	begin
		set @MSG='No records are found in b/w dates';
		select @MSG as Message;
	end
end 
---
EXEC RetreiveSales @StartDate='2023-05-15',@Enddate='2023-05-25';
