
## Table of Contents
 - [Project Overview](#project-overview)
 - [Results and Findings](#results-and-findings)
 - [Recommendations](#recommendations)
 - [References](#references)

## Project Overview

Many stores lose revenue due to poor inventory visibility and missed sales opportunities. As a Data Analyst at Needpam, I developed this project to deliver actionable insights that answer key business questions. I uncovered inventory health, pinpointing zero-stock and overstocked items, product performance, identifying top-selling categories and underperformers, and sales trends, tracking month-over-month growth and seasonal patterns. These findings enable proactive stock management, prevent stockouts, reduce excess inventory, and drive sustainable revenue growth.



<img width="658" height="552" alt="image" src="https://github.com/user-attachments/assets/7575a9a7-82ab-4bbb-b68b-409508941f60" />



## Data Sources 
The database consists of three main tables: dim_customers, which stores customer details, fact_sales which tracks sales data and dim_products, which holds product information. These dimensions tables (customers and products) are joined to the fact sales table using customer_id and product_id.

## Tools used for this project

- Power Query in Excel : Data Cleaning .
- MySQL : Data Analysis.
- Excel : Visualization with simple stacked column chart, bar, line, doughnut and pie charts.

## Data Cleaning/Preparation
  In the initial data preparation phase, we performed the following task:
   1. Data loading and inspection to correct data errors.
   2. Handling missing values.
   3. Standardizing data formats.
   4. Removing duplicates.
   5. Validating data integrity.

## Exploratory Data Analysis (EDA)
 - Which products are out of stock or overstocked?
 - Which product categories are top seller?
 - What are the peak sales period?


### Results and Findings
 - The inventory reveals that 40% of products are overstocked, 28% maintain normal stock levels, 30% are at risk of stockout, and a mere 2% are out of stock, emphasizing the need for strategic adjustments to optimize stock distribution and prevent potential sales losses.
   
<img width="676" height="394" alt="image" src="https://github.com/user-attachments/assets/57b81efe-1fd2-4d9e-906d-93706e07a0f5" />

   
 - Based on the average daily sales, electronics and books are projected to be out of stock within 100 days, necessitating urgent restocking efforts for these high-demand categories. In contrast, other product categories are expected to last up to five months, allowing for more flexible inventory planning and management.
   
<img width="620" height="435" alt="image" src="https://github.com/user-attachments/assets/c59ba40e-a511-4667-9ae0-aa2fa9b374bc" />


 - 80% of the store's revenue is driven by just 26 products, accounting for 52% of the total product lineup (50 products),
 with 6 standout performers (Move Plus, Bring Pro, Her Lite, Thank Lite, Voice Pro, and Compare Plus) each generating over $1 million.

<img width="658" height="592" alt="image" src="https://github.com/user-attachments/assets/6ee2a49f-74cb-4c81-bdff-d6e3970d0165" />



 - The profit margin across each product category ranges from a solid 29% to 33%, reflecting a healthy and consistent profitability that strengthens the store's financial performance and supports future growth initiatives.
 - The categories of Home Appliances, Sports, and Electronics emerge as top performers, each generating revenue exceeding $5 million, underscoring their  significant contribution to the store's overall financial success and highlighting key areas for strategic focus and investment.
 - The top 10 products boasting an impressive profit margin of approximately 50% are predominantly from the home appliances and sports categories,
 highlighting these segments as key drivers of high profitability and potential areas for targeted expansion.
 - An impressive 86% of customers in the database have made at least one purchase, reflecting an outstanding conversion rate that showcases the store's ability to effectively turn visitors into loyal buyers, but 80% of them are inactive that means they do not make any purchases for more than 90 days.

<img width="581" height="392" alt="image" src="https://github.com/user-attachments/assets/924e7cf7-d4e5-4c9c-8b11-24be21362f39" />


 - The analysis reveals monthly sales fluctuating between $970K and $1.4M, with notable peaks in April 2024 ($1.31M, 26.5% growth vs. previous month) and January 2025. The lowest sales occurred in February 2024 ($973K, -17.7% growth) and February 2025 ($977K, -15% growth), indicating a consistent decline in sales during February, possibly due to a recurring seasonal trend or specific influencing factor that need, further analysis to understand. The trend shows seasonal patterns, with peaks in spring and early winter, and declines mid-year and late winter.


<img width="1446" height="571" alt="image" src="https://github.com/user-attachments/assets/31860345-df9e-4a07-9bbf-9bf433ecb0db" />


## Recommendations
 - Prioritize restocking electronics and books within the next 90 days to avoid stockouts, while optimizing overstocked inventory (40%) by redistributing excess stock to high-demand categories or offering promotions to clear surplus.
 - Focus marketing and inventory investment on the top-performing categories (Home Appliances, Sports, Electronics) and the 6 standout products (Move Plus, Bring Pro, Her Lite, Thank Lite, Voice Pro, Compare Plus), which drive 80% of revenue, to maximize profitability and sales.
 - Develop targeted reactivation campaigns for the 80% of inactive customers (out of the 86% who have purchased) to re-engage them, leveraging their past purchase data to encourage repeat buys and increase overall sales.
 - Introduce strategies to upsell or cross-sell to the 98% of customers spending $0-$10,000, such as bundling high-margin products from Home Appliances and Sports (50% profit margin) to boost average order value.
 - Tailor marketing and product offerings aligning seasonal promotions with peak sales periods (e.g., March and January) to capitalize on growth rates up to 25% and mitigate declines.
 - The healthy profit margin range of 29%-33% across all categories, combined with a 50% margin on top 10 products, indicates an opportunity to explore premium product lines to enhance overall profitability.

  
## References

 - "High Performance MySQL: Proven Strategies for Operating at Scale" by Sylvia Botros and Jeremy Tinley Foreword by Jeremy Cole.
 - "Thinking with Data: How to turn Information into Insights" by Max Shron.
 - "Learning SQL: Generate, Manipulate, and Retrieve Data" by Alan Beaulieu.













