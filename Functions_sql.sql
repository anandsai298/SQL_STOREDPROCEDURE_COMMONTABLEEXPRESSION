create database Functions;
use Functions;
--create table--
create table Students(
StudentID int Primary Key,
StudentName varchar(50),
StudentAge bigint,
StudentScore decimal(10,2)
);
insert into Students values(1,'Ask',20,100);
insert into Students values(2,'sai',25,90);
insert into Students values(3,'kumar',22,80);
insert into Students values(4,'anand',32,70);
insert into Students values(5,'vijaya',35,60);
Alter table Students Add StudentEmail varchar(20);
Alter table Students Add StudentCity varchar(20);
update  Students set StudentEmail='ask@gmail.com',StudentCity='KKD' where StudentID=1;
update  Students set StudentEmail='sai@gmail.com',StudentCity='RJY' where StudentID=2;
update  Students set StudentEmail='kumar@gmail.com',StudentCity='HYD' where StudentID=3;
update  Students set StudentEmail='anand@gmail.com',StudentCity='YNM' where StudentID=4;
update  Students set StudentEmail='vijaya@gmail.com',StudentCity='PTM' where StudentID=5;

select * from Students;
--userdefined Scalar function 
create function S_F_Students(
@StudentName varchar(50),
@StudentEmail varchar(20),
@StudentCity varchar(20)
)
returns nvarchar(100)
As
BEGIN RETURN (select @StudentName+' '+@StudentEmail+' '+@StudentCity)
END
--output userdefined Scalar function 
select StudentID, dbo.S_F_Students(StudentName,StudentEmail,StudentCity) as detail from Students;
---userdefined tabular valued function
create function T_F_STudents()
returns table as 
return(select * from Students)
---output--
select * from T_F_STudents()

--Inbuilt functions
select GETDATE();
select SQUARE(10);
select SQRT(121);
select Power(5,3);
select APP_NAME();
--count
select COUNT(StudentID) as StudentID from Students;
--sum
select SUM(StudentScore) as StudentScore from Students;
--MAX&MIN
select MAX(StudentAge) as StudentAge from Students;
select MIN(StudentAge) as StudentAge from Students;
--concat
select CONCAT(StudentName,' ',StudentEmail,' ',StudentCity) as Student from Students;
--UPPER&LOWER CASE
select UPPER(StudentName) as StudentName from Students;
select Lower(StudentName) as StudentName from Students;
--substring&Length
select SUBSTRING(StudentEmail,1,4)  as sub from Students;
select LEN(StudentEmail) as lenEmail from Students;


