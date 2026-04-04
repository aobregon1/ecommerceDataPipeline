with customer_stats as (
    -- Get unique customer count per zip
    select 
        customer_zip_code_prefix as zip_prefix,
        count(distinct customer_unique_id) as total_unique_customers
    from {{ ref('customers') }}
    group by 1
),

order_stats as (
    -- Get order volume and revenue per zip
    select 
        c.customer_zip_code_prefix as zip_prefix,
        count(distinct o.order_id) as total_orders,
        sum(p.payment_value) as total_revenue
    from {{ ref('customers') }} c
    join {{ ref('orders') }} o on c.customer_id = o.customer_id
    join {{ ref('order_payments') }} p on o.order_id = p.order_id
    group by 1
)

select
    g.geolocation_zip_code_prefix,
    g.geolocation_city,
    g.geolocation_state,
    coalesce(cs.total_unique_customers, 0) as customer_density,
    coalesce(os.total_orders, 0) as order_volume,
    coalesce(os.total_revenue, 0) as revenue_concentration
from {{ ref('geolocation') }} g
left join customer_stats cs on g.geolocation_zip_code_prefix = cs.zip_prefix
left join order_stats os on g.geolocation_zip_code_prefix = os.zip_prefix
