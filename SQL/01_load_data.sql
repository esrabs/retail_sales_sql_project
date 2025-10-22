USE sql_project_p1;

LOAD DATA LOCAL INFILE 'data/Retail_Sales.csv'
INTO TABLE retail_sales
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@transactions_id, @sale_date, @sale_time, @customer_id, @gender,
 @age, @category, @quantity, @price_per_unit, @cogs, @total_sale)
SET
  transactions_id = NULLIF(@transactions_id,''),
  sale_date       = STR_TO_DATE(@sale_date, '%Y-%m-%d'),
  sale_time       = STR_TO_DATE(@sale_time, '%H:%i:%s'),
  customer_id     = NULLIF(@customer_id,''),
  gender          = NULLIF(@gender,''),
  age             = NULLIF(@age,''),
  category        = NULLIF(@category,''),
  quantity        = NULLIF(@quantity,''),
  price_per_unit  = NULLIF(@price_per_unit,''),
  cogs            = NULLIF(@cogs,''),
  total_sale      = NULLIF(@total_sale,'');
