use sql_project_p1;
drop table  if exists retail_sales;
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

create table retail_sales
(
	transactions_id INT primary key,
	sale_date DATE ,	
    sale_time	TIME,
    customer_id INT,
	gender VARCHAR(25),
	age INT,
	category VARCHAR(25),
    quantity INT,
	price_per_unit FLOAT,
	cogs FLOAT,
    total_sale FLOAT
    
);
truncate retail_sales;
load data local infile 'C:\\Users\\USER\\Desktop\\ING1\\alternance\\sql\\premier projet\\SQL - Retail Sales Analysis_utf .csv'
into table retail_sales 
fields terminated by ';'
ignore 1 lines 
( @transactions_id,	@sale_date,	@sale_time,	@customer_id,	@gender,	
@age,	@category,	@quantity, @price_per_unit,	@cogs,	@total_sale)

set
	transactions_id=NULLIF(@transactions_id,""),
	sale_date=NULLIF(@sale_date,''),
    sale_time=NULLIF(@sale_time,''),	
    customer_id=NULLIF(@customer_id,''),
	gender=NULLIF(@gender,''),
	age=NULLIF(@age,''),
	category=NULLIF(@category,''),
	quantity=NULLIF(@quantity,''),
	price_per_unit=NULLIF(@price_per_unit,''),
	cogs=NULLIF(@cogs,''),	
    total_sale=NULLIF(@total_sale,'');
    
select * from retail_sales ;
/* data cleaning */
select * from retail_sales 

    where
			transactions_id is NULL
            OR
            sale_date IS NULL
            OR 
            sale_time IS NULL
            OR
            gender IS NULL
            OR
            category IS NULL
            OR
            quantity is null
            OR
            cogs IS NULL
            or	
            total_sale IS NULL;
            
set sql_safe_updates=0;

delete from retail_sales 

    where
			transactions_id is NULL
            OR
            sale_date IS NULL
            OR 
            sale_time IS NULL
            OR
            gender IS NULL
            OR
            category IS NULL
            OR
            quantity is null
            OR
            cogs IS NULL
            or	
            total_sale IS NULL;
set sql_safe_updates=1;


/* data exploration */
		/*how many sales we have */

select count(*) as total_sale from retail_sales ;
		
        /* how many uniques cutomers*/
select count(distinct customer_id) as total_sales from retail_sales;

		/* how many categories */
select distinct category as categories_table from retail_sales;

/* data analysis & business key problems & answers */
		/* all colomns for sales made on 2022-11-05*/
select * from retail_sales where sale_date ='2022-11-05';
		/* all transactions where category is clothing , and the quantity is more than in the month of 2022-11*/  
select category, sum(quantity) from retail_sales where category='clothing';
select * from retail_sales where category='clothing' and date_format(sale_date, "%Y-%m")="2022-11";
select * from retail_sales where category='clothing' and date_format(sale_date, "%Y-%m")="2022-11" and quantity >= 4;
		/* total sales for each category*/
select category ,
 sum(total_sale) as total_orders,
 count(*) as net_sale 
 from retail_sales group by 1;
 
		/* the average age of customers who purchased items from the beauty category */
select category,round( avg(age),2) from retail_sales where category='Beauty';

		/* all the transactions where the total sale is greater than 1000*/
select * from retail_sales ;
select  * from retail_sales where total_sale > 1000;

		/* total number of transactions made by each gender in each category */
select category, gender , 
count(transactions_id) as total_number_of_transactions 
from retail_sales 
group by category , gender; 

select category, gender , 
count(*) as total_number_of_transactions 
from retail_sales 
group by category , gender 
order by 1;

		/* the average sale for each month , find out best selling month for each year*/
select * from retail_sales;
select extract(year from sale_date)as year,
	extract(month from sale_date)as month,
	avg(total_sale) as the_average_sale_for_each_month,
    rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc )
	from retail_sales group by 1,2;
/*order by 1  ,3 desc;*/

WITH monthly AS (
  SELECT
    EXTRACT(YEAR  FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_month_sale
  FROM retail_sales
  GROUP BY 1,2
)
-- Étape 2 : classer les mois à l’intérieur de chaque année
SELECT
  year,
  month,
  avg_month_sale AS the_average_sale_for_each_month,
  RANK() OVER (PARTITION BY year ORDER BY avg_month_sale DESC) AS rank_in_year
FROM monthly
ORDER BY year DESC, rank_in_year ASC;




    




