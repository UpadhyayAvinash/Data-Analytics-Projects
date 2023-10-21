## Pizza Sales Data Analytics Project

## Instructions to get the data

1. Get the database dump file from Data Tutorials repository : https://drive.google.com/drive/folders/1LYGqqerI7YuG9_Y0RXj9qUMVZ8JHzqW9
1. SQL database dump is in pizza_sales.csv file above. Download the file to your local computer.

## About the data
1. The Pizza Sales Dashboard was built using the dataset provided by Data Tutorials Youtube channel.
1. It contains sales data of Pizza for year 2015.
1. It consists of 1 Fact table.
1. The data was ingested into MS SQL server and was used as source for dashboard.
1. There are 3 main KPIs Revenue, Quantity sold and total number of orders across various dimensions.

## Data Analysis Using SQL

### A. KPI’s

1. Total Revenue:
   
`SELECT SUM(total_price) AS Total_Revenue 
FROM [pizzaDB].[dbo].[pizza_sales];`
 
1. Average Order Value
   
`SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM [pizzaDB].[dbo].[pizza_sales]`
 
1. Total Pizzas Sold
   
`SELECT SUM(quantity) AS Total_pizza_sold 
FROM [pizzaDB].[dbo].[pizza_sales]`
 
1. Total Orders
   
`SELECT COUNT(DISTINCT order_id) AS Total_Orders 
FROM [pizzaDB].[dbo].[pizza_sales]`
 
1. Average Pizzas Per Order
   
`SELECT CAST(SUM(quantity)*1.0 --multiply with 1.0 to covert int data to float
/COUNT(DISTINCT order_id) AS DECIMAL(10,2))
AS Avg_Pizzas_per_order
FROM [pizzaDB].[dbo].[pizza_sales];`

### B. Hourly Trend for Total Pizzas Sold
`SELECT DATEPART(HOUR, order_time) as order_hours, SUM(quantity) as total_pizzas_sold
FROM [pizzaDB].[dbo].[pizza_sales]
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)`

### C. Weekly Trend for Orders
`SELECT 
    DATEPART(ISO_WEEK, order_date) AS WeekNumber,
    YEAR(order_date) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
    pizza_sales
GROUP BY 
    DATEPART(ISO_WEEK, order_date),
    YEAR(order_date)
ORDER BY 
    Year, WeekNumber;`

### D. % of Sales by Pizza Category
`SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) 
FROM [pizzaDB].[dbo].[pizza_sales]) AS DECIMAL(10,2)) AS PCT
FROM [pizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_category`

### E. % of Sales by Pizza Size
`SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM [pizzaDB].[dbo].[pizza_sales]) AS DECIMAL(10,2)) AS PCT
FROM [pizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_size
ORDER BY pizza_size`

### F. Total Pizzas Sold by Pizza Category
`SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
FROM [pizzaDB].[dbo].[pizza_sales]
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC`

### G. Top 5 Pizzas by Revenue
`SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM [pizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY Total_Revenue DESC`
 
### H. Bottom 5 Pizzas by Revenue
`SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM [pizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY Total_Revenue ASC`
 
### I. Top 5 Pizzas by Quantity
`SELECT Top 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM [pizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC`

### J. Bottom 5 Pizzas by Quantity
`SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM [pizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC`

### K. Top 5 Pizzas by Total Orders
`SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM [pizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY Total_Orders DESC`
 
### L. Borrom 5 Pizzas by Total Orders
`SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM [pizzaDB].[dbo].[pizza_sales]
GROUP BY pizza_name
ORDER BY Total_Orders ASC`
 
### NOTE
If you want to apply the pizza_category or pizza_size filters to the above queries you can use WHERE clause. Follow some of below examples
`SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM [pizzaDB].[dbo].[pizza_sales]
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders ASC`

Insights
============================

1. Peak hours are between 12PM to 1PM and in evening 5PM to 7PM.
2. Significant variations in the weekly orders, with highest peak during the 48th week from the month of dec.
3. Classis Catgeory contributes to highest sales, total orders and total pizza sold.
4. Large pizza size contributes to maximum total sales.
5. Thai Chicken pizza contributes to maximum revenue.
6. The Classic Deluxe pizza contributes to maximum pizzas sold.
7. The Classic Deluxe pizza contributes to maximum pizzas orders.
8. The Brie Carre pizza contributes to minimum revenue, pizzas sold and pizzas orders.

Tableau Dashboard link
============================

https://public.tableau.com/views/pizzasalesdashboard_16978746123690/Home?:language=en-US&:display_count=n&:origin=viz_share_link
