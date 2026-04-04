






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and freight_ratio >= 0 and freight_ratio <= 5
)
 as expression


    from ECOMMERCE_DATA_PIPELINE.mart.fct_seller_performance
    

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







