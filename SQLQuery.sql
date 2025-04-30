select * from [dbo].[customer_orders]
select * from [dbo].[payments]


--1. Order and Sales Analysis
--Order Status and Sales Metrics:
--This query aggregates the total count of orders, total sales, and average order value by each order status.
SELECT   
    order_status,   
    COUNT(*) AS num_orders,   
    SUM(order_amount) AS total_sales,   
    AVG(order_amount) AS average_order_value  
FROM customer_orders  
GROUP BY order_status;  

--Monthly Sales Trend:
--This query extracts the month from the order date and groups the data to calculate monthly total sales and the number of orders.
SELECT   
    DATEADD(MONTH, DATEDIFF(MONTH, 0, order_date), 0) AS month,  
    SUM(order_amount) AS total_sales,   
    COUNT(*) AS num_orders  
FROM customer_orders  
GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, order_date), 0)  
ORDER BY month;


--2. Customer Analysis
--Repeat Ordering & Segmentation:
--This query counts orders per customer and shows their first order date, which helps identify repeat buyers and segment customers based on order frequency.
SELECT   
    customer_id,   
    COUNT(*) AS order_count,   
    MIN(order_date) AS first_order_date  
FROM customer_orders  
GROUP BY customer_id  
ORDER BY order_count DESC;

--Ordering Trends Over Time (Per Customer):
--This query shows how many orders each customer makes per month.
 SELECT 
    customer_id,
    DATEADD(MONTH, DATEDIFF(MONTH, 0, order_date), 0) AS month,
    COUNT(*) AS num_orders
FROM customer_orders
GROUP BY customer_id, DATEADD(MONTH, DATEDIFF(MONTH, 0, order_date), 0)
ORDER BY customer_id, month;


--3. Payment Status Analysis
--Payment Success/Failure Trends:
--This query aggregates payment data to count payment statuses and sum associated amounts—helpful for spotting issues in payment processing.
SELECT   
    payment_status,   
    COUNT(*) AS count,  
    SUM(payment_amount) AS total_amount  
FROM payments  
GROUP BY payment_status;  

--4. Order Details Report
--Detailed Overview of Orders and Payments:
--This join query combines order and payment details to provide a comprehensive report that includes key metrics.
SELECT   
    o.order_id,  
    o.customer_id,  
    o.order_date,  
    o.order_amount,  
    o.order_status,  
    p.payment_date,  
    p.payment_amount,  
    p.payment_status  
FROM customer_orders o  
LEFT JOIN payments p ON o.order_id = p.order_id  
ORDER BY o.order_date;  
