{{
    config (
        materialized = 'table'
    )
}}

select state, 
       round(sum(user_prod_expenditure)) as revenues,
       round(sum(quantity)) as units_of_output
from {{ ref('fct_core_order_items_products') }}
group by 1
order by revenues desc