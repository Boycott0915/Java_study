#1、查找部门30中员工的详细信息。
select * from emp where deptno = 30;

#2、找出从事clerk工作的员工的编号、姓名、部门号。
select empno,ename,deptno from emp where job = 'clerk';

#3、检索出奖金多于基本工资的员工信息。
select * from emp where comm > sal;


#4、检索出奖金多于基本工资60%的员工信息。
select * from emp where comm > sal * 0.6;


#5、找出10部门的经理、20部门的职员 的员工信息。
select * from emp where deptno = 10 and job='MANAGER' or deptno = 20 and job = 'CLERK';


#6、找出10部门的经理、20部门的职员 或者既不是经理也不是职员但是工资高于2000元的员工信息。
select * from emp 
  where deptno = 10 and job='MANAGER' 
     or deptno = 20 and job = 'CLERK'
     or job!='MANAGER' and job != 'CLERK' and sal > 2000 ;



#7、找出获得奖金的员工的工作。
select * from emp where comm > 0;

#8、找出奖金少于100或者没有获得奖金的员工的信息。
select * from emp where comm < 100 or comm is null;


#9、找出姓名以A、B、S开始的员工信息。
select * from emp where ename like 'A%' or ename like 'B%' or ename like 'S%';


#10、找到名字长度为6个字符的员工信息。
#select * from emp where ename like '______';

#11、名字中不包含R字符的员工信息。
select * from emp where ename not like '%R%';


#12、返回员工的详细信息并按姓名排序。
select * from emp order by ename asc;


#13、返回员工的信息并按工作降序工资升序排列。
select * from emp order by job desc , sal asc;


#14、计算员工的日薪(按30天)。
select ename,sal/30 as '日薪' from emp;


#15、找出姓名中包含A的员工信息。
select * from emp where ename like '%A%';
