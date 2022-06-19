{{
    config (
        materialized = 'table'
    )
}}


SELECT
     order_id
    ,user_id
    ,address_id
    ,created_at
    ,sum(case when promo_id = 'Digitized' then 1 else 0 end) as promo_used_digitized
    ,sum(case when promo_id = 'instruction set' then 1 else 0 end) as promo_used_instruction_set
    ,sum(case when promo_id = 'leverage' then 1 else 0 end) as promo_used_leverage
	,sum(case when promo_id = 'Mandatory' then 1 else 0 end) as promo_used_mandatory
    ,sum(case when promo_id = 'Optional' then 1 else 0 end) as promo_used_optional
    ,sum(case when promo_id = 'task-force' then 1 else 0 end) as promo_used_task_force
from {{ ref ('stg_orders') }}
group by 1,2,3,4