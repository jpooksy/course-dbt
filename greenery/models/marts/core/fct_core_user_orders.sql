
{{
    config (
        materialized = 'table'
    )
}}


select 

    u.first_name
    , u.last_name
    , u.email
    , u.phone_number
    , u.created_at as user_created_at
    , u.updated_at as user_updated_at
    , a.address
    , a.state
    , a.country
    , a.zipcode
    , pspo.order_items_quantity
    , promos.*

from {{ ref('int_core_orders_promo_id_agg') }} as promos
left join {{ ref('stg_orders') }} as o
    on promos.order_id  = o.order_id
left join {{ ref('stg_users') }} as u
    on promos.user_id = u.user_id
left join {{ ref('stg_addresses') }} as a
    on u.address_id = a.address_id
left join {{ ref('int_core_products_sold_per_order_agg') }} as pspo
    on promos.order_id = pspo.order_id
