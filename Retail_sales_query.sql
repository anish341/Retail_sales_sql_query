-- What are the raw records in the RETAIL_SALES table?
SELECT * FROM RETAIL_SALES.RETAIL_SALES;

-- What are the first 10 records in the RETAIL_SALES table?
SELECT COUNT(*) FROM RETAIL_SALES.RETAIL_SALES
LIMIT 10;

-- Are there any null values in key columns like transactions_id, SALE_TIME, GENDER, CATEGORY, SALE_DATE, or TOTAL_SALE?
SELECT * FROM RETAIL_SALES.RETAIL_SALES
WHERE 
ï»¿transactions_id IS NULL
OR
SALE_TIME IS NULL 
OR
GENDER IS NULL
OR
CATEGORY IS NULL 
OR 
SALE_DATE IS NULL
OR 
TOTAL_SALE IS NULL;

-- DATA EXPLORATION 

USE RETAIL_SALES;
-- What is the total number of sales recorded?
SELECT COUNT(*) AS TOTAL_SALES FROM RETAIL_SALES;

-- How many unique customers made purchases?
SELECT COUNT( DISTINCT customer_id) AS TOTAL_SALES FROM RETAIL_SALES;

-- How many unique product categories are available?
SELECT  COUNT( DISTINCT CATEGORY) AS TOTAL_SALES FROM RETAIL_SALES;

-- What are the sales details for transactions made on 2022-11-05?
SELECT * FROM RETAIL_SALES.RETAIL_SALES
WHERE SALE_DATE  = '2022-11-05';

-- Which clothing sales had a quantity of 4 or more?
SELECT CATEGORY, QUANTIY, GENDER ,DAY(SALE_DATE),YEAR(SALE_DATE) FROM RETAIL_SALES.RETAIL_SALES
WHERE CATEGORY = 'CLOTHING' AND QUANTIY >= '4'
ORDER BY CATEGORY;

-- What is the net sale and total number of orders for each product category?
SELECT CATEGORY, SUM(TOTAL_SALE) AS NET_SALE, COUNT(*) AS TOTAL_ORDERS
FROM RETAIL_SALES.RETAIL_SALES
GROUP BY CATEGORY;

-- What is the average age of customers purchasing beauty products?
SELECT ROUND(AVG(AGE),3), CATEGORY FROM RETAIL_SALES.RETAIL_SALES
WHERE CATEGORY ='BEAUTY';

-- Which sales had a total value greater than 1000?
SELECT * FROM RETAIL_SALES.RETAIL_SALES
WHERE TOTAL_SALE > 1000;

-- How many transactions were made for each gender within each category?
SELECT CATEGORY, GENDER, COUNT(*) AS TOTAL_TRANS FROM RETAIL_SALES.RETAIL_SALES
GROUP BY CATEGORY,GENDER
ORDER BY 1;

-- What is the monthly average sale and its rank within each month?
SELECT YEAR(TOTAL_SALE) AS `YEAR`,
MONTH(TOTAL_SALE) AS `MONTH`,
AVG(TOTAL_SALE)AS AVG_SALE,
RANK() OVER( PARTITION BY MONTH(TOTAL_SALE) ORDER BY AVG(TOTAL_SALE) ASC ) AS `RANK`
FROM RETAIL_SALES.RETAIL_SALES
GROUP BY 1,2;

-- Which customers generated the highest total sales?
SELECT CUSTOMER_ID, SUM(TOTAL_SALE) AS TOTAL_SALES FROM RETAIL_SALES.RETAIL_SALES
GROUP BY 1
ORDER BY 2 DESC;

-- How many unique customers purchased from each category?
SELECT CATEGORY, COUNT(DISTINCT CUSTOMER_ID) AS UNIQUE_CS
FROM RETAIL_SALES.RETAIL_SALES
GROUP BY CATEGORY;

-- How are sales distributed across different times of the day (morning, afternoon, evening)?
WITH HOURLY_SALE
AS 
(SELECT *, 
CASE 
WHEN EXTRACT(HOUR FROM SALE_TIME) <12 THEN 'MORNING'
WHEN  EXTRACT(HOUR FROM SALE_TIME)BETWEEN 12 AND 17 THEN 'AFTERNOON'
ELSE 'EVENING' 
END AS SIFT 
FROM RETAIL_SALES.RETAIL_SALES) SELECT  SIFT, COUNT(*) AS TOTAL_ORDERS
FROM HOURLY_SALE
GROUP BY SIFT


