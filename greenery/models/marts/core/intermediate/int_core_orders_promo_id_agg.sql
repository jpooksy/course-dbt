{{ config(materialized = 'table')  }}

{% 
    set promo_ids = dbt_utils.get_column_values(
        table=ref('stg_orders'),
        column='promo_id'
    ) 
%}


SELECT
     order_id
    ,user_id
    ,address_id
    ,created_at
    {% for promo in promo_ids %}
    , {{aggregate_promos( promo )}} AS {{promo}}
    {% endfor %}
from {{ ref ('stg_orders') }}
group by 1,2,3,4