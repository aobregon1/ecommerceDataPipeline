



select
    1
from ECOMMERCE_DATA_PIPELINE.stage.geolocation

where not(geolocation_city geolocation_city RLIKE '^[^ÁÀÂÃÉÈÊÍÌÎÓÒÔÕÚÙÛÇ]*$')

