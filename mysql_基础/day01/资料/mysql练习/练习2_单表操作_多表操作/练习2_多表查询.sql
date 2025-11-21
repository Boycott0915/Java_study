#1、返回拥有员工的部门名、部门号。
select distinct d.dname, d.deptno from dept d,emp e where d.deptno = e.deptno;

#2、工资水平多于smith的员工信息。
select *from emp where sal > (select sal from emp where ename = 'smith');
	
#3、返回员工和所属经理的姓名。
select e.ename,m.ename from emp e
  left outer join emp m on e.mgr = m.empno;
select e.ename ,(select m.ename from emp m where m.empno  = e.mgr) ename from emp e;

select e.ename , m.ename from emp e , emp m where e.mgr = m.empno;
	 
#4、返回雇员的雇佣日期早于其经理雇佣日期的员工及其经理姓名。
select e.ename,m.ename from emp e
inner join emp m on e.mgr = m.empno
where e.hiredate < m.hiredate;

select e.ename,m.ename from emp e,emp m
where e.mgr=m.empno
and e.hiredate < m.hiredate;

#5、返回员工姓名及其所在的部门名称。
select e.ename,d.dname from emp e , dept d where e.deptno = d.deptno;

#6、返回从事clerk工作的员工姓名和所在部门名称。
select e.ename,d.dname 
from emp e , dept d 
where e.deptno = d.deptno and e.job = 'CLERK';

#7、返回部门号及其本部门的最低工资。
select deptno ,min(sal) sal
from emp 
group by deptno

#8、返回销售部(sales)所有员工的姓名。
select e.ename from emp e,dept d
where e.deptno = d.deptno and d.dname = 'sales';

select ename from emp where deptno=(select deptno from dept where dname='sales');

#9、返回工资水平多于平均工资的员工。
select * from emp e
where e.sal > (select avg(sal) from emp);


#10、返回与SCOTT从事相同工作的员工。
select * from emp
where job = (select job from emp where ename = 'scott');

select e1.* from emp e1 , (select empno,job from emp where ename = 'scott') e2
where e1.job = e2.job and e1.empno != e2.empno;


#11、返回与30部门员工工资水平相同的员工姓名与工资。
select ename,sal from emp
where sal in (select sal from emp where deptno = 30);

#12、返回工资高于30部门所有员工工资水平的员工信息。
select * from emp
where sal > all(select sal from emp where deptno = 30);

select * from emp
where sal > (select max(sal) from emp where deptno = 30);

#13、返回部门号、部门名、部门所在位置及其每个部门的员工总数。	
select dept.deptno,dept.dname,dept.loc,count(emp.deptno) number from dept,emp
where dept.deptno = emp.deptno
group by emp.deptno;

#14、返回员工的姓名、所在部门名及其工资。
select ename,dname,sal from emp ,dept
where emp.deptno = dept.deptno;

#15、返回员工的详细信息。(包括部门名)
select e.* , d.dname from emp e, dept d
where e.deptno = d.deptno;

#16、返回员工工作及其从事此工作的最低工资。
select job , min(sal) sal from emp
group by job 


#17、返回不同部门经理的最低工资。???
select min(sal) from emp
where job = 'MANAGER';

select deptno,ename,job,min(sal) from  emp
where job='manager'	
group by deptno;
	

#18、计算出员工的年薪，并且以年薪排序。
select ename, sal * 12 as ySalary from emp order by ySalary;


#19、返回工资处于第四级别的员工的姓名。
select ename,sal from emp e  ,salgrade s
where e.sal >= s.losal and e.sal <= s.hisal
   and s.grade = 4;

select emp.ename,emp.sal from 
  emp ,(select losal,hisal from salgrade where grade=4) g
  where	emp.sal between g.losal and g.hisal;

#20、返回工资为二等级的职员名字、部门所在地、和二等级的最低工资和最高工资
select ename ,dname ,sal ,losal,hisal from emp,dept,salgrade
where emp.deptno = dept.deptno and grade = 2
    and sal >= losal and sal < hisal;
	

#21、返回工资为二等级的职员名字、部门所在地、二等级员工工资的最低工资和最高工资

select min(t.sal) '最低工资' ,max(t.sal) '最高工资' from (
select ename ,dname ,sal from emp,dept,salgrade
where emp.deptno = dept.deptno and grade = 2
   and sal >= losal and sal < hisal
) t;

#22.工资等级多于smith的员工信息。
select grade from salgrade s ,emp e
where s.losal < e.sal and s.hisal > e.sal and e.ename = 'smith';

select e.* from emp e, salgrade s 
where s.hisal < e.sal and s.grade = 1;

select e.* from emp e, salgrade s 
where s.hisal < e.sal and s.grade = (select grade from salgrade s ,emp e
where s.losal < e.sal and s.hisal > e.sal and e.ename = 'smith');

