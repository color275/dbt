-- tests/not_null_order_price.sql

SELECT *
FROM {{ source('ly1_raw','orders') }}
WHERE order_price < 0