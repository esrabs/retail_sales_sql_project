#  Retail Sales Analysis – SQL Project (MySQL 8)

###  Objective  
This project showcases a complete SQL-based analysis of a retail sales dataset.  
The goal is to **import, clean, and explore** sales data to answer key *business questions*  
related to product categories, customer behavior, and sales performance.

---

##  Project Structure
retail_sales_sql_project/
├─ data/
│ └─ retail_sales.csv
├─ docs/
│ ├─ er_diagram.png
│ └─ screenshots/
└─ SQL/
├─ 00_schema.sql
├─ 01_load_data.sql
├─ 02_data_cleaning.sql
├─ 03_data_exploration.sql
└─ 04_analysis.sql



##  How to Run

### 1️ Setup
- Open **MySQL Workbench** and connect to your local MySQL server.  
- Enable CSV import:  
  > Edit → Preferences → SQL Editor →  Enable “LOAD DATA LOCAL INFILE”.

### 2️ Execution Steps
1. Run `SQL/00_schema.sql` → creates the database and table  
2. Run `SQL/01_load_data.sql` → loads the CSV file into MySQL  
3. Run `SQL/02_data_cleaning.sql` → removes incomplete or invalid rows  
4. Run `SQL/03_data_exploration.sql` → explores data distributions and key metrics  
5. Run `SQL/04_analysis.sql` → answers business questions and calculates KPIs  

---

##  Dataset

- **File:** `data/retail_sales.csv` (~2,000 rows)  
- **Columns:**  
  `transactions_id`, `sale_date`, `sale_time`, `customer_id`, `gender`, `age`,  
  `category`, `quantity`, `price_per_unit`, `cogs`, `total_sale`  
- **Encoding:** UTF-8  
- **Delimiter:** `;`  
- **Source:** Educational dataset used for SQL data analysis practice  

---

##  Business Questions & Insights

| # | Business Question | Description |
|---|--------------------|-------------|
| 1 | Sales made on `2022-11-05` | Filter transactions by specific date |
| 2 | Clothing items sold in Nov-2022 (quantity ≥ 4) | Filter + `DATE_FORMAT()` |
| 3 | Total sales by category | `SUM(total_sale)` + `GROUP BY category` |
| 4 | Average age of customers in *Beauty* category | `AVG(age)` |
| 5 | Transactions with total sale > 1000 | Identify high-value orders |
| 6 | Transactions count by gender per category | `GROUP BY category, gender` |
| 7 | Best-selling month each year | CTE + `RANK()` window function |
| 8 | Top 5 customers by total sales | `ORDER BY SUM(total_sale)` |
| 9 | Orders by time of day (Morning/Afternoon/Evening) | `CASE WHEN HOUR(sale_time)` |

---

##  Skills Demonstrated

- Database creation and management with **MySQL 8**  
- Importing CSV files using `LOAD DATA LOCAL INFILE`  
- Data cleaning and validation  
- Aggregations and analytical SQL (`SUM`, `AVG`, `COUNT`)  
- Time-based analysis (`DATE_FORMAT`, `EXTRACT`, `HOUR`)  
- Window functions (`RANK() OVER`)  
- Answering real-world business questions through SQL logic  
- Clear, modular project organization  

---

##  Key Findings *(example — replace with your real results)*

-  Top-performing category: **Electronics**  
-  Best sales month: **December 2022**  
-  Average customer age (Beauty): **32.5 years**  
-  Average order value: **≈ €250**


##  Author

**Esrae Ben Selma**  
Engineering student at **EIL Côte d’Opale (France)** – Computer Science major  
 Seeking an **apprenticeship/internship** in **Data / AI** (SQL, BI, Python)  
 [LinkedIn](https://www.linkedin.com/) · [GitHub](https://github.com/esrabs)

