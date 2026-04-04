SELECT
    CAST(order_id AS STRING) AS order_id,
    CAST(customer_id AS STRING) AS customer_id,
    CAST(order_status AS STRING) AS order_status_original,
    CASE WHEN order_status = 'delivered' AND order_delivered_customer_date IS NULL THEN 'shipped'
         WHEN order_status = 'canceled' AND order_delivered_customer_date IS NOT NULL THEN 'canceled_with_delivery_anomaly'
         ELSE CAST(order_status AS STRING) END AS order_status,
    TRY_TO_TIMESTAMP(order_purchase_timestamp) AS order_purchase_timestamp,
    TRY_TO_TIMESTAMP(order_approved_at) AS order_approved_at,
    CASE WHEN TRY_TO_TIMESTAMP(order_delivered_carrier_date) < TRY_TO_TIMESTAMP(order_purchase_timestamp) 
            THEN NULL
        WHEN TRY_TO_TIMESTAMP(order_delivered_carrier_date) > TRY_TO_TIMESTAMP(order_delivered_customer_date)
            THEN NULL
        ELSE TRY_TO_TIMESTAMP(order_delivered_carrier_date) END AS order_delivered_carrier_date,
    TRY_TO_TIMESTAMP(order_estimated_delivery_date) AS order_estimated_delivery_date,
    CASE WHEN TRY_TO_TIMESTAMP(order_delivered_customer_date) < TRY_TO_TIMESTAMP(order_purchase_timestamp) 
        THEN NULL ELSE TRY_TO_TIMESTAMP(order_delivered_customer_date) END AS order_delivered_customer_date

FROM {{ source('raw', 'orders') }}