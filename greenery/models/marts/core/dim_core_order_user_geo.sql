{{
    config (
        materialized = 'table'
    )
}}

select 
    u.user_id,
    o.order_id,
    u.zipcode,
    u.state, 
    u.country
from {{ ref('dim_core_user') }} as u
left join {{ ref('stg_orders') }} as o
    on u.user_id = o.user_id