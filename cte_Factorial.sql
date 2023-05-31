create database CteFactorial;
use CteFactorial;

--cte factorial
with Fcatorial as(
	select 1 as Num,1 as Factorial
	union all

	select Num+1,(Num+1) * Factorial from Fcatorial where Num+1 <=6
)
select Factorial from Fcatorial where Num=6;
