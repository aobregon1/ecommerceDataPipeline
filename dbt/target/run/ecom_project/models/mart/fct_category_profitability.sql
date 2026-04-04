
  
    

create or replace transient table ECOMMERCE_DATA_PIPELINE.mart.fct_category_profitability
    
    
    
    as (with items as (
    select * from ECOMMERCE_DATA_PIPELINE.stage.order_items
),

products as (
    select * from ECOMMERCE_DATA_PIPELINE.stage.products
),

reviews as (
    select 
        order_id,
        avg(review_score) as avg_review_score_per_order
    from ECOMMERCE_DATA_PIPELINE.stage.order_reviews
    group by 1
)

select
    p.product_category_name,
    count(distinct i.order_id) as total_orders,
    sum(i.price) as total_revenue,
    
    avg(r.avg_review_score_per_order) as avg_category_review_score,
    
    avg(p.product_photos_qty) as avg_photos_per_product

from items i
join products p on i.product_id = p.product_id
left join reviews r on i.order_id = r.order_id
group by 1
    )
;


  