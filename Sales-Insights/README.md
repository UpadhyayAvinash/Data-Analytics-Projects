## Sales Insights Data Analysis Project

### Instructions to get the data

1. Get the database dump file from Codebasics repository : https://github.com/codebasics/DataAnalysisProjects/tree/master/1_SalesInsights
1. SQL database dump is in db_dump_version_2.sql file above. Download the file to your local computer.

### About the data
1. The Sales Insights Dashboard was built using the dataset provided by codebasics Youtube channel.
1. It contained the sales data of 2017 to 2020.
1. It Consisted of 1 Fact table and 4 Dimension Tables.
1. The data source was in MySQL Database.
1. There are 3 main KPIs Revenue, sales Quantity and profit margin across various dimensions.

### Data Analysis Using SQL

1. Select the database

    `USE sales`

1. Show all customer records

    `SELECT * FROM customers;`

1. Show total number of customers

    `SELECT count(*) FROM customers;`

1. Show transactions for Chennai market (market code for chennai is Mark001)

    `SELECT * FROM transactions where market_code='Mark001';`

1. Show distrinct product codes that were sold in chennai

    `SELECT distinct product_code FROM transactions where market_code='Mark001';`

1. All transactions where currency is US dollars

    `SELECT * from transactions where currency="USD"`

1. Transactions in 2020 join by date table

    `SELECT t.*, d.* 
FROM transactions t
INNER JOIN date d
ON t.order_date=d.date 
where d.year=2020;`

1. Total revenue in year 2020,

    `SELECT SUM(t.sales_amount) total_revenue
FROM transactions t
INNER JOIN date d
ON t.order_date=d.date 
where d.year=2020 
and t.currency="INR" or t.currency="USD";`
	
1. Total revenue in year 2020, January Month,

    `SELECT SUM(t.sales_amount) total_revenue
FROM transactions t
INNER JOIN date d
ON t.order_date=d.date 
where d.year=2020 and d.month_name="January"
and t.currency="INR" or t.currency="USD";`

1. Total revenue in year 2020 in Chennai

    `SELECT SUM(t.sales_amount) total_rev
FROM transactions t
INNER JOIN date d
ON t.order_date=d.date 
where d.year=2020 
and t.market_code="Mark001";`

1. Different market revenue collection by year
   
   `SELECT d.year,m.markets_name,sum(t.sales_amount) total_rev 
FROM transactions t 
LEFT JOIN date d
ON t.order_date=d.date  
LEFT JOIN markets m
ON t.market_code = m.markets_code
GROUP BY 1,2
ORDER BY 2,1;`

1. Proudct type peformance over the years

   `SELECT d.year,p.product_type,sum(t.sales_amount) total_rev 
FROM transactions t 
LEFT JOIN date d
ON t.order_date=d.date  
LEFT JOIN products p
ON t.product_code = p.product_code
WHERE p.product_code IS NOT NULL
GROUP BY 1,2
ORDER BY 2,1;`


Data Analysis Using Power BI
============================

1. Formula to create norm_sales_amount column

`= Table.AddColumn(sales_transactions, "norm_sales_amount", each if [currency] = "USD" then [sales_amount]*83 else [sales_amount])`


Insights
============================

1. Surat is the most profitable city leading by 4.86%.
2. Begaluru market is making the most of the loss with customer Flawless Stores contributing the most. 
3. Delhi contributes most to the company's Revenue and profit.
4. Revenue is declining based on YoY trend.


Dashboard link
============================

https://www.novypro.com/project/sales-insights-dashboard-10
