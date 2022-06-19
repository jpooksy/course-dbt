{{
    config (
        materialized = 'table'
    )
}}


select 
    stg_orders.order_id
    , stg_orders.user_id
    , stg_orders.created_at
    , stg_orders.order_total
    , int_core_products_sold_per_order_agg.order_items_quantity
    , stg_orders.estimated_delivery_at
    , stg_orders.delivered_at
    , stg_users.first_name
    , stg_users.last_name
    , stg_users.email
    , stg_users.phone_number
    , int_core_orders_promo_id_agg.promo_used_digitized
    , int_core_orders_promo_id_agg.promo_used_instruction_set
    , int_core_orders_promo_id_agg.promo_used_leverage
    , int_core_orders_promo_id_agg.promo_used_mandatory
    , int_core_orders_promo_id_agg.promo_used_optional
    , int_core_orders_promo_id_agg.promo_used_task_force

    from {{ ref('stg_orders') }}
    left join {{ ref('stg_users') }}
        on stg_orders.user_id  = stg_users.user_id
    left join {{ ref('int_core_orders_promo_id_agg') }}
        on stg_orders.order_id = int_core_orders_promo_id_agg.order_id
    left join {{ ref('int_core_products_sold_per_order_agg') }}
        on stg_orders.order_id = int_core_products_sold_per_order_agg.order_id