WITH source AS (
    SELECT
        *
    FROM
        {{ source(
            "greenery",
            "orders"
        ) }}
),
renamed AS (
    SELECT
        order_id,
        user_id,
        replace(replace(lower(promo_id), '-', '_'), ' ', '_') as promo_id,
        address_id,
        created_at,
        order_cost,
        shipping_cost,
        order_total,
        tracking_id,
        shipping_service,
        estimated_delivery_at,
        delivered_at,
        status
    FROM
        source
)

SELECT
    *
FROM
    renamed
