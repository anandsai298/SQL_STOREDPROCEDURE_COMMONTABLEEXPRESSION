create database SP;
use SP;
--customertable
create table Customers(
ID int primary key,
Name varchar(50),
Address varchar(50),
Phone bigint,
);
select * from Customers;

--order table
create table Orders(
OrderID int  primary key,
OrderDate date,
ID int foreign key (ID) REFERENCES Customers(ID),
);
select * from Orders;
--storedprocedure to insert customers into customers table
--CREATED TABLE
CREATE PROCEDURE SP_Customers(
@ID int,
@Name varchar(50),
@Address varchar(50),
@Phone bigint 
)
AS
BEGIN
	insert into Customers(ID,Name,Address,Phone)values(@ID,@Name,@Address,@Phone);
END;
----
EXEC SP_Customers 1,'Ask','Hyd',7412589635;
EXEC SP_Customers 2,'sai','kkd',7412588635;
EXEC SP_Customers 3,'kumar','rjy',7412587635;
EXEC SP_Customers 4,'anand','Hyd',7412584635;

--insert order with respective of customertable
CREATE PROCEDURE SP_Orders(
@ID int,
@Name varchar(50),
@Address varchar(50),
@Phone bigint,
@OrderID int,
@OrderDate date
)
AS 
BEGIN 
	if not Exists(select 1 from Customers where ID=@ID)
	BEGIN
		EXEC SP_Customers @ID,@Name,@Address,@Phone;
	END;
	insert into Orders(ID,OrderID,OrderDate) values(@ID,@OrderID,@OrderDate);
END;
-----
EXEC SP_Orders 1,'Ask','Hyd',7412589635,101,'2023-05-10';
EXEC SP_Orders 2,'sai','kkd',7412588635,102,'2023-05-15';
EXEC SP_Orders 3,'kumar','rjy',7412587635,103,'2023-05-25';
EXEC SP_Orders 4,'anand','Hyd',7412584635,104,'2023-05-20';
----
EXEC SP_Orders 5,'naidu','Hyd',7412789635,105,'2023-05-11';
EXEC SP_Orders 5,'raju','kkd',7410789635,106,'2023-05-21';
EXEC SP_Orders 5,'balu','ejy',7412780635,107,'2023-05-26';
---
select Customers.ID,Customers.Name,Customers.Address,Customers.Phone,Orders.OrderDate from Customers
full join Orders on Customers.ID =Orders.OrderID;
---using try catch block--
Alter PROCEDURE SP_Orders(
@ID int,
@Name varchar(50),
@Address varchar(50),
@Phone bigint,
@OrderID int,
@OrderDate date,
@Result varchar(50)
)
AS 
BEGIN 
	--trycatch block
	BEGIN TRY
	if not Exists(select 1 from Customers where ID=@ID)
	BEGIN
		EXEC SP_Customers @ID,@Name,@Address,@Phone;
	END;
	insert into Orders(ID,OrderID,OrderDate,Result) values(@ID,@OrderID,@OrderDate,@Result);
	select 'SUCCESS' AS Result;
	END TRY
	BEGIN CATCH
		select 'Error' + ERROR_MESSAGE() AS Result;
	END CATCH
END;
----

EXEC SP_Orders 1,'Ask','Hyd',7412589635,101,'2023-05-10';
--ifelse--
Alter PROCEDURE SP_Customers(
@ID int,
@Name varchar(50)
)
AS
BEGIN
	if exists(select 1 from Customers where ID=@ID)
	begin
		update Customers set Name=@Name where ID=@ID
		select 'Customer updated' AS Result;
		select * from Customers where ID=@ID;
	End
	else
	begin
		insert into Customers(ID,Name) values(@ID,@Name)
		select 'Customer Inserted' AS Result;
		select * from Customers where ID=@ID;
	end
END;
--
EXECUTE SP_Customers @ID=1,@Name='ask';
EXECUTE SP_Customers @ID=7,@Name='aka';
EXECUTE SP_Customers @ID=8,@Name='pk';
EXECUTE SP_Customers @ID=9,@Name='kn';









