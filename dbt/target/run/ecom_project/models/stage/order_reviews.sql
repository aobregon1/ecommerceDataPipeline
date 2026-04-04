
  
    

create or replace transient table ECOMMERCE_DATA_PIPELINE.stage.order_reviews
    
    
    
    as (with source as (
    SELECT * FROM ECOMMERCE_DATA_PIPELINE.RAW.order_reviews
),

ranked_reviews as (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY review_answer_timestamp DESC) AS review_rank
    FROM source
)

SELECT
    CAST(review_id AS STRING) AS review_id,
    CAST(order_id AS STRING) AS order_id,
    CAST(review_score AS INTEGER) AS review_score,
    CAST(review_comment_title AS STRING) AS review_comment_title,
    CAST(review_comment_message AS STRING) AS review_comment_message,
    TRY_TO_TIMESTAMP(review_creation_date) AS review_creation_date,
    TRY_TO_TIMESTAMP(review_answer_timestamp) AS review_answer_timestamp
FROM ranked_reviews
WHERE review_rank = 1
    )
;


  