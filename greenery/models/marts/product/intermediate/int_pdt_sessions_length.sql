{{
    config (
        materialized = 'table'
    )
}}

with session_timestamps as (
    select
        session_id
        , min(created_at) as session_start_time
        , max(created_at) as session_end_time
    from {{ ref('stg_events') }} 
    group by 1
)

select
    e.session_id
    , st.session_start_time
    , st.session_end_time
    , (st.session_end_time - st.session_start_time) as session_length
from {{ ref('stg_events') }} as e
left join session_timestamps as st
    on e.session_id = st.session_id
