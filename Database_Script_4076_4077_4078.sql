CREATE DATABASE Smart_Auto_Parts_Ordering_System;

USE Smart_Auto_Parts_Ordering_System;

-- *************Create Tables*****************

CREATE TABLE CUSTOMER (
	Customer_Id varchar(10)  NOT NULL,
    User_Name varchar(45) NOT NULL,
    Customer_Name varchar(45) NOT NULL,  
    Email varchar(45) NOT NULL,
    User_passwod varchar(45) NOT NULL,  
    PRIMARY KEY (Customer_Id)
);
CREATE TABLE CUSTOMER_PHONENO (
	Customer_Id varchar(10)  NOT NULL,
    Phone_no varchar(12) NOT NULL,
    PRIMARY KEY (Customer_Id, Phone_no)
);
CREATE TABLE SUPPLIER (
    Supplier_Id  varchar(10) NOT NULL,  
    Supplier_name varchar(50)NOT NULL,
    Email varchar(50)NOT NULL,
    PRIMARY KEY (Supplier_Id)
);
CREATE TABLE PRODUCT (
	Product_Id varchar(10)  NOT NULL,
    Supplier_Id  varchar(10) NOT NULL,
    Product_Name varchar(45) NOT NULL,
    Quantity int  NOT NULL,  
    price float (45) NOT NULL,
    Discount_Price float(45) NOT NULL, 
    Discription varchar(45) NOT NULL, 
    Weight float (45) NOT NULL,  
    Product_Img_URL varchar(45) NOT NULL,  
    PRIMARY KEY (Product_Id)
);
CREATE TABLE MANUFACTURER (
    Manufacturer_Id varchar(10) NOT NULL,
	Product_Id varchar(10)  NOT NULL,
    Manu_name varchar(50)NOT NULL, 
    Website varchar(50)NOT NULL,
    PRIMARY KEY (Manufacturer_Id)
);
CREATE TABLE MANUFACTURER_CONTACT (
	Manufacturer_Id varchar(10) NOT NULL,
    Contact_Name varchar(50)NOT NULL,
    Email varchar(50)NOT NULL,
    PRIMARY KEY (Manufacturer_Id,Contact_Name)
);
CREATE TABLE CART (
    Cart_Id varchar(10) NOT NULL,
    Customer_Id varchar(10)  NOT NULL,
    Total_Price int NOT NULL,
    Total_item int NOT NULL,
    PRIMARY KEY (Cart_Id)
);
CREATE TABLE PRODUCT_CART(
	Product_Id varchar(10)  NOT NULL,
	Cart_Id varchar(10) NOT NULL,
    primary key(Cart_Id,Product_Id)
    
);
CREATE TABLE REVIEW (
	Customer_Id varchar(10)  NOT NULL,
	Rating int NULL, 
    Comments varchar(100) NOT NULL, 
    PRIMARY KEY (Customer_Id,Comments)
);
CREATE TABLE DELIVERY_DETAILS (
    Delivery_Id varchar(10) NOT NULL, 
	Customer_Id varchar(10)  NOT NULL,
    Tracking_URL varchar(50)NOT NULL,
    Delivery_Period int,
    Order_Date date NULL, 
    Delivery_Date date,
    House_No varchar(50)NULL,
	Province varchar(50) NULL,
    Street varchar(50)NOT NULL,
    City varchar(50)NOT NULL,
   
    PRIMARY KEY (Delivery_Id)
);



CREATE TABLE _ORDER ( 
    Order_Id varchar(10) NOT NULL,
    Cart_Id varchar(10) NOT NULL,
    Delivery_Id varchar(10) NOT NULL, 
    Order_Date date  NULL, 
    Coupon_Code varchar(50) NULL,
    Total_Amount varchar(50)NOT NULL,
    PRIMARY KEY (Order_Id)
);
CREATE TABLE PAYMENT (
    Payment_Id varchar(10) NOT NULL, 
    Order_Id varchar(10) NOT NULL,
    Card_No varchar(25) NOT NULL,
    Card_holders_name varchar(50)NOT NULL, -- uper mark
    Crypto_Id varchar(20),
    PRIMARY KEY (Payment_Id)

);

-- ***************foreign key**************

alter table PRODUCT
ADD CONSTRAINT FK_product
foreign key(Supplier_Id) references SUPPLIER(Supplier_Id)
on delete cascade on update cascade;

alter table CUSTOMER_PHONENO
ADD CONSTRAINT FK_phoneno
foreign key(Customer_Id) references CUSTOMER(Customer_Id)
on delete cascade on update cascade;

alter table MANUFACTURER
ADD CONSTRAINT FK_pro_id
foreign key(Product_Id) references PRODUCT(Product_Id)
on delete cascade on update cascade;

alter table MANUFACTURER_CONTACT
ADD CONSTRAINT FK_manu_id
foreign key(Manufacturer_Id) references MANUFACTURER(Manufacturer_Id)
on delete cascade on update cascade;

alter table CART
ADD CONSTRAINT FK_cus_id
foreign key(Customer_Id) references CUSTOMER(Customer_Id)
on delete cascade on update cascade;

alter table REVIEW
ADD CONSTRAINT FK_cust_id
foreign key(Customer_Id) references CUSTOMER(Customer_Id)
on delete cascade on update cascade;

alter table DELIVERY_DETAILS
ADD CONSTRAINT FK_custr_id
foreign key(Customer_Id) references CUSTOMER(Customer_Id)
on delete cascade on update cascade;

alter table _ORDER
ADD CONSTRAINT FK_cart_id
foreign key(Cart_Id) references CART(Cart_Id)
on delete cascade on update cascade;

alter table _ORDER
ADD CONSTRAINT FK_delivery_id
foreign key(Delivery_Id) references DELIVERY_DETAILS(Delivery_Id)
on delete cascade on update cascade;

alter table PAYMENT
ADD CONSTRAINT FK_ordr_id
foreign key(Order_Id) references _Order(Order_Id)
on delete cascade on update cascade;


alter table PAYMENT
add constraint FK_money
foreign key(Crypto_ID) references PAYMENT(Payment_ID)
on delete SET NULL on update cascade;

 alter table PRODUCT_CART
 ADD CONSTRAINT FK_id
 foreign key(Cart_Id) references CART(Cart_Id)
 on delete cascade on update cascade;

 alter table PRODUCT_CART
 ADD CONSTRAINT FK_Pr_id
 foreign key(Product_Id) references PRODUCT(Product_Id)
 on delete cascade on update cascade;

-- set trigger to Get Delivery date when insert and update in Delivery Details table

DELIMITER $

CREATE TRIGGER CalculateDeliveryDate
BEFORE INSERT ON Delivery_Details
FOR EACH ROW
BEGIN
    SET NEW.Delivery_Date = DATE_ADD(NEW.Order_Date, INTERVAL NEW.Delivery_Period DAY);
END;
$
DELIMITER ;

DELIMITER $

CREATE TRIGGER CalculateUpdatedDeliveryDate
BEFORE update ON Delivery_Details
FOR EACH ROW
BEGIN
    SET NEW.Delivery_Date = DATE_ADD(NEW.Order_Date, INTERVAL NEW.Delivery_Period DAY);
END;
$
DELIMITER ;


-- *************Insert *************

INSERT INTO CUSTOMER VALUES ('CUST001' , 'minhaj_mha' , 'Minhaj' , 'minhajmha@gmail.com' , 'MHAminhaj98' );
INSERT INTO CUSTOMER VALUES( 'CUST002' , 'morais_mns' , 'Nirasha Morais' , 'nirashamorais@gmail.com' , 'NIRASHAsavi1234' );
INSERT INTO CUSTOMER VALUES ( 'CUST003' , 'morawaliyadda_mghsm' , 'Hansani Sithara' , 'sitharamorawaliyadda@gmail.com' , 'Hansani2048#' );
INSERT INTO CUSTOMER VALUES ('CUST004' , 'susmi_rikithsha' , 'Susmi Rikithsha' , 'susmi98@gmail.com' , 'SCHOOL98' );
INSERT INTO CUSTOMER VALUES ('CUST005' , 'jane_perera' , 'Jane Perera' , 'Janeperera@gmail.com' , 'JANE99#');
INSERT INTO CUSTOMER VALUES ('CUST006' , 'suhara_whn' , 'Suhara Nikini' , 'nikinisuhara@gmail.com' , 'SUHARAnikini22' );


INSERT INTO SUPPLIER VALUES ('SUP001' , 'Merigo AutoParts Inc.' , 'merigoautoparts.com' );
INSERT INTO SUPPLIER VALUES ('SUP002' , 'Shimin Car Parts Suppliers' ,  'carparts@shimin.com');
INSERT INTO SUPPLIER VALUES ('SUP003' , 'Miral Car Parts Industries' , 'MiralCarautoparts@lexomo.com');
INSERT INTO SUPPLIER VALUES ('SUP004' , 'Berrodin Quality Auto Parts Suppliers' ,  'qualityautoparts@berrodin.com');
INSERT INTO SUPPLIER VALUES('SUP005' , 'Yonda Motor Parts Suppliers' ,  'motorparts@yonda.com' );
INSERT INTO SUPPLIER VALUES('SUP006' , 'Zuati Quality Auto Pvt Ltd' , 'autoparts@welch.com');


INSERT INTO PRODUCT VALUES ( 'PROD001' , 'SUP003' , 'Cabin Air Filter',125, 6700,520 , 'Clean air filters to get rid of air pollution', 0.5,'https://odering.com/images/cabinfilter.jpg');
INSERT INTO PRODUCT VALUES('PROD002' , 'SUP003' , 'Brake Pads' , 130 , 2000, 230 , 'High quality brake pads' , 0.5, 'https://odering.com/images/brakepads.jpg');
INSERT INTO PRODUCT VALUES('PROD003' , 'SUP004' , 'Car batteries' , 239 , 60000, 4120 , 'Long lasting car batteries for varoius models',15, 'https://odering.com/images/carbatteries.jpg');
INSERT INTO PRODUCT VALUES('PROD004' , 'SUP001' , 'Spark Plugs', 182,7200,1240,'Standard plugs for improved ignition', 0.1, 'https://odering.com/images/sparkplugs.jpg');
INSERT INTO PRODUCT VALUES('PROD005' , 'SUP001' , 'Car tires',51, 52000,2040,'Durable tires for cars',25, 'https://odering.com/images/cartires.jpg');
INSERT INTO PRODUCT VALUES ('PROD006' , 'SUP005','Radiator',302,5700,450,'High quality radiator to cool the engine', 30,'https://odering.com/images/radiator.jpg');


INSERT INTO MANUFACTURER VALUES ('MANU001' ,'PROD001','ALNE Auto Parts', 'https://www.alneautoparts.com' );
INSERT INTO MANUFACTURER VALUES ('MANU002' ,'PROD002' ,'Zuati Quality Auto Pvt Ltd' , 'https://www.zuatiauto.com');
INSERT INTO MANUFACTURER VALUES ( 'MANU003' ,'PROD003' ,'OEM Auto tech Industries' , 'https://oemautotech.com');
INSERT INTO MANUFACTURER VALUES ('MANU004' ,'PROD004' ,'Miral Car Parts Industries' , 'https://miralcarauto.com');
INSERT INTO MANUFACTURER VALUES('MANU005','PROD005','LSK Auto Pvt Ltd' , 'https://lskautopvt.com');
INSERT INTO MANUFACTURER VALUES('MANU006' ,'PROD006' ,'Cadeko Premium Auto Parts' , 'https://cadekopremiumauto.com');


INSERT INTO MANUFACTURER_CONTACT VALUES ('MANU001' ,'John' , 'alneautoparts@gmail.com');
INSERT INTO MANUFACTURER_CONTACT VALUES ('MANU002','Shihara' , 'zuatiqualityautoz2gmail.com');
INSERT INTO MANUFACTURER_CONTACT VALUES('MANU003','Damion' , 'oemautotech@gmail.com');
INSERT INTO MANUFACTURER_CONTACT VALUES('MANU004','Ocean' , 'miralcarparts@gmail.com');
INSERT INTO MANUFACTURER_CONTACT VALUES('MANU005','Liam' , 'lskautopvt@gmail.com');
INSERT INTO MANUFACTURER_CONTACT VALUES('MANU006','Thanweer' , 'cadekopremiumauto@gmail.com');


INSERT INTO REVIEW VALUES ('CUST001' , 4 , 'Great service and fast shipping');
INSERT INTO REVIEW VALUES ('CUST002' , null , 'Good prices and easy navigation on the website');
INSERT INTO REVIEW VALUES ('CUST003' , '5' , 'Excellent quality products');
INSERT INTO REVIEW VALUES ('CUST004' , '3' , 'The autoparts are in good quality,but the delivery was late');
INSERT INTO REVIEW VALUES ('CUST005' , null , 'Very satisfied with your service');
INSERT INTO REVIEW VALUES ('CUST006' , '3' , 'Average experience, I expected more than this');


 
INSERT INTO CART VALUES('CART001' , 'CUST004',13400,2);
INSERT INTO CART VALUES ('CART002','CUST003',8000,4);
INSERT INTO CART VALUES ('CART003','CUST004',120000,2);
INSERT INTO CART VALUES ('CART004','CUST002',7200,1);
INSERT INTO CART VALUES ('CART005','CUST002',10400,2);
INSERT INTO CART VALUES ('CART006','CUST001',31200,6);


INSERT INTO PRODUCT_CART VALUES('PROD001', 'CART001');
INSERT INTO PRODUCT_CART VALUES('PROD002', 'CART001');
INSERT INTO PRODUCT_CART VALUES('PROD003', 'CART002');
INSERT INTO PRODUCT_CART VALUES('PROD004', 'CART002');
INSERT INTO PRODUCT_CART VALUES('PROD005', 'CART003');
INSERT INTO PRODUCT_CART VALUES('PROD006', 'CART004');


INSERT INTO  DELIVERY_DETAILS VALUES ('DELIV001','CUST006','https://trackautopartsdelivery.com/99258',3 ,'2023-09-26',null,'Batticaloa','33/A','Thirupathi Road','Batticaloa');
INSERT INTO DELIVERY_DETAILS VALUES('DELIV002','CUST006','https://trackautopartsdelivery.com/99288',3 ,'2023-09-17',null,'Batticaloa','33/A','Thirupathi Road','Batticaloa');
INSERT INTO DELIVERY_DETAILS VALUES('DELIV003','CUST003','https://trackautopartsdelivery.com/99202',2,null,null,'Kandy',null,'43-Dunagaha Road','Marassana');
INSERT INTO DELIVERY_DETAILS VALUES('DELIV004','CUST002','https://trackautopartsdelivery.com/99254',5,'2023-09-19',null,null,'709/A', 'Station Road','Ja ela');
INSERT INTO DELIVERY_DETAILS VALUES('DELIV005','CUST003', 'https://trackautopartsdelivery.com/99248',4,null,null, 'Kandy',null,'43-Dunagaha Road','Marassana');
INSERT INTO DELIVERY_DETAILS VALUES('DELIV006','CUST001','https://trackautopartsdelivery.com/99248',3,'2023-09-20',null,'Uva','33/C','Kanupalalla Road','Badulla');


INSERT INTO _ORDER VALUES('ORD001' , 'CART002','DELIV002','2023-09-16','ORDERDEAL' , 8500);
INSERT INTO _ORDER VALUES('ORD002','CART002','DELIV002','2023-09-17',null,9200);
INSERT INTO _ORDER VALUES('ORD003','CART001','DELIV001','2023-09-17','PROMOtoday',13650);
INSERT INTO _ORDER VALUES('ORD004', 'CART003','DELIV003','2023-09-15','DISCOUNT123',120500);
INSERT INTO _ORDER VALUES('ORD005','CART005','DELIV005',null,'AB15-E90D',10650);
INSERT INTO _ORDER VALUES('ORD006','CART004','DELIV005', null,null,31500);


INSERT INTO PAYMENT VALUES('PAY001','ORD004','5241 6701 2345 6789','Morawaliyadda',null);
INSERT INTO PAYMENT VALUES('PAY002','ORD002','5574 3510 1147 5025','Morais',null);
INSERT INTO PAYMENT VALUES('PAY003','ORD003','6578 4760 4325 1256','Minhaj','PAY003');
INSERT INTO PAYMENT VALUES('PAY004','ORD002','9045 6754 1343 5643','Morais',null);
INSERT INTO PAYMENT VALUES('PAY005','ORD001','5678 2356 6590 1256','Morais','PAY005');
INSERT INTO PAYMENT VALUES('PAY006','ORD006','5467 1345 0990 3260','Minhaj',null);


-- ************* Update and Delete

UPDATE CUSTOMER set Email='SitharaMora@gmail.com' where Customer_Id='CUST003';
UPDATE CUSTOMER set user_name='suhar_whm' where Customer_Id='CUST006';

Delete from CUSTOMER where Customer_Id='CUST005';

UPDATE SUPPLIER set Supplier_name='Shimin Auto Parts Suppliers' where Supplier_Id='SUP002';
UPDATE SUPPLIER set Email='Zuatiautoparts@Welchauto.com' where Supplier_Id='SUP006';

Delete from SUPPLIER where Supplier_Id='SUP002';

UPDATE PRODUCT set Quantity=128 where Product_Id='PROD002';
UPDATE PRODUCT set Price=2500 where Product_Id='PROD003';

-- this one error
 Delete from PRODUCT where Product_Id='PROD006';

UPDATE MANUFACTURER set Manu_name='OBM Auto tech Industries' where Manufacturer_Id='MANU003';
UPDATE MANUFACTURER set Product_Id='PROD002' where Manufacturer_Id='MANU003';

Delete from MANUFACTURER where Manufacturer_Id='MANU003';

UPDATE MANUFACTURER_CONTACT set Contact_name='Shihara' where Manufacturer_Id='MANU002';
UPDATE MANUFACTURER_CONTACT set Email='alneautopartsnew@gmail.com' where Manufacturer_Id='MANU001';

Delete from MANUFACTURER_CONTACT where Manufacturer_Id='MANU001';

UPDATE REVIEW set Rating=2 where Customer_Id='CUST002';
UPDATE REVIEW set Rating=4 where Customer_Id='CUST003';

Delete from REVIEW where Customer_Id='CUST003'; 

UPDATE CART set Total_price=13500 where Cart_Id='CART001';
UPDATE CART set Total_item=3 where Cart_Id='CART003';

-- this one error
 Delete from CART where Cart_Id='CART003';


UPDATE DELIVERY_DETAILS set Delivery_Period=6  where Delivery_Id='DELIV001';
UPDATE DELIVERY_DETAILS set House_No='23/A' where Delivery_Id='DELIV002';

Delete from DELIVERY_DETAILS where Delivery_Id='DELIV003' ;


UPDATE _ORDER set Order_Date='2023-09-18' where Order_Id='ORD001';
UPDATE _ORDER set Total_Amount='123500' where Order_Id='ORD004';

Delete from _ORDER where Order_Id='ORD004';

UPDATE PAYMENT set Card_no='5574 3510 1149 7896' where Payment_Id='PAY002';
UPDATE PAYMENT set CRYPTO_ID='PAY004' where Payment_Id='PAY004';

Delete from PAYMENT where Payment_Id='PAY005';



-- ****************Simple queries***********

-- 1) Select operation

SELECT * FROM PRODUCT WHERE  Quantity > 150;

-- 2) project operation

SELECT  Manufacturer_Id, Manu_name, Website FROM MANUFACTURER;

-- 3) cartesian product operation

SELECT * FROM MANUFACTURER
CROSS JOIN MANUFACTURER_CONTACT;

-- 4) creating a user view

CREATE VIEW user_view AS
SELECT Product_Name, Quantity, price, Discount_Price, Discription
FROM PRODUCT;

SELECT * FROM user_View;

-- 5) renaming operation

RENAME TABLE PAYMENT TO PAYMENT_DETAILS;

ALTER TABLE REVIEW
RENAME COLUMN COMMENTS TO FEEDBACK;

-- 6) use of an aggregation function 

-- Maximum
SELECT MAX(PRICE) AS max_price
FROM PRODUCT;

-- Minimum
SELECT MIN(PRICE) AS min_price
FROM PRODUCT;

-- Average
SELECT AVG(PRICE) AS average_price
FROM PRODUCT;

-- 7)  use of LIKE keyword

SELECT * FROM PRODUCT
WHERE PRODUCT_NAME LIKE '%spark plug%';


-- Complex Queries

-- Set Operations

-- 8) Union
-- Union Manufacturers and Suppliers

SELECT MANU.MANU_NAME FROM MANUFACTURER As MANU
UNION
SELECT SUP.SUPPLIER_NAME FROM SUPPLIER as SUP;

-- 9) Intersection

-- Finding the customers who added products into their cart
SELECT Cus.Customer_ID, Customer_Name
FROM Customer Cus
LEFT JOIN Cart C ON Cus.Customer_ID = C.Customer_ID;



-- 10) Set difference

-- Customers who bougth total amount greater than cart total price which is greater than Rs.20000

SELECT D.TOTAL_AMOUNT
FROM _ORDER D
LEFT JOIN CART D2 ON D.TOTAL_AMOUNT> D2.TOTAL_PRICE
WHERE D.TOTAL_AMOUNT > 20000 ;



-- 11) division

-- Customers who have purchased products and reviewed
SELECT c.Customer_Id, c.Customer_Name, C.USER_NAME
FROM CUSTOMER c
WHERE  EXISTS (
    SELECT p.customer_id
    FROM REVIEW p
    WHERE EXISTS(
        SELECT o.customer_ID
        FROM CART o
        WHERE o.CART_ID IN (
            SELECT F.CART_ID
            FROM _ORDER F
            WHERE F.CART_ID = O.CART_ID
        )
       AND
       O.CUSTOMER_ID = p.CUSTOMER_ID
    
    ) AND
    C.CUSTOMER_ID=P.CUSTOMER_ID 
 
);



 

-- ***************************************************************************
-- Creating user views for customer entity and product entity
-- Create a view for Customers
CREATE VIEW CustomerView AS
SELECT Customer_ID, Customer_Name, user_name, Email
FROM CUSTOMER;

-- Create a view for Orders
CREATE VIEW deliveryView AS
SELECT Delivery_ID, customer_id, delivery_period, Delivery_date, Tracking_URL
FROM DELIVERY_DETAILS;


-- 12) Inner Join

-- Inner Join Customer and Delivery_Details on Customer_ID
SELECT *
FROM CustomerView
INNER JOIN deliveryView ON CustomerView.Customer_ID = deliveryView.Customer_ID;

-- 13) natural join

-- Natural Join Customer and Delivery_Details
SELECT *
FROM CustomerView
NATURAL JOIN DeliveryView;

-- 14) left outer join

-- Left Outer Join Customers and Delivery_Details on Customer_ID
SELECT *
FROM CustomerView
LEFT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID;

-- 15) right outer join

-- Right Outer Join Customers and Delivery_Details on Customer_ID
SELECT *
FROM CustomerView
RIGHT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID;

-- 16) full outer join

-- Full Outer Join Customers and Delivery_Details on Customer_ID
SELECT *
FROM CustomerView
LEFT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID
UNION
SELECT *
FROM CustomerView
RIGHT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID;

-- 17) outer union

-- Outer union Customer and Delivery_Details


CREATE VIEW SupplierView AS
SELECT SUPPLIER_ID, SUPPLIER_NAME, EMAIL
FROM SUPPLIER;

CREATE VIEW ManufacturerView AS
SELECT MANUFACTURER_ID, MANU_NAME, WEBSITE
FROM MANUFACTURER;

-- Outer Union of Supplier and Manufacturer views
SELECT *
FROM SupplierView
UNION
SELECT *
FROM ManufacturerView;


--  nested queries in combination with any other relational algebraic operation.

-- 18) Intersection of Product and Supplier using inner join ( where manufactuerer supplies thier product)

SELECT Manufacturer_ID, Manu_name
FROM Manufacturer
WHERE Manu_name IN (
    SELECT Supplier_name
    FROM supplier
);

-- 19) Finding customers who have not placed orders after added product into their cart

SELECT Customer_ID, Customer_Name, Email
FROM Customer
WHERE Customer_ID IN (
    SELECT DISTINCT Customer_ID
    FROM Cart
WHERE CART_ID NOT IN (
    SELECT DISTINCT Cart_ID
    FROM _order
));


-- 20) Create a trigger to make sure that when updating quantity in Product, 
-- if the updated product quantity greater than 100, product price get 50% extra discount otherwise it shows 
-- the message "New Discount Price cannot set" to update

delimiter $

create trigger trig11
before update on PRODUCT
for each row
begin
if quantity < 100  then
set NEW.DISCOUNT_PRICE = OLD.DISCOUNT_PRICE;
SIGNAL sqlstate '45000' SET MESSAGE_TEXT = 'New Discount Price cannot set';
END IF;
END;

$

delimiter ;




-- **********************Database Tuning*********************************


-- 1) Union
-- Union Manufacturers and Suppliers

-- Before Tuning  
EXPLAIN(SELECT MANU.MANU_NAME FROM MANUFACTURER As MANU
UNION
SELECT SUP.SUPPLIER_NAME FROM SUPPLIER as SUP);

--  Tuning
CREATE INDEX INDEX_1 ON MANUFACTURER(MANU_NAME);
CREATE INDEX INDEX_1_1 ON SUPPLIER(SUPPLIER_NAME);


SHOW INDEXES FROM MANUFACTURER;

-- After Tuning
EXPLAIN(SELECT MANU.MANU_NAME FROM MANUFACTURER As MANU
UNION
SELECT SUP.SUPPLIER_NAME FROM SUPPLIER as SUP);

DROP INDEX INDEX_1 ON MANUFACTURER;
DROP INDEX INDEX_1_1 ON SUPPLIER;


-- 2) Intersection

-- Finding the customers who added products into their cart

-- Before Tuning
EXPLAIN(SELECT Cus.Customer_ID, Customer_Name
FROM Customer Cus
LEFT JOIN Cart C ON Cus.Customer_ID = C.Customer_ID);

--  Tunning
CREATE INDEX INDEX_2 ON CUSTOMER(CUSTOMER_ID);

SHOW INDEXES FROM CUSTOMER;

-- After Tuning
EXPLAIN(SELECT Cus.Customer_ID, Customer_Name
FROM Customer Cus
LEFT JOIN Cart C ON Cus.Customer_ID = C.Customer_ID);

DROP INDEX INDEX_2 ON CUSTOMER;


-- 3) Set difference

-- Customers who bougth total amount greater than cart total price which is greater than Rs.20000

-- Before Tuning
EXPLAIN(SELECT D.TOTAL_AMOUNT
FROM _ORDER D
LEFT JOIN CART D2 ON D.TOTAL_AMOUNT> D2.TOTAL_PRICE
WHERE D.TOTAL_AMOUNT > 20000 );

-- Tuning
CREATE INDEX index_3 ON _ORDER(ORDER_ID);

SHOW INDEXES FROM _ORDER;

-- After Tunning
EXPLAIN(SELECT D.TOTAL_AMOUNT
FROM _ORDER D
LEFT JOIN CART D2 ON D.TOTAL_AMOUNT> D2.TOTAL_PRICE
WHERE D.TOTAL_AMOUNT > 20000 );

DROP INDEX INDEX_3 ON _ORDER;


-- 4) Inner Join

-- Inner Join Customer and Delivery_Details on Customer_ID

-- Before Tuning
EXPLAIN(SELECT *
FROM CustomerView
INNER JOIN deliveryView ON CustomerView.Customer_ID = deliveryView.Customer_ID);

-- Tuning
CREATE INDEX index_4 ON CUSTOMER(CUSTOMER_ID);

SHOW INDEXES FROM CUSTOMER;

-- After Tuning
EXPLAIN(SELECT *
FROM CustomerView
INNER JOIN deliveryView ON CustomerView.Customer_ID = deliveryView.Customer_ID);

DROP INDEX INDEX_4 ON CUSTOMER;


-- 5)  natural join

-- Natural Join Customer and Delivery_Details
-- Before Tuning
EXPLAIN(SELECT *
FROM CustomerView
NATURAL JOIN DeliveryView);

-- Tunning
CREATE INDEX INDEX_5 ON CUSTOMER(CUSTOMER_ID);

SHOW INDEXES FROM CUSTOMER;

-- After Tuning
EXPLAIN(SELECT *
FROM CustomerView
NATURAL JOIN DeliveryView);

DROP INDEX INDEX_5 ON CUSTOMER;


-- 6) left outer join

-- Left Outer Join Customers and Delivery_Details on Customer_ID

-- Before Tuning
ExPLAIN( SELECT *
FROM CustomerView
LEFT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID);

-- Tuning
CREATE INDEX INDEX_6 ON CUSTOMER(CUSTOMER_ID);

SHOW INDEXES FROM CUSTOMER;

-- After Tunning
EXPLAIN(SELECT *
FROM CustomerView
LEFT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID);

DROP INDEX INDEX_6 ON CUSTOMER;


-- 7) right outer join

-- Right Outer Join Customers and Delivery_Details on Customer_ID

-- Before Tuning
EXPLAIN (SELECT *
FROM CustomerView
RIGHT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID);

-- Tuning
CREATE INDEX INDEX_7 ON CUSTOMER(CUSTOMER_ID);

SHOW INDEXES FROM DELIVERY_DETAILS;

-- After Tuning
EXPLAIN (SELECT *
FROM CustomerView
RIGHT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID);

DROP INDEX INDEX_7 ON CUSTOMER;


-- 8) full outer join

-- Full Outer Join Customers and Delivery_Details on Customer_ID

-- Before Tuning
EXPLAIN(SELECT *
FROM CustomerView
LEFT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID
UNION
SELECT *
FROM CustomerView
RIGHT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID);

-- Tuning
CREATE INDEX INDEX_8 ON CUSTOMER(CUSTOMER_ID);

SHOW INDEXES FROM CUSTOMER;

-- After Tuning
EXPLAIN(SELECT *
FROM CustomerView
LEFT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID
UNION
SELECT *
FROM CustomerView
RIGHT JOIN DeliveryView ON CustomerView.Customer_ID = DeliveryView.Customer_ID);

DROP INDEX INDEX_8 ON CUSTOMER;


-- 9) Intersection of Product and Supplier using inner join ( where manufactuerer supplies thier product)

-- Before Tunning
EXPLAIN(SELECT Manufacturer_ID, Manu_name
FROM Manufacturer
WHERE Manu_name IN (
    SELECT Supplier_name
    FROM supplier
));

-- Tuning
CREATE INDEX INDEX_9 ON MANUFACTURER(MANUFACTURER_ID);
CREATE INDEX INDEX_9_1 ON SUPPLIER(SUPPLIER_ID);

SHOW INDEXES FROM MANUFACTURER;
SHOW INDEXES FROM SUPPLIER;

-- After Tuning
EXPLAIN(SELECT Manufacturer_ID, Manu_name
FROM Manufacturer
WHERE Manu_name IN (
    SELECT Supplier_name
    FROM supplier
));

DROP INDEX INDEX_9 ON MANUFACTURER;
DROP INDEX INDEX_9_1 ON SUPPLIER;

-- 19) Finding customers who have not placed orders after added product into their cart

-- Before Tuning
EXPLAIN(SELECT Customer_ID, Customer_Name, Email
FROM Customer
WHERE Customer_ID IN (
    SELECT DISTINCT Customer_ID
    FROM Cart
WHERE CART_ID NOT IN (
    SELECT DISTINCT Cart_ID
    FROM _order
)));

-- Tuning
CREATE INDEX INDEX_10 ON CUSTOMER(CUSTOMER_ID);

-- After Tuning
EXPLAIN(SELECT Customer_ID, Customer_Name, Email
FROM Customer
WHERE Customer_ID IN (
    SELECT DISTINCT Customer_ID
    FROM Cart
WHERE CART_ID NOT IN (
    SELECT DISTINCT Cart_ID
    FROM _order
)));


DROP INDEX INDEX_10 ON CUSTOMER;

DROP DATABASE Smart_Auto_Parts_Ordering_System;

