-- 1) data exploration
        /*how many sales we have */
select count(*) as total_sale from retail_sales ;
		
        /* how many uniques cutomers*/
select count(distinct customer_id) as total_sales from retail_sales;

		    /* how many categories */
select distinct category as categories_table from retail_sales;

--2) data analysis & business key problems & answers */
		    /* all colomns for sales made on 2022-11-05*/
select * from retail_sales where sale_date ='2022-11-05';
		
        /* all transactions where category is clothing , and the quantity is more than in the month of 2022-11*/  
select * from retail_sales where category='clothing' and date_format(sale_date, "%Y-%m")="2022-11" and quantity >= 4;
    
		    /* total sales for each category*/
select category ,
   sum(total_sale) as total_orders,
   count(*) as net_sale 
   from retail_sales group by 1;
 
	    	/* the average age of customers who purchased items from the beauty category */
select category,round( avg(age),2) from retail_sales where category='Beauty';

		    /* all the transactions where the total sale is greater than 1000*/
select  * from retail_sales where total_sale > 1000;

		    /* total number of transactions made by each gender in each category */
select category, gender , 
count(transactions_id) as total_number_of_transactions 
from retail_sales 
group by category , gender; 

    		/* the average sale for each month , find out best selling month for each year*/
WITH monthly AS (
  SELECT
    EXTRACT(YEAR  FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_month_sale
  FROM retail_sales
  GROUP BY 1,2
),
ranked as(
SELECT
  year,
  month, 
  avg_month_sale,
RANK() OVER (PARTITION BY year ORDER BY avg_month_sale DESC) AS rank_in_year
FROM monthly)
select year , month , avg_month_sale 
from ranked
where rank_in_year=1;

	    	/*find the top 5 customers based on the highest total sales */
select customer_id,
sum(total_sale) as total_sales_per_customer
from retail_sales 
group by 1 
order by sum(total_sale) Desc  
limit 5;

	    	/*the number of unique customers who purchased items from each category*/
with hourly as (select *,
	case 
		when hour(sale_time) <12 then 'morning'
		when hour(sale_time) between 12 and 17 then 'afternoon'
        else 'evening'
	end as shift
    from retail_sales) 
    select shift , count(*) as total_orders from hourly
    group by shift;
