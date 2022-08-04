CREATE DATABASE varun_book_dealer;
use varun_book_dealer;
CREATE TABLE author1 (
      author1_id INT,
      author1_name VARCHAR(20),
      author1_city VARCHAR(20),
      author1_country VARCHAR(20),
      PRIMARY KEY(author1_id));
CREATE TABLE publisher1 (
      publisher1_id INT,
      publisher1_name VARCHAR(20),
      publisher1_city VARCHAR(20),
      publisher1_country VARCHAR(20),
      PRIMARY KEY(publisher1_id));
CREATE TABLE category1 (
      category_id INT,
      description VARCHAR(30),
      PRIMARY KEY(category_id) );
CREATE TABLE catalogue1(
      book_id INT,
      book_title VARCHAR(30),
      author1_id INT,
      publisher1_id INT,
      category_id INT,
      year INT,
      price INT,
      PRIMARY KEY(book_id),
      FOREIGN KEY(author1_id) REFERENCES author1(author1_id),
      FOREIGN KEY(publisher1_id) REFERENCES publisher1(publisher1_id),
      FOREIGN KEY(category_id) REFERENCES category1(category_id) );
 CREATE TABLE orderdetails1(
      order_id INT,
      book_id INT,
      quantity INT,
      PRIMARY KEY(order_id),
      FOREIGN KEY(book_id) REFERENCES catalogue1(book_id));
 INSERT INTO author1 (author1_id,author1_name,author1_city,author1_country) VALUES
          (1001,'JK Rowling','London','England'),
          (1002,'Chetan Bhagat','Mumbai','India'),
          (1003,'John McCarthy','Chicago','USA'),
          (1004,'Dan Brown','California','USA') ;
INSERT INTO publisher1 (publisher1_id,publisher1_name,publisher1_city,publisher1_country) VALUES
          (2001,'Bloomsbury','London','England'),
          (2002,'Scholastic','Washington','USA'),
          (2003,'Pearson','London','England'),
          (2004,'Rupa','Delhi','India') ;
INSERT INTO category1 (category_id,description) VALUES
          (3001,'Fiction'),
          (3002,'Non-Fiction'),
          (3003,'thriller'),
          (3004,'action'),
          (3005,'fiction') ;
INSERT INTO catalogue1 VALUES 
          (4001,'HP and Goblet Of Fire',1001,2001,3001,2002,600),
          (4002,'HP and Order Of Phoenix',1001,2002,3001,2005,650),
          (4003,'Two States',1002,2004,3001,2009,65),
          (4004,'3 Mistakes of my life',1002,2004,3001,2007,55),
          (4005,'Da Vinci Code',1004,2003,3001,2004,450),
          (4006,'Angels and Demons',1004,2003,3001,2003,350),
          (4007,'Artificial Intelligence',1003,2002,3002,1970,500) ;
          
          select * from author1;
          
         

INSERT INTO orderdetails1 (order_id,book_id,quantity) VALUES
          (5001,4001,5),
          (5002,4002,7),
          (5003,4003,15),
          (5004,4004,11),
          (5005,4005,9),
          (5006,4006,8),
          (5007,4007,2),
          (5008,4004,3) ;
/*3: Give the details of the authors who have 2 or more books in the catalog and the price of the books in the catalog and the year of publication is after 2000
 */
 
 desc catalogue1;
 SELECT A.author1_id,A.author1_name,A.author1_city,A.author1_country, C.price FROM author1 A, catalogue1 C
          WHERE a.author1_id IN
          (SELECT distinct author1_id FROM catalogue1 WHERE
          year>2000 
          GROUP BY  author1_id HAVING COUNT(*)>1);
          
 /*4: Find the author1 of the book which has maximum sales.*/
 SELECT author1_name FROM author1 a,catalogue1 c WHERE a.author1_id=c.author1_id AND book_id IN (SELECT book_id FROM orderdetails1 WHERE quantity= (SELECT MAX(quantity) FROM orderdetails1));


/*5: Demonstrate how you increase the price of books published by a specific publisher1 by 10%.*/
UPDATE catalogue1 SET price=1.1*price
          WHERE publisher1_id IN
          (SELECT publisher1_id FROM publisher1 WHERE
         publisher1_name='pearson');
