USE sql_project_p1;

/* ========= 2) Data exploration ========= */       
		/*how many sales we have */
select count(*) as total_sale from retail_sales ;
		
        /* how many uniques cutomers*/
select count(distinct customer_id) as total_sales from retail_sales;

		    /* how many categories */
select distinct category as categories_table from retail_sales;

USE sql_project_p1;

/* ========= 2) Data analysis & business key problems & answers ========= */

/* (A) Toutes les colonnes pour les ventes du 2022-11-05 */
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

/* (B) Toutes les transactions où la catégorie est 'Clothing'
       ET quantité >= 4 pendant le mois 2022-11 */
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantity >= 4;

/* (C) Total des ventes et nombre de transactions par catégorie */
SELECT
  category,
  SUM(total_sale) AS total_sales,      -- chiffre d'affaires par catégorie
  COUNT(*)        AS transactions
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

/* (D) Âge moyen des clients pour la catégorie 'Beauty' */
SELECT
  ROUND(AVG(age), 2) AS avg_age_beauty
FROM retail_sales
WHERE category = 'Beauty';

/* (E) Toutes les transactions où le total de vente > 1000 */
SELECT *
FROM retail_sales
WHERE total_sale > 1000
ORDER BY total_sale DESC;

/* (F) Nombre de transactions par (catégorie, genre) */
SELECT
  category,
  gender,
  COUNT(transactions_id) AS total_number_of_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY category, gender;

/* (G) Mois moyen de vente + meilleur mois (rank = 1) pour chaque année */
WITH monthly AS (
  SELECT
    EXTRACT(YEAR  FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale)               AS avg_month_sale
  FROM retail_sales
  GROUP BY year, month
),
ranked AS (
  SELECT
    year,
    month,
    avg_month_sale,
    RANK() OVER (PARTITION BY year ORDER BY avg_month_sale DESC) AS rank_in_year
  FROM monthly
)
SELECT year, month, avg_month_sale
FROM ranked
WHERE rank_in_year = 1
ORDER BY year DESC;

/* (H) Top 5 clients par chiffre d’affaires total */
SELECT
  customer_id,
  SUM(total_sale) AS total_sales_per_customer
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales_per_customer DESC
LIMIT 5;

/* (I) Nombre de clients uniques par catégorie (ajouté car ton intitulé le suggérait) */
SELECT
  category,
  COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category
ORDER BY unique_customers DESC;

/* (J) Répartition des commandes par tranche horaire (shift) */
SELECT
  CASE
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift
ORDER BY FIELD(shift,'Morning','Afternoon','Evening');
