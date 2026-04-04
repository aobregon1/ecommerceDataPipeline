/* MODEL: Category Profitability Analytics
   PURPOSE: Combines order items, product metadata, and customer reviews 
   to evaluate revenue and satisfaction scores at the category level.
*/

-- Step 1: Pull in core order item data (price, product_id, order_id)
with items as (
    select * from {{ ref('order_items') }}
),

-- Step 2: Enrich with product attributes (category name, photo count)
products as (
    select * from {{ ref('products') }}
),

-- Step 3: Aggregate reviews at the Order level first to avoid fan-out 
-- issues when joining to granular order items later.
reviews as (
    select 
        order_id,
        avg(review_score) as avg_review_score_per_order
    from {{ ref('order_reviews') }}
    group by 1
)

-- Final Selection: Aggregate metrics by Product Category
select
    p.product_category_name,
    
    -- Volume Metrics
    count(distinct i.order_id) as total_orders,
    sum(i.price) as total_revenue,
    
    -- Quality Metrics: Average review score per category
    avg(r.avg_review_score_per_order) as avg_category_review_score,
    
    -- Content Metrics: Correlation between photo count and sales
    avg(p.product_photos_qty) as avg_photos_per_product

from items i
join products p on i.product_id = p.product_id
left join reviews r on i.order_id = r.order_id
group by 1