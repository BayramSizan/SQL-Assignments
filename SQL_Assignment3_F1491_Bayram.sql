/*
1. Conversion Rate
Below you see a table of the actions of customers 
visiting the website by clicking on two different types of advertisements 
given by an E-Commerce company. 
Write a query to return the conversion rate for each Advertisement type.

				Actions:
Visitor_ID		Adv_Type		Action
1					A			Left
2					A			Order
3					B			Left
4					A			Order
5					A			Review
6					A			Left
7					B			Left
8					B			Order
9					B			Review
10					A			Review

	Desired Output:
Adv_Type	Conversion_Rate
A				0.33
B				0.25

a.    Create above table (Actions) and insert values,
b.    Retrieve count of total Actions and Orders for each Advertisement Type,
c.    Calculate Orders (Conversion) rates for each Advertisement Type 
		by dividing by total count of actions casting as float by multiplying by 1.0.
*/

-- DATABASE OLUÞTURDUM VE ÝSÝM VERDÝM.
CREATE DATABASE assignment_db; 

USE assignment_db;

-- TABLE OLUÞTURDUM, ÝSÝM VERDÝM VE 3 TANE SÜTUN OLUÞTURDUM.
CREATE TABLE actions (
					Visitor_ID TINYINT NOT NULL IDENTITY(1,1),
					Adv_Type CHAR(2) NOT NULL,
					[Action] CHAR(5) NOT NULL
					);

-- OLUÞAN ACTÝON SÜTUNUNA 5 KARAKTER YETMEDÝÐÝ ÝÇÝN DEÐÝÞTÝRDÝM.
ALTER TABLE actions
ALTER COLUMN [Action] VARCHAR(10) NOT NULL;

SELECT * FROM actions;

-- DEÐERLERÝ TABLOYA GÝRDÝM.
SET IDENTITY_INSERT actions ON;
INSERT actions (Visitor_ID, Adv_Type, Action)
VALUES
(1, 'A',			'Left'),
(2, 'A',			'Order'),
(3, 'B',			'Left'),
(4, 'A',			'Order'),
(5, 'A',			'Review'),
(6, 'A',			'Left'),
(7, 'B',			'Left'),
(8, 'B',			'Order'),
(9, 'B',			'Review'),
(10, 'A',			'Review');
SET IDENTITY_INSERT actions OFF;

SELECT * FROM actions;

-- ÝHTÝYAÇ OLUSA BU KOD ÝLE GÝRÝLEN DEÐERLERÝ SÝLDÝM.
-- delete from actions where Visitor_ID >= 1;

-- YENÝ BÝR SÜTUN EKLEDÝM.
ALTER TABLE actions
ADD Conversion_Rate DECIMAL(3, 2) NULL;

SELECT * FROM actions;

-- LEFT VE ORDER OLAN SÜTUNLARI O VE 1 ÝLE GÖRÜNTÜLEDÝM.
select	Adv_Type, action,
		case Action
			when 'Left' then 0
			when 'Order' then 1
			-- when 'Review' then 0.50
		end Conversion_Rate
from	actions
where Adv_Type = 'B'

-- LEFT VE ORDER OLAN SÜTUNLARI O VE 1 ÝLE DEÐÝÞTÝRDÝM.
UPDATE actions
SET Conversion_Rate = 
(case Action
			when 'Left' then 0
			when 'Order' then 1
			-- when 'Review' then 0.50
		end);

-- TÝPLERE GÖRE DÖNÜÞÜM ORANLARINI HESAPLADIM.
SELECT Adv_Type, (sum(Conversion_Rate)/count(*)) AS Conversion_Rate
FROM actions
GROUP BY Adv_Type;
