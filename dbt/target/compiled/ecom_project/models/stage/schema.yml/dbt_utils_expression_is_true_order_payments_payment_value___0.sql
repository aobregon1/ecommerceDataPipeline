



select
    1
from ECOMMERCE_DATA_PIPELINE.stage.order_payments

where not(payment_value >= 0)

