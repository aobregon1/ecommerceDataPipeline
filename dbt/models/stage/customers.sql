/* MODEL: Customer Silver Layer
   PURPOSE: Cleans and casts raw customer data from the source to standard 
   data types for downstream mart development.
*/

select
    cast(customer_id as string) as customer_id,
    cast(customer_unique_id as string) as customer_unique_id,
    cast(customer_zip_code_prefix as integer) as customer_zip_code_prefix,
    cast(customer_city as string) as customer_city,
    cast(customer_state as string) as customer_state
from {{ source('raw', 'customers') }}