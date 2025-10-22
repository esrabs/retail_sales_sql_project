CREATE DATABASE IF NOT EXISTS sql_project_p1;
USE sql_project_p1;

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    transactions_id   INT PRIMARY KEY,
    sale_date         DATE,
    sale_time         TIME,
    customer_id       INT,
    gender            VARCHAR(25),
    age               INT,
    category          VARCHAR(25),
    quantity          INT,
    price_per_unit    FLOAT,
    cogs              FLOAT,
    total_sale        FLOAT
);
