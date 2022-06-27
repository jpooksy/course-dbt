{{ config(materialized = 'table')  }}


{% 
    set event_types = dbt_utils.get_column_values(
        table=ref('stg_events'),
        column='event_type'
    ) 
%}


SELECT
    session_id
    , user_id
    , product_id
    , created_at
     {% for event_type in event_types %}
    , {{aggregate_event_types( event_type )}} AS {{event_type}}
    {% endfor %}
from {{ ref ('stg_events') }}
group by 1,2,3,4