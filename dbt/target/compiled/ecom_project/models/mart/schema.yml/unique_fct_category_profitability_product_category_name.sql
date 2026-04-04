
    
    

select
    product_category_name as unique_field,
    count(*) as n_records

from ECOMMERCE_DATA_PIPELINE.mart.fct_category_profitability
where product_category_name is not null
group by product_category_name
having count(*) > 1


