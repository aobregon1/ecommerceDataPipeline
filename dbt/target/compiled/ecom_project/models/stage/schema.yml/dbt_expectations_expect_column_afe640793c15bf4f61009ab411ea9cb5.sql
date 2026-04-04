




    with grouped_expression as (
    select
        
        
    
  


    
regexp_instr(geolocation_city, '^.*$', 1, 1, 0, '')


 > 0
 as expression


    from ECOMMERCE_DATA_PIPELINE.stage.geolocation
    

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




