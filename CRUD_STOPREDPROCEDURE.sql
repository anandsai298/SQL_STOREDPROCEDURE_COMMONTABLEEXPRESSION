CREATE DATABASE crudSP;
use crudSP;
--CRUD OPERATIONS--
--CREATE TABLE--
CREATE table Products(
ID int primary key,
name varchar(50),
quantity bigint,
price decimal(10,2)
);
ALTER table Products drop column outputMSG ;
select * from Products;
----
CREATE PROCEDURE CProducts(
@ID int,
@name varchar(50),
@quantity bigint,
@price decimal(10,2)
)
AS 
BEGIN
	insert into Products(ID,name,quantity,price) values(@ID,@name,@quantity,@price);
END;
EXECUTE CProducts 1,'LAP',2,99999.99;
EXECUTE CProducts 2,'PHONE',3,60999.99;
EXECUTE CProducts 3,'TV',1,49999.99;
EXECUTE CProducts 4,'Earbuds',1,999.99;

----RETRIEVE DATA
create procedure GetProducts(
@ID int,
@outputMSG nvarchar(50)
)
AS 
BEGIN
	select *from Products
	where @ID=ID;
END;
EXECUTE GetProducts 1;
---IFELSE--
ALTER procedure GetProducts(
@ID int,
@outputMSG nvarchar(50) OUTPUT
)
AS 
BEGIN
	BEGIN TRY
	select *from Products where @ID=ID;
	if @@ROWCOUNT=0
	BEGIN
		SET @outputMSG='Product not found';
	END
	else
	BEGIN 
		SET @outputMSG='Product retrieved';
	END
	END TRY
	BEGIN CATCH
		set @outputMSG='Error:'+ERROR_LINE()+ERROR_MESSAGE();
	END CATCH
	set @outputMSG=@outputMSG;
END;
---update table
create procedure UProducts(
@ID int,
@name varchar(50),
@quantity bigint,
@price decimal(10,2)
)
AS 
BEGIN
	update Products set name=@name,quantity=@quantity,price=@price where ID=@ID;
END;
EXECUTE UProducts 1,'Laptop',1,49999.99;
---trycatch--
Alter procedure UProducts(
@ID int,
@name varchar(50),
@quantity bigint,
@price decimal(10,2),
@outputMSG nvarchar(50) OUTPUT
)
AS 
BEGIN
	begin try
	if exists(select 1 from Products where ID=@ID)
	begin
	update Products set name=@name,quantity=@quantity,price=@price where ID=@ID;
	set @outputMSG='Product updated';
	End
	else
	begin
	set @outputMSG='not found';
	end;
	end try
	begin catch
	set @outputMSG='Error:'+ERROR_MESSAGE();
	end catch
	set @outputMSG=@outputMSG;
END;
---delete --
create procedure DProducts(
@ID int
)
AS 
BEGIN
	delete from Products where ID=@ID;
END; 
EXECUTE DProducts 4;
EXECUTE DProducts 3;EXECUTE DProducts 2;EXECUTE DProducts 1;
----
Alter procedure DProducts(
@ID int,
@outputMSG nvarchar(50) OUTPUT
)
AS 
BEGIN
	begin try
	if EXISTS(select 1 from Products where ID=@ID)
	begin
		delete from Products where ID=@ID;
		set @outputMSG='Product deleted';
	end
	else
	begin
		set @outputMSG='not found';
	end;
	end try
	begin catch
		set @outputMSG='Error:'+ERROR_MESSAGE();
	end catch
	set @outputMSG=@outputMSG;
END; 
