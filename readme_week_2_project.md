# Week 2 - Part 1:

## What is our user repeat rate?
Answer: 0.7983870967741935
```sql
    with orders_cohort as (
        select 
            user_id
            , count (distinct order_id) as user_orders
        from dbt_parker_r.stg_orders
        group by 1
    )
			
	, user_bucket as (
		select
			user_id
			, (user_orders >= 1):: int as has_one__plus_purchases
			, (user_orders >= 2):: int as has_two_plus_purchases
			, (user_orders >= 3):: int as has_three_plus_purchases
		from orders_cohort
	)
			
	select 
        sum(has_two_plus_purchases)::float / count(distinct user_id)::float as repeat_rate
		from user_bucket;
```

# What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
# Good indicators of a user who will likely purchase again:
# Number of sessions
# Session duration
# Event type

# Indicators of users who are likely NOT to purchase again?
# Same as the "Good" indicators:
# Number of sessions
# Session duration
# Event type

# If you had more data, what features would you want to look into to answer this question?
# Source/Medium - How they reached the webpage

#  Complete: More stakeholders are coming to us for data, which is great! But we need to get some more models created before we can help. Create a marts folder, so we can organize our models, with the following subfolders for business units:
# Core
# Marketing
# Product

# Complete: Within each marts folder, create intermediate models and dimension/fact models.
# NOTE: think about what metrics might be particularly useful for these business units, and build dbt models using greenery’s data
# For example, some “core” datasets could include fact_orders, dim_products, and dim_users
# The marketing mart could contain a model like user_order_facts which contains order information at the user level
# The product mart could contain a model like fact_page_views which contains all page view events from greenery’s events data

# Explain the marts models you added. Why did you organize the models in the way you did?
# I organized the models the way I did because it allows me to organize and compartmentalize data depending on the use case (core, marketing, product). More than anything, this model organization saves me time and headache. 

# Complete: Use the dbt docs to visualize your model DAGs to ensure the model layers make sense


## Week 2 - Part 2: 
# We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above

# What assumptions are you making about each model? (i.e. why are you adding each test?)
# order_id is unique and not null on my table "fct_orders"
# reated_at is not null on my table "fct_orders"
# users_id is not null on my table "fct_user_lifetime_value"
# session_id is not null on my table "fct_sessions"

# Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
# Not bad data, but I did notice that orders aren't always fulfilled in the same order they were placed. Many orders are outstanding, even though they were created before others. 

# Complete: Apply these changes to your github repo

# Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.# I would refresh and run dbt tests the data every 24 hours in the morning. Once a test fails, I 1) uncover/solve the issue. If that not possible I would 2) inform the team of the issue. 