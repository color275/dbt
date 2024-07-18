-- models/final/f_product_weights.sql

WITH product AS (
    SELECT * FROM {{ ref('stg_product') }}
),
product_type_weights AS (
    SELECT * FROM {{ ref('stg_product_type_weights') }}
)

-- 제품 정보와 가중치 정보를 결합한 요약 테이블 생성
SELECT 
    p.product_id,
    p.name AS product_name,
    p.upper_category AS product_category,
    p.price,
    p.price_category,
    ptw.products_weight,
    ptw.basket_weight,
    ptw.order_weight
FROM product p
JOIN product_type_weights ptw ON p.product_id = ptw.product_id
ORDER BY 
    p.product_id