
  
    

create or replace transient table ECOMMERCE_DATA_PIPELINE.stage.order_payments
    
    
    
    as (SELECT
    CAST(order_id AS STRING) AS order_id,
    CAST(payment_sequential AS INTEGER) AS payment_sequential,
    CAST(payment_type AS STRING) AS payment_type,
    CAST(payment_installments AS INTEGER) AS payment_installments,
    TRY_TO_NUMBER(payment_value, 38, 2) AS payment_value
FROM ECOMMERCE_DATA_PIPELINE.RAW.order_payments
    )
;


  