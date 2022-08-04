show databases;
create database VARUN_insurance;
use VARUN_insurance;
grant all privileges on*.* to 'varun' with grant option;
show databases;
create table PERSON(
driver_id varchar(10),
name varchar(50),
address varchar(50),
primary key(driver_id)
);
desc PERSON;

create table CAR(
Regno varchar(15),
Model varchar(15),
year int,
primary key(regno)
);

create table ACCIDENT(
report_no int,
Date_of_acident date,
location varchar(50),
primary key(report_no));

create table OWNS(
driver_id varchar(10),
Regno varchar(15),
primary key(driver_id,regno),
foreign key(driver_id) references person(driver_id),
foreign key(regno) references car(regno));

create table PARTICIPATED(
driver_id varchar(15),
Regno varchar(15),
report_no int,
damage_amt int,
primary key(driver_id,regno,report_no),
foreign key(driver_id) references person(driver_id),
foreign key(regno) references car(regno),
foreign key(report_no) references accident(report_no));

insert into PERSON values('A01','Selva','Cubbon Road');
insert into PERSON values('B03','Manju','Rajbhavan Road');
insert into PERSON values('C69','Lohith','Kolar');
insert into PERSON values('D12','Naveen','Koramangala');
insert into PERSON values('E101','Raman','CV Raman Nagar');

insert into CAR values('MU6400','Alto',2012);
insert into CAR values('MA6996','Civic',2008);
insert into CAR values('CA7893','Corolla',2004);
insert into CAR values('XZ6163','Innova',2009);
insert into CAR values('AS8008','Ambassador',1995);

insert into ACCIDENT values(10,'2012-08-02','Whitefield');
insert into ACCIDENT values(12,'2011-07-27','Shivaji Nagar');
insert into ACCIDENT values(17,'2008-11-14','Sadashiv Nagar');
insert into ACCIDENT values(69,'2010-01-06','Sadashiv Nagar');
insert into ACCIDENT values(53,'2009-10-26','Madiwala');

insert into OWNS values('A01','MU6400');
insert into OWNS values('C69','AS8008');
insert into OWNS values('B03','CA7893');
insert into OWNS values('D12','XZ6163');
insert into OWNS values('E101','MA6996');

insert into PARTICIPATED values ('C69','AS8008',10,20000);
insert into PARTICIPATED values ('C69','AS8008',69,75000);
insert into PARTICIPATED values ('B03','CA7893',12,40000);
insert into PARTICIPATED values ('D12','XZ6163',17,50000);
insert into PARTICIPATED values ('E101','MA6996',53,10000);

update PARTICIPATED set damage_amt=25000 where report_no=12;
 select * from PARTICIPATED;
 insert into PARTICIPATED values('E107','AS8568',22,78);
select * from ACCIDENT where Date_of_acident LIKE '2012%';
 select * from CAR where Model = 'Civic';
