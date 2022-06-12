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

-- DATABASE OLU�TURDUM VE �S�M VERD�M.
CREATE DATABASE assignment_db; 

USE assignment_db;

-- TABLE OLU�TURDUM, �S�M VERD�M VE 3 TANE S�TUN OLU�TURDUM.
CREATE TABLE actions (
					Visitor_ID TINYINT NOT NULL IDENTITY(1,1),
					Adv_Type CHAR(2) NOT NULL,
					[Action] CHAR(5) NOT NULL
					);

-- OLU�AN ACT�ON S�TUNUNA 5 KARAKTER YETMED��� ���N DE���T�RD�M.
ALTER TABLE actions
ALTER COLUMN [Action] VARCHAR(10) NOT NULL;

SELECT * FROM actions;

-- DE�ERLER� TABLOYA G�RD�M.
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

-- �HT�YA� OLUSA BU KOD �LE G�R�LEN DE�ERLER� S�LD�M.
-- delete from actions where Visitor_ID >= 1;

-- YEN� B�R S�TUN EKLED�M.
ALTER TABLE actions
ADD Conversion_Rate DECIMAL(3, 2) NULL;

SELECT * FROM actions;

-- LEFT VE ORDER OLAN S�TUNLARI O VE 1 �LE G�R�NT�LED�M.
select	Adv_Type, action,
		case Action
			when 'Left' then 0
			when 'Order' then 1
			-- when 'Review' then 0.50
		end Conversion_Rate
from	actions
where Adv_Type = 'B'

-- LEFT VE ORDER OLAN S�TUNLARI O VE 1 �LE DE���T�RD�M.
UPDATE actions
SET Conversion_Rate = 
(case Action
			when 'Left' then 0
			when 'Order' then 1
			-- when 'Review' then 0.50
		end);

-- T�PLERE G�RE D�N���M ORANLARINI HESAPLADIM.
SELECT Adv_Type, (sum(Conversion_Rate)/count(*)) AS Conversion_Rate
FROM actions
GROUP BY Adv_Type;
