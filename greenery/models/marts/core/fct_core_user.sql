{{
    config (
        materialized = 'table'
    )
}}


with order_items_cohort as (
    select
        *
    from  {{ ref ('int_core_order_items_agg') }} 
), 

  orders_cohort as (
    select 
      o.user_id
      , o.order_id
      , o.order_total
      , oi.distinct_products_per_order
      , oi.product_quantity_per_order
    from dbt_parker_r.stg_orders as o
    left join order_items_cohort as oi
      on o.order_id = oi.order_id

  )

select 
  user_id
  , sum(order_total) as user_total_spend
  , count(order_id) as user_total_orders
  , sum(product_quantity_per_order) as user_total_order_items
  , sum(distinct_products_per_order) as user_distinct_order_items
from orders_cohort
group by user_id