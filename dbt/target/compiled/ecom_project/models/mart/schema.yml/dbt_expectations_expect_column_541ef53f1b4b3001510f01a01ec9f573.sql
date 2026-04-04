






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and avg_category_review_score >= 1 and avg_category_review_score <= 5
)
 as expression


    from ECOMMERCE_DATA_PIPELINE.mart.fct_category_profitability
    

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







