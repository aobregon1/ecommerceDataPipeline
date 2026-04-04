
  
    

create or replace transient table ECOMMERCE_DATA_PIPELINE.stage.geolocation
    
    
    
    as (SELECT
    CAST(geolocation_zip_code_prefix AS INTEGER) AS geolocation_zip_code_prefix,
    AVG(CAST(geolocation_lat AS NUMBER(38,15))) AS geolocation_lat,
    AVG(CAST(geolocation_lng AS NUMBER(38,15))) AS geolocation_lng,
    MAX(CLEAN_ACCENTS(UPPER(TRIM(CAST(geolocation_city AS STRING))))) AS geolocation_city,
    MAX(UPPER(TRIM(CAST(geolocation_state AS STRING)))) AS geolocation_state
FROM ECOMMERCE_DATA_PIPELINE.RAW.geolocation
GROUP BY geolocation_zip_code_prefix
    )
;


  