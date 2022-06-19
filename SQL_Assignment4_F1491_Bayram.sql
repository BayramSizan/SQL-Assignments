/*		Discount Effects
Generate a report including product IDs and discount effects on 
whether the increase in the discount rate positively impacts the number of orders for the products.

In this assignment, you are expected to generate a solution using SQL with a logical approach. 

		Sample Result:
Product_id		Discount Effect
	1				Positive
	2				Negative
	3				Negative
	4				Neutral

*/

SELECT distinct product_id
FROM product.product
;

SELECT *
FROM product.product
;

select * 
from sale.order_item
order by 3;

select *
from sale.order_item
order by product_id, discount;

select product_id, discount, quantity
		,sum(quantity) over(partition by product_id, discount) sum
from sale.order_item
order by product_id, discount;

select distinct product_id, discount,
		sum(quantity) over(partition by product_id, discount) sum_of_quantity
from sale.order_item
order by product_id, discount;

select distinct product_id, discount,
		sum(quantity) over(partition by product_id, discount) sum_of_quantity,
		(sum(quantity) over(partition by product_id, discount))*1.0 / (sum(quantity) over(partition by product_id))
from sale.order_item
order by product_id, discount;

select distinct product_id, discount,
		sum(quantity) over(partition by product_id, discount) sum_of_quantity,
		sum(quantity) over(partition by product_id) total_quantity
into #table_sum
from sale.order_item
order by product_id, discount;

select *
from #table_sum;

select * ,CAST(100.0*sum_of_quantity/total_quantity AS decimal (5,2)) percent_of_quantity
into #table_sum2
from #table_sum
;

select *
from #table_sum2;

select *, 
		FIRST_VALUE(percent_of_quantity) over(partition by product_id order by discount rows between unbounded preceding and unbounded following) min_discount_percent,
		LAST_VALUE(percent_of_quantity) over(partition by product_id order by discount rows between unbounded preceding and unbounded following) max_discount_percent
into #table_sum3
from #table_sum2
;

select *
from #table_sum3;

select *,
		CASE
			WHEN max_discount_percent > min_discount_percent THEN 'Positive'
			WHEN max_discount_percent < min_discount_percent THEN 'Negative'
			ELSE 'neutral'
		END AS Discount_effect
into #table_sum4
from #table_sum3
;

select *
from #table_sum4;

select distinct product_id, Discount_effect
from #table_sum4

select distinct A.product_id, B.Discount_effect
from product.product A
left join #table_sum4 B
on A.product_id = B.product_id
order by 1;

