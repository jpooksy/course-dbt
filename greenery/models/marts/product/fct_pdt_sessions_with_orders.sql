{{config(materialized = 'table')}}

SELECT 
    e.session_id
    , e.user_id
    , e.event_id
    , e.product_id as viewed_product_id
    , pv.name AS viewed_product_name
    , oi.order_id
    , oi.product_id AS ordered_product_id
    , po.name AS ordered_product_name
    , oi.quantity AS product_quantity
    , e.created_at
FROM {{ ref('stg_events') }} AS e
LEFT JOIN {{ ref('stg_order_items') }} AS oi
    ON oi.order_id = e.order_id
LEFT JOIN {{ ref('stg_products')}} AS pv
    ON e.product_id = pv.product_id
LEFT JOIN {{ ref('stg_products')}} AS po
    ON oi.product_id = po.product_id