select*from fact

--display the number of states present in location table
select count(state) from [dbo].[Location]

--how many products are regular type
select count([Product]) as regularproduct
from [dbo].[Product]
where [Type] = 'regular'

--how much spending has been done on marketing of product id
SELECT SUM(total_expenses) AS total_spending
FROM [dbo].[fact]
WHERE productid = 1;

--min sales of a product
SELECT MIN(sales) AS min_sales
FROM [dbo].[fact]

--max cost of cogs
select max(cogs) 
from fact

--details of the product where product type is coffee
select*from product
where product_type = 'coffee'

--total expenses are greater than 40
select * from fact
where total_expenses >40

--AVG SALES IN AREA CODE 719
select avg(sales) as avg_sales_by_area from fact
where area_code ='719'


--TOTAL PROFIT GENERATED BY COLORADO STATE
select
f.area_code,
f.profit,
l.state
from fact as F
left join location as L on f.area_code =L.area_code
where state ='colorado'


--AVG INVENTORY FOR EACH PRODUCT ID
select productid, avg(inventory) from fact
group by productid


--STATE IN SEQUENTIAL ORDER IN LOCATION TABLE
SELECT DISTINCT state
FROM Location
ORDER BY state;


--average budget of the Product where the average budget margin should be greater than 100
SELECT
  AVG(budget_margin) AS average_budget
FROM
  fact
GROUP BY
  productid
HAVING
  AVG(budget_margin) > 100;

   --TOTAL SALES DONE ONE DATE 2010-01-01
SELECT
  SUM(sales) AS total_sales
FROM
  fact
WHERE date = '2010-01-01';

select*from fact


--AVG TOTAL EXPENSES OF EACH PRODUCT ID ON AN INDIVIDUAL DATE
select
[Date],
productid,
avg(total_expenses) as avg_exp 
from fact
group by productid, [Date]
order by ProductId

--Displaying the attributes such as date, productID, product_type, product, sale
select
P.PRODUCT,
P.PRODUCTID,
P.PRODUCT_TYPE,
F.SALES,
F.PROFIT,
L.STATE,
L.AREA_CODE
from [dbo].[Product] as P
left join fact as F ON F.PRODUCTID= P.PRODUCTID
LEFT JOIN LOCATION AS L ON L.AREA_CODE =F.AREA_CODE


SELECT*FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME ='PRODUCT'

--rank wihtout any gap to show the sales wise rank
SELECT
  productid,
  sales,
  DENSE_RANK() OVER (ORDER BY sales DESC) AS sales_rank
FROM
  FACT;

  --state wise profit and sales
 SELECT
 L.STATE,
 F.PROFIT,
 F.SALES
 FROM LOCATION AS l
 LEFT JOIN FACT AS F ON L.AREA_CODE =F.AREA_CODE
 ORDER BY SALES


 --state wise profit and sales along with product name
 SELECT
 L.STATE,
 F.PROFIT,
 F.SALES,
 P.PRODUCT
 FROM LOCATION AS l
 LEFT JOIN FACT AS F ON L.AREA_CODE =F.AREA_CODE
 LEFT JOIN PRODUCT AS P ON P.PRODUCTID =F.PRODUCTID
 ORDER BY SALES


 --calculate the increase sale
 SELECT
  productid,
  sales * 1.05 AS increased_sales
FROM
  FACT;


  --max profit along with the productid and product type
SELECT 
P.PRODUCTID,
P.PRODUCT_TYPE,
F.max(PROFIT) as max_profit
FROM PRODUCT AS P
LEFT JOIN FACT AS F ON P.PRODUCTID =F.PRODUCTID

--stored procedure to fetch the result according to the product type
CREATE PROCEDURE GetProductsByType
  @ProductType NVARCHAR(255)
AS
BEGIN
  SELECT *
  FROM Product
  WHERE product_type = @ProductType;
END;


exec GetProductsByType @producttype ='coffee'


--write a query by creating a condition in which if the total expenses is less than 60 then it is a profit or else loss.
SELECT
  CASE
    WHEN total_expenses < 60 THEN 'Profit'
    ELSE 'Loss'
  END AS financial_status
FROM
  fact;


 --give the total weekly sales value with the date and product ID details. Use roll-up to pull the data in hierarchical order.
  select*from fact
  SELECT
  CASE
    WHEN GROUPING(date) = 1 THEN 'Total'
    ELSE CONVERT(VARCHAR(10), date, 120) -- Format the date as needed
  END AS orderdate,
  CASE
    WHEN GROUPING(productid) = 1 THEN 'All Products'
    ELSE CAST(productid AS VARCHAR(10))
  END AS product_id,
  SUM(sales) AS total_sales
FROM
  fact
GROUP BY
  ROLLUP(date, productid);


--apply union and intersection operator on the tables which consist of attribute area code.
SELECT area_code FROM fact
UNION
SELECT area_code FROM location


SELECT area_code FROM fact
INTERSECT
SELECT area_code FROM Location

--Display the date, product ID and sales where total expenses are between 100 to 200
SELECT
  date,
  productid,
  sales,
  Total_Expenses
FROM
  fact
WHERE
  total_expenses BETWEEN 100 AND 200;

  --Change the product type from coffee to tea where product ID is 1 and undo it. 
 update product set Product_type ='tea' where ProductId =1


 --Delete the records in the Product Table for regular
delete from [dbo].[Product] where Type ='regular'


--Display the ASCII value of the fifth character from the column product
SELECT ASCII(SUBSTRING(Product, 5, 1)) AS ascii_value
FROM Product


--Creating a user-defined function to fetch products based on product type
CREATE FUNCTION ProductsByType1
(
    @ProductType NVARCHAR(50)  -- Parameter to specify the product type
)
RETURNS TABLE
AS
RETURN
(
    SELECT ProductID, Product, Type
    FROM Product
    WHERE Product_Type = @ProductType
);

-- Using the user-defined function to fetch products of a specific type
SELECT * FROM dbo.ProductsByType1('coffee');
