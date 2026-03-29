---Data analysis of the first 100 rows

select * from `brightlearncoffeeshop1`.`default`.`bright_coffee_shop_analysis_case_study_1_1` limit 100;



---Counting the different product (80) and different transaction (149116)

SELECT 
     COUNT (DISTINCT transaction_id) AS number_of_transactions,
     COUNT (DISTINCT product_id) AS number_of_products
FROM `brightlearncoffeeshop1`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;



---Analysing the different store locations (There 3 store locations)

SELECT DISTINCT store_location
FROM `brightlearncoffeeshop1`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;




---Analysing the different product types (There 29 Products)

SELECT DISTINCT product_type
FROM `brightlearncoffeeshop1`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;




---Calculation of total amount (Total Rev 698812.33)

SELECT transaction_qty,
       unit_price,
       SUM(transaction_qty*unit_price) AS total_amount
FROM `brightlearncoffeeshop1`.`default`.`bright_coffee_shop_analysis_case_study_1_1`
GROUP BY 
         transaction_qty,
         unit_price;



SELECT 
     SUM(transaction_qty*unit_price) AS total_revenue
FROM `brightlearncoffeeshop1`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;


---Classification of the days of the week

SELECT DAYNAME(transaction_date) AS day_of_week
FROM `brightlearncoffeeshop1`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;


---Classification of the month

SELECT MONTHNAME(transaction_date) AS month_name
FROM `brightlearncoffeeshop1`.`default`.`bright_coffee_shop_analysis_case_study_1_1`;


---code for insights

SELECT

      transaction_id,
      transaction_time,
      transaction_qty,
      store_id,
      store_location,
      product_id,
      unit_price,
      product_category,
      product_type,
      product_detail,
      transaction_date,
      dayname(transaction_date) AS Day_name,
      monthname(transaction_date) AS Month_name,
      date_format(transaction_time, 'HH:mm:ss') AS purchase_time,
      dayofmonth (transaction_date) AS day_of_month,

 
----creating time buckets
CASE

      When date_format(transaction_time, 'HH:mm:ss') between '00:00:00' and '11:59:59' then '01.Morning'
      When date_format(transaction_time, 'HH:mm:ss') between '12:00:00' and '16:59:59' then '02.Afternoon'
      When date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' then '03.Evening'
      End as time_buckets,

 
----creating day classifications
      CASE

      When dayname(transaction_date) IN ('Sun', 'Sat') THEN 'Weekend'
      ELSE 'Weekday'
      End as Day_classification,

----Creating spending buckets
CASE

When (transaction_qty*unit_price) <=20 THEN '01.Low spender'
When (transaction_qty*unit_price) BETWEEN 21 AND 100 THEN '02.Medium spender'
Else '03.High spender'
   End As spending_buckets,

     

      COUNT(Distinct transaction_id) AS number_of_sales,
      COUNT(Distinct product_id) AS number_of_products,
      COUNT(Distinct store_id) AS number_of_stores,


      SUM(transaction_qty*unit_price) AS revenue_per_day

   FROM  `brightlearncoffeeshop1`.`default`.`bright_coffee_shop_analysis_case_study_1_1`


GROUP BY
         Day_name,
         spending_buckets,
         transaction_date, 
         Month_name,
         store_location,
         product_category,
         purchase_time,
         time_buckets,
         day_of_month,
         Day_classification,
         transaction_id,
         transaction_time,
         transaction_qty,
         store_id,
         store_location,
         product_id,
         unit_price,
         product_category,
         product_type,
         product_detail,
         transaction_date,
         product_detail;
