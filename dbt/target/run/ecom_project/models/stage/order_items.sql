
  
    

create or replace transient table ECOMMERCE_DATA_PIPELINE.stage.order_items
    
    
    
    as (SELECT
    CAST(order_id AS STRING) AS order_id,
    CAST(order_item_id AS INTEGER) AS order_item_id,
    CAST(product_id AS STRING) AS product_id,
    CAST(seller_id AS STRING) AS seller_id,
    TRY_TO_TIMESTAMP(shipping_limit_date) AS shipping_limit_date,
    TRY_TO_NUMBER(price, 38, 2) AS price,
    TRY_TO_NUMBER(freight_value, 38, 2) AS freight_value
FROM ECOMMERCE_DATA_PIPELINE.RAW.order_items
    )
;


  