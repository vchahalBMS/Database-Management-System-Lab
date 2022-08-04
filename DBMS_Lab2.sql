show databases;
create database varun_banking;
use varun_banking;
grant all privileges on*.* to 'varun' with grant option;
show databases;
create table branch(
branch_name varchar(25),
branch_city varchar(25),
assets int(10),
primary key(branch_name));
alter table branch modify assets int;
desc branch;


drop table ;
create table account(
accno int,
branch_name varchar(25),
balance int,
primary key(accno),
foreign key(branch_name) references branch(branch_name)on delete cascade
);

desc account;
create table bank_customer(
customer_name varchar(10),
customer_street varchar(10),
customer_city varchar(10),
primary key(customer_name));
desc bank_customer;

create table loan(
loan_number int,
branch_name varchar(25),
amount int,
primary key(loan_number),
foreign key(branch_name) references branch(branch_name)on delete cascade
);


drop table depositor;

create table depositor(
customer_name varchar(10),
loan_number int,
primary key(customer_name,loan_number),
foreign key(customer_name) references bank_customer(customer_name)on delete cascade,
foreign key(loan_number) references loan(loan_number)on delete cascade
);

insert into branch values('indranagar','bombay',250000);
insert into branch values('SBI_kasturinagar','bangalore',780000);
insert into branch values('SBI_kalsipalya','kolkata',10000000);
insert into branch values('SBI_bensontown','pune',2340000);
insert into branch values('SBI_basavangudi','bangalore',2340000);
update branch set branch_name='SBI_indranagar' where branch_name='indranagar';
select * from branch;

insert into account values(1,'SBI_indranagar',50000);
insert into account values(2,'SBI_kasturinagar',80000);
insert into account values(3,'SBI_kalsipalya',100000);
insert into account values(4,'SBI_bensontown',24000);
insert into account values(5,'SBI_basavangudi',23000);

insert into bank_customer values('varun','indranagar','bombay');
insert into bank_customer values('noel','kasturin','bangalore');
insert into bank_customer values('lohith','kalsipalya','kolkata');
insert into bank_customer values('gigi','bensontown','pune');
insert into bank_customer values('manu','basavangudi','bangalore');

insert into loan values(1,'SBI_indranagar',12000);
insert into loan values(2,'SBI_kasturinagar',24000);
insert into loan values(5,'SBI_kalsipalya',45000);
insert into loan values(7,'SBI_bensontown',12000);
insert into loan values(9,'SBI_basavangudi',3456);

insert into depositor values('varun',1);
insert into depositor values('noel',2);
insert into depositor values('lohith',5);
insert into depositor values('gigi',7);
insert into depositor values('manu',9);

SELECT customer_name FROM depositor d, account a 
where d.loan_number = a.accno AND a.branch_name="SBI_Basvangudi" GROUP BY d.customer_name HAVING COUNT(d.customer_name)>=2;

SELECT d.customer_name FROM account a,branch b,depositor d 
WHERE b.branch_name=a.branch_name AND  a.accno=d.loan_number AND b.branch_city='Bangalore' 
GROUP BY d.customer_name HAVING COUNT(distinct b.branch_name)=(SELECT COUNT(branch_name) FROM branch WHERE branch_city='Bangalore');

delete from account 
where branch_name 
IN (select branch_name from branch where branch_city='bangalore');
