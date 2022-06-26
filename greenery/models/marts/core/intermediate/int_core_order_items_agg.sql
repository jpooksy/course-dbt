{{
    config (
        materialized = 'table'
    )
}}


select 
    order_id
    , count(distinct product_id) as distinct_products_per_order
    , sum(quantity) as product_quantity_per_order
from dbt_parker_r.stg_order_items
group by order_id