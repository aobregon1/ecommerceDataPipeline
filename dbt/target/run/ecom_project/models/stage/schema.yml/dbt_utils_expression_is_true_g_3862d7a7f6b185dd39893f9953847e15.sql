
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from ECOMMERCE_DATA_PIPELINE.stage.geolocation

where not(geolocation_city REGEXP_LIKE(geolocation_city, '^[^ÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛÇ]*$'))


  
  
      
    ) dbt_internal_test