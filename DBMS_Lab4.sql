create database varun_student_faculty;
use varun_student_faculty;
create table student(snum int primary key, sname varchar(30), major varchar(10), stlevel varchar(2), age int);

create table faculty(fid int primary key,fname varchar(30), dept_id int);

create table class(cname varchar(10) primary key, meets_at timestamp, room varchar(4), fid int, 
foreign key (fid) references faculty(fid)on delete cascade);

create table enrolled(snum int,cname varchar(10),foreign key (snum) references student(snum)on delete cascade,
 foreign key (cname) references class(cname));  

insert into student values(1,'Rajesh','CS','JR',22);
insert into student values(2,'Prashant','CS','SR',25);
insert into student values(3,'Gagan','CS','SS',26);
insert into student values(4,'Pratham','CS','BG',19);
insert into student values(5,'Adithya','CS','JR',21);
insert into student values(6,'Rajesh','CV','JR',22);
insert into student values(7,'Rajesh','IS','JR',22);
insert into student values(9,'Gagan','CS','SS',22);
select * from student;
insert into faculty values(14,'Vikranth',1);
insert into faculty values(15,'Manjunath',1);
insert into faculty values(16,'Dheeraj',2);
insert into faculty values(17,'Shashidhar',2);
insert into faculty values(18,'Soumya',1);
select * from faculty;

insert into class values('Class1','2018-06-04 08:30:00','R125',14);
insert into class values('Class2','2018-06-04 08:30:00','R126',15);
insert into class values('Class3','2018-06-04 08:30:00','R127',16);
insert into class values('Class4','2018-06-04 08:30:00','R128',17);
insert into class values('Class5','2018-06-04 08:30:00','R129',18); 
select * from class;

insert into enrolled values(1,'Class1');
insert into enrolled values(2,'Class2');
insert into enrolled values(3,'Class3');
insert into enrolled values(4,'Class4');
insert into enrolled values(5,'Class5');
select * from enrolled;


/*Q1. */
select distinct s.snum,s.sname from student s,class c,enrolled e,faculty f where 
s.snum=e.snum and e.cname=c.cname and c.fid=f.fid and f.fname='Soumya' and s.stlevel='JR'; /*1st query*/

/*Q2. */
select c.cname from class c where c.room='R128'or c.cname in (select e.cname from enrolled e group by e.cname having count(*)>=5 );/*2nd query*/

/*Q3. */
select distinct s.sname from student s
where s.snum in(select e1.snum from 
  enrolled e1,enrolled e2,class c1,class c2 where e1.snum=e2.snum 
  and e1.cname<>e2.snum
  and e1.cname=c1.cname
  and e2.cname=c2.cname
  and c1.meets_at=c2.meets_at);
  
 /*Q4. */  
select s.sname from student s where snum in(select e.snum from enrolled e, enrolled n, class c1,class c2
 where e.snum=n.snum and e.cname=c1.cname and n.cname=c2.cname and e.cname!=n.cname and c1.meets_at=c2.meets_at);

/*Q5. */
select f.fname,f.fid
from faculty f
where f.fid in(select fid from class
group by fid
having count(*)=(select count(distinct room) from class));

/*Q6. */
select distinct f.fname from faculty f
where f.fid in(select c.fid
from class c, enrolled e 
where 
c.cname=e.cname group by c.cname
having count(c.cname)<5);

/*Or*/

/*
-- Query 1
SELECT DISTINCT S.Sname
FROM Student S, Class C, Enrolled E, Faculty F
WHERE S.snum = E.snum AND E.cname = C.cname AND C.fid = F.fid AND
F.fname = 'Harish' AND S.lvl = 'Jr';
-- Query 2
SELECT DISTINCT cname
FROM class
WHERE room='room128'
OR
cname IN (SELECT e.cname FROM enrolled e GROUP BY e.cname HAVING COUNT(*)>=5);
-- Query 3
SELECT DISTINCT S.sname
FROM Student S
WHERE S.snum IN (SELECT E1.snum
FROM Enrolled E1, Enrolled E2, Class C1, Class C2
WHERE E1.snum = E2.snum AND E1.cname <> E2.cname
AND E1.cname = C1.cname
AND E2.cname = C2.cname AND C1.metts_at = C2.metts_at);
-- Query 4
SELECT f.fname,f.fid
FROM faculty f
WHERE f.fid in ( SELECT fid FROM class
GROUP BY fid HAVING COUNT(*)=(SELECT COUNT(DISTINCT room) FROM class) );
-- Query 5
SELECT DISTINCT F.fname
FROM Faculty F
WHERE 5 > (SELECT COUNT(E.snum)
FROM Class C, Enrolled E
WHERE C.cname = E.cname
AND C.fid = F.fid);
-- Query 6
SELECT DISTINCT S.sname
FROM Student S
WHERE S.snum NOT IN (SELECT E.snum
FROM Enrolled E );
-- Query 7
SELECT S.age, S.lvl
FROM STUDENT S
GROUP BY S.age, S.lvl
HAVING S.lvl IN (SELECT S1.lvl
FROM STUDENT S1
WHERE S1.age=S.age
GROUP BY S1.age, S1.lvl
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
FROM STUDENT S2
WHERE S1.age=S2.age
GROUP BY S2.lvl, S2.age))
ORDER BY S.age;
*/
