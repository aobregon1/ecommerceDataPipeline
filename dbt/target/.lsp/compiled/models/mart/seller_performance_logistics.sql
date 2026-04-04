with orders as (
    select * from ECOMMERCE_DATA_PIPELINE.RAW_stage.orders
    where order_status = 'delivered'
),

order_items_aggregated as (
    select 
        order_id,
        seller_id,
        sum(price) as order_revenue,
        sum(freight_value) as order_freight
    from ECOMMERCE_DATA_PIPELINE.RAW_stage.order_items
    group by 1, 2
)

select
    oi.seller_id,
    date_trunc('month', o.order_purchase_timestamp) as report_month,
    avg(datediff('day', o.order_purchase_timestamp, o.order_delivered_customer_date)) as avg_lead_time,
    avg(datediff('day', o.order_delivered_customer_date, o.order_estimated_delivery_date)) as avg_wait_time_variance,
    sum(oi.order_freight) / nullif(sum(oi.order_revenue), 0) as freight_ratio

from orders o
inner join order_items_aggregated oi on o.order_id = oi.order_id
group by 1, 2