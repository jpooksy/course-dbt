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
    int_session_events_basic_agg.session_id
    , int_session_events_basic_agg.user_id
    , stg_users.first_name
    , stg_users.last_name
    , stg_users.email
    , int_session_events_basic_agg.add_to_cart
    , int_session_events_basic_agg.checkout
    , int_session_events_basic_agg.page_view
    , int_session_events_basic_agg.package_shipped
    , session_length.first_event
    , session_length.last_event
    , (date_part('day', session_length.last_event::timestamp - session_length.first_event::timestamp) * 24 +
        date_part('hour', session_length.last_event::timestamp - session_length.first_event::timestamp) * 60 +
        date_part('minute', session_length.last_event::timestamp - session_length.first_event::timestamp))
    as session_length_minutes

    from {{ ref('int_session_events_basic_agg') }}
    left join {{ ref('stg_users') }}
        on int_session_events_basic_agg.user_id  = stg_users.user_id
    left join session_length
        on int_session_events_basic_agg.session_id = session_length.session_id