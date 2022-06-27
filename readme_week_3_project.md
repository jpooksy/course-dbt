# PART 1
## What is our overall conversion rate?
### conversion_rate = 62.46%

# SELECT 
#  (sum(checkout)/count(distinct session_id))*100 as conversion_rate
# FROM dbt_parker_r.int_pdt_sessions_events

## What is our conversion rate by product?
### I haven't figured it out. This question defeated me. 


# PART 2:
## Create a macro to simplify part of a model(s)

# {% macro aggregate_event_types(event_type) %}
#        SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END)
# {% endmacro %}

# {% macro aggregate_promos(promo_id) %}
#    SUM(CASE WHEN promo_id = '{{promo_id}}' THEN 1 ELSE 0 END)
# {% endmacro %}

# PART 3: 
## Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.

# post-hook:
#    - "GRANT SELECT ON {{ this }} TO reporting"

#  on-run-end:
   - "GRANT USAGE ON SCHEMA {{ 'dbt_parker_r' }} TO reporting"


# PART 4:  
# Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project

# packages:
#   - package: dbt-labs/dbt_utils
#     version: 0.8.6
#   - package: calogica/dbt_expectations
#     version: 0.5.1
#   - package: dbt-labs/codegen
#     version: 0.5.0
    
    
# PART 5: 
## Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.
