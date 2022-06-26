{{
    config (
        materialized = 'table'
    )
}}

with session_length as (
    SELECT
     session_id
        , min(created_at) as first_event
        , max(created_at) as last_event
    from {{ ref('stg_events') }}
    group by 1
)

SELECT 
    s.session_id
    , s.user_id
    , u.first_name
    , u.last_name
    , u.email
    , s.add_to_cart
    , s.checkout
    , s.page_view
    , s.package_shipped
    , sl.first_event
    , sl.last_event
    , (date_part('day', sl.last_event::timestamp - sl.first_event::timestamp) * 24 +
        date_part('hour', sl.last_event::timestamp - sl.first_event::timestamp) * 60 +
        date_part('minute', sl.last_event::timestamp - sl.first_event::timestamp))
    as session_length_minutes

    from {{ ref('int_product_session_events_basic_agg') }} as s
    left join {{ ref('stg_users') }} as u
        on s.user_id  = u.user_id
    left join session_length as sl
        on s.session_id = sl.session_id