
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select geolocation_zip_code_prefix
from ECOMMERCE_DATA_PIPELINE.mart.fct_geospatial_performance
where geolocation_zip_code_prefix is null



  
  
      
    ) dbt_internal_test