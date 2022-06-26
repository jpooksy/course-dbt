{{
    config (
        materialized = 'table'
    )
}}

select oi.order_id, 
       oi.product_id, 
       p.name, 
       p.price,
       oi.quantity, 
       p.price * oi.quantity as user_prod_expenditure,
       p.inventory, 
       geo.state
from {{ ref('stg_order_items') }} as oi 
left join {{ ref('stg_products') }} as p
on oi.product_id = p.product_id
left join {{ ref('dim_core_order_user_geo') }} as geo
on oi.order_id = geo.order_id
order by oi.order_id