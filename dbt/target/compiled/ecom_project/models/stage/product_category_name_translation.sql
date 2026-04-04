SELECT
    CAST(product_category_name AS STRING) AS product_category_name,
    CAST(product_category_name_english AS STRING) AS product_category_name_english
FROM ECOMMERCE_DATA_PIPELINE.RAW.product_category_name_translation