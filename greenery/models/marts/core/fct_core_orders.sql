
{{
    config (
        materialized = 'table'
    )
}}

select 
    o.order_id
    , o.user_id
    , o.created_at
    , o.order_total
    , products_sold_agg.order_items_quantity
    , o.estimated_delivery_at
    , o.delivered_at
    , u.first_name
    , u.last_name
    , u.email
    , u.phone_number
    , promo_id_agg.promo_used_digitized
    , promo_id_agg.promo_used_instruction_set
    , promo_id_agg.promo_used_leverage
    , promo_id_agg.promo_used_mandatory
    , promo_id_agg.promo_used_optional
    , promo_id_agg.promo_used_task_force

    from {{ ref('stg_orders') }} as o
    left join {{ ref('stg_users') }} as u
        on o.user_id  = u.user_id
    left join {{ ref('int_core_orders_promo_id_agg') }} as promo_id_agg
        on o.order_id = promo_id_agg.order_id
    left join {{ ref('int_core_products_sold_per_order_agg') }} as products_sold_agg
        on o.order_id = products_sold_agg.order_id