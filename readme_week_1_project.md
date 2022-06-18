# Week 1 Project

## How many users do we have?
130

```sql
SELECT COUNT ( DISTINCT user_id ) FROM dbt_yang_s.stg_users;
```

## On average, how many orders do we receive per hour?

7.5208333333333333

```sql
WITH by_hour AS (
        SELECT DATE_TRUNC( 'hour', created_at ), COUNT(DISTINCT order_id)
        FROM dbt_yang_s.stg_orders
        GROUP BY 1
    )
SELECT AVG(COUNT)
FROM by_hour;
```

## On average, how long does an order take from being placed to being delivered?

3 days 21:24:11.803279

```sql
WITH time_to_delivery AS (
        SELECT delivered_at created_at AS time_to_delivery
        FROM dbt_yang_s.stg_orders
        WHERE delivered_at IS NOT NULL
    )
SELECT AVG(time_to_delivery)
FROM time_to_delivery;
```

## How many users have only made one purchase? Two purchases? Three+ purchases?

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

| Total orders | User count |
|:------------:|-----------:|
|1 order|25|
|2 orders|28|
|3+ orders|71|

```sql
WITH order_counts AS (
        SELECT user_id, COUNT(DISTINCT order_id) AS order_count
        FROM dbt_yang_s.stg_orders
        GROUP BY user_id
    )
SELECT
    CASE WHEN order_count = 1 THEN '1'
    WHEN order_count = 2 THEN '2'
    WHEN order_count > 2 THEN '3+' END AS order_count,
    COUNT(DISTINCT user_id)
FROM order_counts
GROUP BY 1
ORDER BY 1

```

## On average, how many unique sessions do we have per hour?
16.3275862068965517

```sql
WITH unique_session_count_by_hour AS (
        SELECT
            DATE_TRUNC( 'hour', created_at ) AS HOUR,
            COUNT( DISTINCT session_id ) AS COUNT
        FROM dbt_yang_s.stg_events
        GROUP BY 1
    )
SELECT AVG(COUNT)
FROM unique_session_count_by_hour
```

