{{
    config (
        materialized = 'table'
    )
}}

select du.user_id,
       du.zipcode,
       du.state, 
       du.country,
       o.order_id
from {{ ref('dim_core_user') }} as du
left join {{ ref('stg_orders') }} as o
on du.user_id = o.user_id