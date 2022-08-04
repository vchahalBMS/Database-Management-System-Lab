create database varun_airline;
use varun_airline;

create table Flights(
flno int,
source varchar(15),
dest varchar(15),
dist int,
departs time,
arrives time,
price int,
primary key(flno)
);

create table Aircraft(
aid int,
aname varchar(10),
cruisingrange int,
primary key(aid)
);

create table employee(
eid int,
ename varchar(15),
salary int,
primary key(eid)
);

create table Certified(
eid int,
aid int,
foreign key(eid) references employee(eid),
foreign key(aid) references Aircraft(aid)
);


insert into Flights values(01,'Pune','Bangalore',500,10-00-00,13-30-00,5000);
insert into Flights values(02,'Chennai','Bangalore',600,11-15-00,14-30-00,5500);
insert into Flights values(03,'Bangalore','Kolkata',850,17-30-00,20-00-00,12000);
insert into Flights values(04,'Delhi','Chennai',1000,10-00-00,17-30-00,15000);
insert into Flights values(05,'Bangalore','Pune',500,14-00-00,15-30-00,5000);
insert into Flights values(06,'Bangalore','Frankfurt',500,14-00-00,15-30-00,10000);
insert into Flights values(07,'Bangalore','Frankfurt',500,14-00-00,15-30-00,245000);

insert into Aircraft values(001,'Air India',500);
insert into Aircraft values(002,'indigo',800);
insert into Aircraft values(003,'Air India',580); 
insert into Aircraft values(004,'Spice Jet',800);
insert into Aircraft values(005,'Indigo',800);
insert into Aircraft values(006,'Boeing',800);

insert into Employee values (10,'Shraddha',250000);
insert into Employee values (20,'June',250000);
insert into Employee values (30,'Jona',10000);
insert into Employee values (40,'Tejas',30000);
insert into Employee values (50,'Shubhan',250000);
insert into Employee values (60,'Shubham',2500);

insert into Certified values(10,001);
insert into Certified values(20,002);
insert into Certified values(30,003);
insert into Certified values(10,005);
insert into Certified values(40,004);
insert into Certified values(50,005);
insert into Certified values(10,003);
insert into Certified values(10,002);
insert into Certified values(20,006);

/*Q1.Find the names of aircraft such that all pilots certified to operate them have salaries
more than Rs.80,000.*/

select distinct a.aname from aircraft a where a.aid
in ( select c.aid from certified c, employee
e where
c.eid = e.eid and not exists(
select * from employee e1 where e1.eid=e.eid and e1.salary<80000));

/*Q2.For each pilot who is certified for more than three aircrafts, find the eid and the
maximum cruising range of the aircraft for which she or he is certified.*/

select x.eid,x.max_range from
(select c.eid,count(distinct a.aid),max(a.cruisingrange) as max_range
from Certified c join Aircraft a
on c.aid=a.aid
group by c.eid
having count(distinct a.aid)>3 ) x;

/*Q3.Find the names of pilots whose salary is less than the price of the cheapest route
from Bangalore to Frankfurt.*/

select e.ename from Employee e where e.salary < (select min(f.price) from Flights f where f.source='Bangalore' AND f.dest='Frankfurt' );

/*Q4.For all aircraft with cruising range over 1000 Kms, find the name of the aircraft
and the average salary of all pilots certified for this aircraft.*/

select avg(e.salary), c.aid from certified c, employee e where c.aid in(
select aid from aircraft where cruisingrange>1000) and e.eid = c.eid group by c.aid;
/*or*/
select a.aname, avg(e.salary) from Aircraft a,Certified c, Employee e where a.aid=c.aid
AND a.cruisingrange>1000
group by a.aid,a.aname;
/*or*/
SELECT a.aid,a.aname,AVG(e.salary) FROM aircraft a,certified c,employee e WHERE a.aid=c.aid AND c.eid=e.eid AND a.cruisingrange>1000 GROUP BY a.aid,a.aname;


/*Q5.Find the names of pilots certified for some Boeing aircraft.*/

select distinct e.ename from Employee e,Aircraft a, Certified c where e.eid=c.eid
AND c.aid=a.aid
AND a.aname='Boeing';

/*Q6.Find the aids of all aircraft that can be used on routes from Bangalore to
delhi.*/
SELECT a.aid FROM aircraft a WHERE a.cruisingrange> (SELECT MIN(f.dist) FROM flights f WHERE f.source='Bangalore' AND f.dest='Delhi');

/*Q7.A customer wants to travel from Bangalore to Delhi with no more than two
changes of flight. List the choice of departure times from Bangalore if the
customer wants to arrive in Delhi by 6 p.m.*/

SELECT F.flno, F.departs FROM flights F
WHERE F.flno IN 
 ( ( SELECT F0.flno FROM flights F0
WHERE F0.source = 'Bangalore' AND F0.dest =
'Kolkata' AND extract(hour from F0.arrives) < 18 )
UNION
( SELECT F0.flno
FROM flights F0, flights F1
WHERE F0.source = 'Bangalore' AND F0.dest <>
'Kolkata' AND F0.dest = F1.source AND F1.dest
= 'Kolkata' AND F1.departs > F0.arrives
AND extract(hour from F1.arrives) <
18) UNION
( SELECT F0.flno
FROM flights F0, flights F1,
flights F2 WHERE F0.source
= 'Bangalore' AND F0.dest =
F1.source
AND F1.dest =
F2.source AND
F2.dest = 'Kolkata' AND
F0.dest <> 'Kolkata' AND
F1.dest <> 'Kolkata' AND
F1.departs > F0.arrives
AND F2.departs >
F1.arrives
AND extract(hour from F2.arrives) < 18));

/*Q8.Print the name and salary of every non-pilot whose salary is more than the
average salary for pilots.*/

SELECT E.ename, E.salary
FROM Employee E
WHERE E.eid NOT IN ( SELECT DISTINCT C.eid
FROM Certified C )
AND E.salary >( SELECT AVG (E1.salary)
FROM Employee E1
WHERE E1.eid IN
( SELECT DISTINCT C1.eid
FROM Certified C1 ) );
