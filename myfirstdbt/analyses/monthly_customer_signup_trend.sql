-- analyses/monthly_customer_signup_trend.sql

WITH customer AS (
    SELECT 
        customer_id,
        date_joined
    FROM {{ source('ly1_raw', 'customer') }}
)

SELECT
    DATE_TRUNC('month', date_joined) AS month,
    COUNT(customer_id) AS customer_count
FROM customer
WHERE date_joined >= DATE_TRUNC('year', CURRENT_DATE) - INTERVAL '1 year'
GROUP BY month
ORDER BY month