



select
    1
from ECOMMERCE_DATA_PIPELINE.stage.geolocation

where not(geolocation_city REGEXP_LIKE(geolocation_city, '^[^ÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛÇ]*$'))

