{{
    config (
        materialized = 'table'
    )
}}


select 
    stg_users.user_id
    , stg_users.first_name
    , stg_users.last_name
    , stg_users.email
    , stg_users.phone_number
    , stg_users.created_at
    , int_mktg_user_orders_agg.user_orders_quantity
    , int_mktg_user_orders_agg.user_orders_value

    from {{ ref('stg_users') }}
    left join {{ ref('int_mktg_user_orders_agg') }}
        on stg_users.user_id  = int_mktg_user_orders_agg.user_id