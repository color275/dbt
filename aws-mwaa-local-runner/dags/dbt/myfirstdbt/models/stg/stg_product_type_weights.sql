-- models/staging/stg_product_type_weights.sql

WITH product_type_weights AS (
    SELECT 
        product_id,
        product_name,
        products_weight,
        basket_weight,
        order_weight
    FROM {{ source('ly1_raw','product_type_weights')}}
)

SELECT * FROM product_type_weights