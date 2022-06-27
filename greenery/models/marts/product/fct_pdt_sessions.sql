{{config(materialized = 'table')}}

select
    e.session_id
    , e.user_id
    , e.product_id
    , e.page_view
    , e.add_to_cart
    , e.checkout
    , e.package_shipped
    , l.session_start_time
    , l.session_end_time
    , l.session_length

from {{ ref('int_pdt_sessions_events') }} as e
left join {{ ref('int_pdt_sessions_length') }} as l
    on e.session_id = l.session_id