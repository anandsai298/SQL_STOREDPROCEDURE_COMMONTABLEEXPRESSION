create database FunctionProb;
use FunctionProb;
create table Products(
ProductID int primary key,
ProductName varchar(50),
);
insert into Products values(1,'Laptop');
insert into Products values(2,'TV');
insert into Products values(3,'Mobile');
insert into Products values(4,'EarBuds');
insert into Products values(5,null);

select * from Products;
--function creation
Alter function F_Products(
@ProductID int
)
returns varchar(100)
as begin
declare @ProductName varchar(50)
select @ProductName=ProductName from Products where ProductID=@ProductID
if @ProductName is null
set @ProductName='Products does not exits'
return @ProductName
END
--
declare @ProductID int=5;

select dbo.F_Products(@ProductID) as ProductName ;

