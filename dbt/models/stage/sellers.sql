SELECT
    CAST(seller_id AS STRING) AS seller_id,
    CAST(seller_zip_code_prefix AS INTEGER) AS seller_zip_code_prefix,
    CAST(seller_city AS STRING) AS seller_city,
    CAST(seller_state AS STRING) AS seller_state

FROM {{ source('raw', 'sellers') }}