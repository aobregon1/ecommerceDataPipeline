/* MODEL: Customer Lifetime Value
   PURPOSE: Aggregates order history and payment data to calculate 
   customer loyalty, spending patterns, and retention metrics.
*/

-- Step 1: Base aggregation to find key dates and totals per unique customer
with customer_orders as (
    select
        c.customer_unique_id,
        -- Find the "Birth" and "Last Seen" dates for each customer
        min(o.order_purchase_timestamp) as first_order_date,
        max(o.order_purchase_timestamp) as most_recent_order_date,
        
        -- Frequency: How many distinct orders have they placed?
        count(distinct o.order_id) as total_orders,
        
        -- Monetary: Total spend across all orders
        sum(p.payment_value) as total_lifetime_value
    from ECOMMERCE_DATA_PIPELINE.RAW_stage.customers c
    -- Standard join: only include customers who have actually placed orders
    join ECOMMERCE_DATA_PIPELINE.RAW_stage.orders o on c.customer_id = o.customer_id
    -- Join payments: Note that one order can have multiple payments (e.g., split tender)
    join ECOMMERCE_DATA_PIPELINE.RAW_stage.order_payments p on o.order_id = p.order_id
    group by 1
)

-- Final Selection: Calculate derived metrics for customer segmentation
select
    co.*,
    
    -- Tenure: How long has the customer been "active" (from first to last order)
    datediff('day', first_order_date, most_recent_order_date) as tenure_days,
    
    -- Recency: Days since the last purchase (higher number = potential churn)
    datediff('day', most_recent_order_date, current_timestamp()) as recency_days,
    
    -- AOV (Average Order Value): Revenue efficiency per order
    total_lifetime_value/total_orders as average_order_value

from customer_orders co