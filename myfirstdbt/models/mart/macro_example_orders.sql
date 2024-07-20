-- models/mart/macro_example_orders.sql
WITH orders AS (
    SELECT 
        o.order_id,
        o.order_price,
        o.order_cnt,
        p.name AS product_name,
        c.username AS customer_name,
        -- 할인가격 계산
        {{ discount_price('o.order_price', 10) }} AS discounted_price
    FROM {{ ref('stg_orders') }} o
    JOIN {{ ref('stg_product') }} p ON o.product_id = p.product_id
    JOIN {{ ref('stg_customer') }} c ON o.customer_id = c.customer_id
)

SELECT * FROM orders