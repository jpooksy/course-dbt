

{{
    config (
        materialized = 'table'
    )
}}

select  
    order_id
    , sum(quantity) as order_items_quantity
    from {{ ref ('stg_order_items') }}
    group by 1