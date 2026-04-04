
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from ECOMMERCE_DATA_PIPELINE.stage.orders

where not(order_delivered_customer_date order_status != 'delivered' or order_delivered_customer_date is not null)


  
  
      
    ) dbt_internal_test