# Data-Analysis-Project-Using-MySQL

-- Product and Sales Performance, Inventory Management Analysis Project Using MySQL.

CREATE DATABASE bens;

USE bens;

-- Database Structure

CREATE DATABASE bens;

CREATE TABLE dim_customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(20),
    marital_status VARCHAR(25),
    email VARCHAR(100),
    country VARCHAR(50),
    join_date DATE,
    birth_date DATE
);

CREATE TABLE dim_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2),
    cost DECIMAL(10,2),
    stock INT
);

CREATE TABLE fact_sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

      -- QUERY OPTIMIZATION THROUGH INDEXES
                         
-- Customer_id, Product_id and Sale_id are already indexed as PRIMARY KEYs
CREATE INDEX idx_customers_country ON bens.dim_customers (country);
CREATE INDEX idx_product_category ON bens.dim_products (category);
CREATE INDEX idx_product_stock ON bens.dim_products (stock);
CREATE INDEX idx_fact_sales_order_date ON bens.fact_sales (order_date);

    
-- A. STOCK INVENTORY MANAGEMENT: Focuses on managing and analyzing inventory levels to optimize stock and prevent shortages or overstocking.

-- 1. Which products have zero stock / are at risk of stockout /normal stock / are overstocked ?
-- Helps identify products needing restocking to prevent stockouts and optimize inventory levels, while reducing excess inventory to lower holding costs and free up storage space.

SELECT 
    product_id,
    product_name,
    category,
    stock,
    CASE
        WHEN stock = 0 THEN 'Out_Of_Stock'
        WHEN stock BETWEEN 0 AND 200 THEN 'At Risk'
        WHEN stock BETWEEN 200 AND 500 THEN 'Normal'
        WHEN stock > 500 THEN 'Overstocked'
        ELSE 'Ouffff'
    END AS Stock_Inventory_Segmentation
FROM
    bens.dim_products
; 
    
-- 2. What is the stock value of each category?
-- Provides insight into the financial value of inventory per category for better budgeting and investment decisions.

SELECT 
    category, ROUND(SUM(price * stock), 2) AS StockValue
FROM
    bens.dim_products 
GROUP BY category
ORDER BY StockValue DESC;

-- 3. Predict stock depletion based on average daily sales?
-- Allows planning for restocking to prevent shortages and ensure continuous product availability.

WITH Avg_Daily_Sales AS (
    SELECT 
        p.product_id,	
        p.product_name,
        p.stock,
        SUM(fs.quantity) * 1.0 / 
            NULLIF(
                DATEDIFF(
                    MAX(fs.order_date), 
                    MIN(fs.order_date)
                ) + 1, 
                0
            ) AS Avg_Daily_Qty
    FROM 
        bens.fact_sales fs
        LEFT JOIN bens.dim_products p ON fs.product_id = p.product_id
    GROUP BY 
        p.product_id,
        p.product_name,
        p.stock
    HAVING 
        SUM(fs.quantity) > 0 
)
SELECT 
    product_id,
    product_name,
    stock,
    ROUND(stock / Avg_Daily_Qty, 0) AS Days_Until_Depletion
FROM 
    Avg_Daily_Sales
WHERE 
    stock > 0
    AND Avg_Daily_Qty > 0  -- Extra safety
ORDER BY 
    Days_Until_Depletion DESC;
    

 -- B. PRODUCT PERFORMANCE: Analyzes product sales, profitability, and market trends to guide product strategy.

-- 4. Which products are the top 5 sellers by quantity?
-- Highlights popular products to ensure adequate stock and promote high-demand items.
 
SELECT 
    p.product_id,
    p.product_name,
    SUM(fs.quantity) AS Total_Quantity
FROM
    bens.fact_sales fs
        LEFT JOIN
    bens.dim_products p ON fs.product_id = p.product_id
GROUP BY p.product_id , p.product_name
ORDER BY Total_Quantity DESC
LIMIT 5;

-- 5. What is the average order value by category?
-- Informs pricing and promotion strategies to boost profitability per category.
 
SELECT 
    p.category AS Product_Category,
    ROUND(AVG(p.price * fs.quantity), 2) AS Avg_Order_Value
FROM
    bens.fact_sales fs
        LEFT JOIN
    bens.dim_products p ON fs.product_id = p.product_id
GROUP BY Product_Category
ORDER BY Avg_Order_Value DESC;

-- 6. Which products contribute to 80% of total sales (Pareto analysis)?
-- Focuses efforts on the most impactful products to optimize sales and efficiency.

WITH Product_Sales AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(p.price * fs.quantity) AS Sales_Amount,
        SUM(SUM(p.price * fs.quantity)) OVER () AS Total_Sales,
        SUM(SUM(p.price * fs.quantity)) OVER (ORDER BY SUM(p.price * fs.quantity) DESC) / 
            SUM(SUM(p.price * fs.quantity)) OVER () AS Cum_Share
    FROM 
        bens.fact_sales fs
        LEFT JOIN bens.dim_products p ON fs.product_id = p.product_id
    GROUP BY 
        p.product_id,
        p.product_name
)
SELECT 
    product_id,
    product_name,
    Sales_Amount
FROM 
    Product_Sales
WHERE 
    Cum_Share <= 0.8
ORDER BY 
    Sales_Amount DESC;

-- 7. What is the total sales, total cost, quantity sold, profit and profit margin by product category?
--  Helps assess category profitability to guide pricing and cost management decisions.

WITH Product_Sales AS (
    SELECT 
        p.category,
        SUM(p.price * fs.quantity) AS Sales_Amount,
        SUM(fs.quantity) AS Quantity_Sold,
        SUM(fs.quantity * p.cost) AS Cost_Amount
    FROM 
        bens.fact_sales fs
        LEFT JOIN bens.dim_products p ON fs.product_id = p.product_id
    GROUP BY 
       p.category
)
SELECT 
    category,
    Sales_Amount,
    Quantity_Sold,
    Cost_Amount,
    ROUND((Sales_Amount - Cost_Amount),2) AS Profit,
    ROUND((Sales_Amount - Cost_Amount) / Sales_Amount, 2) AS Profit_Margin
FROM 
    Product_Sales;
    
-- 8. Which products have the highest profit margin?
--  Prioritizes high-margin products to maximize profit and resource allocation.

WITH Product_Sales AS (
    SELECT 
        p.product_id,
        p.product_name,
        SUM(p.price * fs.quantity) AS Sales_Amount,
        SUM(fs.quantity * p.cost) AS Cost_Amount
    FROM 
        bens.fact_sales fs
        LEFT JOIN bens.dim_products p ON fs.product_id = p.product_id
    GROUP BY 
       p.product_id,
       p.product_name
)
SELECT 
    product_id,
	product_name,
    Sales_Amount,
    Cost_Amount,
    ROUND((Sales_Amount - Cost_Amount),2) AS Profit,
    ROUND((Sales_Amount - Cost_Amount) / Sales_Amount, 2) AS Profit_Margin
FROM 
    Product_Sales
ORDER BY 6 DESC;


-- 9. Which customers have not made any purchases/ inactive customers?
--  Targets inactive customers with re-engagement campaigns to boost sales.

SELECT 
    *
FROM
    bens.dim_customers
WHERE
    customer_id NOT IN (SELECT 
            customer_id
        FROM
            bens.fact_sales);

            
   -- D. REVENUE ANALYSIS : Examines overall sales performance, trends, and growth.

-- 10. What is the total sales amount by country?
-- Reveals geographic sales performance to tailor marketing and expansion strategies.

SELECT 
    c.country, SUM(fs.quantity * p.price) AS Total_Sales
FROM
    bens.dim_customers c
        JOIN
    bens.fact_sales fs ON fs.customer_id = c.customer_id
        JOIN
    bens.dim_products p ON fs.product_id = p.product_id
GROUP BY c.country
ORDER BY 2 DESC;

-- 11. What is the total sales by month and the month-over-month sales growth rate?
--  Monitors sales growth to identify trends and inform strategic business adjustments.

WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(fs.order_date, '%Y-%m') AS Sales_Month,
        ROUND(SUM(fs.quantity * p.price), 2) AS Monthly_Sales
    FROM 
        bens.fact_sales fs
        JOIN bens.dim_products p ON fs.product_id = p.product_id
    WHERE 
        fs.order_date IS NOT NULL
    GROUP BY 
        DATE_FORMAT(fs.order_date, '%Y-%m')
)
SELECT 
    Sales_Month,
    Monthly_Sales,
    ROUND(((Monthly_Sales - LAG(Monthly_Sales) OVER (ORDER BY Sales_Month)) / 
           LAG(Monthly_Sales) OVER (ORDER BY Sales_Month) * 100), 2) AS Growth_Rate_Percent
FROM 
    MonthlySales
ORDER BY 
    Sales_Month;


