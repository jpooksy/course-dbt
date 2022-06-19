{{
    config (
        materialized = 'table'
    )
}}

select  
    user_id
    , count(order_id) as user_orders_quantity
    , sum(order_total) as user_orders_value
    from {{ ref ('stg_orders') }}
    group by 1