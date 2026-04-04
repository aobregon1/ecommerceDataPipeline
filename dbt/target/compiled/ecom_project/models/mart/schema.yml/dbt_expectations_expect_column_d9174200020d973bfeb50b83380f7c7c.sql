






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and total_lifetime_value >= 0
)
 as expression


    from ECOMMERCE_DATA_PIPELINE.mart.fct_customer_clv
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors







