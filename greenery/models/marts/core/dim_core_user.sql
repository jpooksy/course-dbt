{{
    config (
        materialized = 'table'
    )
}}

select u.user_id, 
       u.first_name, 
       u.last_name,
       a.zipcode,
       a.state,
       a.country 
from {{ ref('stg_users') }} as u 
left join {{ ref('stg_addresses') }} as a
on   u.address_id = a.address_id   