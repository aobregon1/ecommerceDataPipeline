
    
    

select
    customer_unique_id as unique_field,
    count(*) as n_records

from ECOMMERCE_DATA_PIPELINE.mart.fct_customer_clv
where customer_unique_id is not null
group by customer_unique_id
having count(*) > 1


