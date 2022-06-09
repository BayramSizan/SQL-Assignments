/* DB&SQL Assignment-2 (DS 11/22 EU)
You need to create a report on whether customers who purchased the 
product named '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' buy the products below or not.


1. 'Polk Audio - 50 W Woofer - Black' -- (first_product)

2. 'SB-2000 12 500W Subwoofer (Piano Gloss Black)' -- (second_product)

3. 'Virtually Invisible 891 In-Wall Speakers (Pair)' -- (third_product)


To generate this report, you are required to use the appropriate SQL Server Built-in string functions 
(ISNULL(), NULLIF(), etc.) and Joins, as well as basic SQL knowledge. 
As a result, a report exactly like the attached file is expected from you.*/

select *
from product.product P
where P.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD';
-- product_id = 6

select *
from product.product P
where P.product_name = 'Polk Audio - 50 W Woofer - Black';
-- product_id = 13

select *
from product.product P
where P.product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)';
-- product_id = 21

select *
from product.product P
where P.product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)';
-- product_id = 16


-------- YEN� B�R TABLO OLU�TURDUM
SELECT SC.customer_id, SC.first_name, SC.last_name, PP.product_id, PP.product_name
INTO #main_table
FROM sale.customer SC
INNER JOIN sale.orders SO
	ON SC.customer_id = SO.customer_id
INNER JOIN sale.order_item OI
	ON OI.order_id = SO.order_id
INNER JOIN product.product PP
	ON PP.product_id = OI.product_id
--WHERE PP.product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD';


SELECT * FROM #main_table;


-- SADECE 2TB OLAN �R�N� ALANLAR 110 ROW VAR
SELECT * 
FROM #main_table
where product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
;

-- SADECE 2TB OLAN �R�N� ALANLAR 109 K��� VAR 1 KAYIT DUPLICATE
SELECT DISTINCT *
FROM #main_table
where product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
;

-- SADECE 2TB HDD OLAN �R�N� ALANLAR AYRI B�R TABLO YAPTIM
SELECT DISTINCT *
INTO #hdd_table
FROM #main_table
where product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
;


SELECT * FROM #hdd_table
;


-- SADECE (1. �R�N) WOOFER OLAN �R�N� ALANLAR AYRI B�R TABLO YAPTIM -- 102 KAYIT VAR
SELECT DISTINCT *
INTO #woofer_table
FROM #main_table
where product_name = 'Polk Audio - 50 W Woofer - Black'
;


-- SADECE (2. �R�N) SUBWOOFER OLAN �R�N� ALANLAR AYRI B�R TABLO YAPTIM -- 90 KAYIT VAR
SELECT DISTINCT *
INTO #subwoofer_table
FROM #main_table
where product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'
;


-- SADECE (3. �R�N) SPEAKERS OLAN �R�N� ALANLAR AYRI B�R TABLO YAPTIM -- 95 KAYIT VAR
SELECT DISTINCT *
INTO #speakers_table
FROM #main_table
where product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)'
;

SELECT * FROM #hdd_table;

-- 4 FARKLI �R�N� ALANLARI G�STEREN SONRADAN OLU�TURDU�UM 4 TABLOYU B�RLE�T�RD�M VE YEN� B�R TABLO OLU�TURUP �S�M VERD�M
SELECT H.*, W.product_name First_Product, S.product_name Second_Product, SP.product_name Third_Product
INTO #final_table
FROM #hdd_table H
LEFT JOIN #woofer_table W
	ON H.customer_id = W.customer_id
LEFT JOIN #subwoofer_table S
	ON H.customer_id = S.customer_id
LEFT JOIN #speakers_table SP
	ON H.customer_id = SP.customer_id
;

SELECT* FROM #final_table
;

-- EN SON TABLODA F�RST, SECOND, TRHIRD PRODUCT S�TUNLARININ NULL OLAN DE�ERLER�NE ISNULL FONKS�YONU �LE NO YAZDIRDIM.
-- DAHA SONRA BU �R�NDEN SATILMI� �SE �R�N ADI YER�NE REPLACE METODU �LE YES YAZDIRDIM.
SELECT F.customer_id, F.first_name, F.last_name, 
		REPLACE(ISNULL(F.First_Product, 'No'), 'Polk Audio - 50 W Woofer - Black', 'Yes') First_product,
		REPLACE(ISNULL(F.Second_Product, 'No'), 'SB-2000 12 500W Subwoofer (Piano Gloss Black)', 'Yes') Second_product,
		REPLACE(ISNULL(F.Third_Product, 'No'), 'Virtually Invisible 891 In-Wall Speakers (Pair)', 'Yes') Third_product
FROM #final_table F
;