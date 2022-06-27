{{
    config (
        materialized = 'table'
    )
}}

select 
    u.user_id
    , u.email
    , u.first_name 
    , u.last_name
    , a.address
    , a.state
    , a.zipcode
    , a.country 
from {{ ref('stg_users') }} as u 
left join {{ ref('stg_addresses') }} as a
on   u.address_id = a.address_id   