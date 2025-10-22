USE sql_project_p1;

SET sql_safe_updates = 0;

DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR category IS NULL
   OR total_sale IS NULL;

SET sql_safe_updates = 1;
