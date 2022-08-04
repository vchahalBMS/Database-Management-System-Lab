create database varun_supllier;
use varun_supllier;

create table suppliers( sid int primary key, sname varchar(20), address varchar(50));

insert into suppliers values(10001, 'supplier1', 'address1');
insert into suppliers values(10002, 'supplier2', 'address2');
insert into suppliers values(10003, 'supplier3', 'address3');
insert into suppliers values(10004, 'supplier4', 'address4');
insert into suppliers values(10005, 'supplier5', 'address5');
select * from suppliers;

create table parts(pid int primary key, pname varchar(20), color varchar(20));

insert into parts values(20001, 'part1', 'blue');
insert into parts values(20002, 'part2', 'magenta');
insert into parts values(20003, 'part3', 'yellow');
insert into parts values(20004, 'part4', 'green');
insert into parts values(20005, 'part4', 'red');
select * from parts;

create table catalog(sid int, pid int, cost int,
primary key(sid, pid),
foreign key(sid) references suppliers(sid) on delete cascade,
foreign key(pid) references parts(pid) on delete cascade);

insert into catalog values(10001, 20001, 40000);
insert into catalog values(10002, 20002, 9700);
insert into catalog values(10003, 20003, 54777);
insert into catalog values(10004, 20004, 2000);
insert into catalog values(10005, 20005, 67999);
select * from catalog;

/*Q.1 pnames of parts for which there is some supplier.*/
SELECT DISTINCT P.pname
 FROM Parts P, Catalog C
 WHERE P.pid = C.pid;
 
 /*Q.2 snames of suppliers who supply every part.*/
 select S.sname from SUPPLIERS S where not exists (select P.pid from
PARTS P where not exists (select C.sid from CATALOG C where C.sid =
S.sid and C.pid = P.pid));

/*Q3. snames of suppliers who supply every red part.*/
select S.sname from SUPPLIERS S where not exists (select P.pid from
PARTS P where P.color = 'Red' and (not exists (select C.sid from
CATALOG C where C.sid = S.sid and C.pid = P.pid)));

/*Q4. pnames of parts supplied by Acme Widget Suppliers and by no one else.*/
select P.pname from PARTS P, CATALOG C, SUPPLIERS S where P.pid
= C.pid and C.sid = S.sid and S.sname = 'Acme Widget' and not exists
(select * from CATALOG C1, SUPPLIERS S1 where P.pid = C1.pid and
C1.sid = S1.sid and S1.sname <> 'Acme Widget');

/*Q5.sids of suppliers who charge more for some part than the average cost of that part (averaged over
all the suppliers who supply that part).*/
SELECT DISTINCT C.sid FROM Catalog C
WHERE C.cost > ( SELECT AVG (C1.cost)
FROM Catalog C1
WHERE C1.pid = C.pid );

/*Q6. For each part, find the sname of the supplier who charges the most for that part.*/
SELECT P.pid, S.sname
FROM Parts P, Suppliers S, Catalog C
WHERE C.pid = P.pid
AND C.sid = S.sid
AND C.cost = (SELECT MAX(C1.cost)
FROM Catalog C1
WHERE C1.pid = P.pid);

/*Q7. sids of suppliers who supply only red parts.*/
select S.sid from SUPPLIERS S where not exists (select P.pid from
PARTS P where P.color = 'Red' and (not exists (select C.sid from
CATALOG C where C.sid = S.sid and C.pid = P.pid)));
