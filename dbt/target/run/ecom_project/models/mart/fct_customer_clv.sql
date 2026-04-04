
  
    

create or replace transient table ECOMMERCE_DATA_PIPELINE.mart.fct_customer_clv
    
    
    
    as (with customer_orders as (
    select
        c.customer_unique_id,
        min(o.order_purchase_timestamp) as first_order_date,
        max(o.order_purchase_timestamp) as most_recent_order_date,
        count(distinct o.order_id) as total_orders,
        sum(p.payment_value) as total_lifetime_value
    from ECOMMERCE_DATA_PIPELINE.stage.customers c
    join ECOMMERCE_DATA_PIPELINE.stage.orders o on c.customer_id = o.customer_id
    join ECOMMERCE_DATA_PIPELINE.stage.order_payments p on o.order_id = p.order_id
    group by 1
)

select
    co.*,
    datediff('day', first_order_date, most_recent_order_date) as tenure_days,
    datediff('day', most_recent_order_date, current_timestamp()) as recency_days,
    total_lifetime_value/total_orders as average_order_value
from customer_orders co
    )
;


  