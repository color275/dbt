-- models/staging/stg_customer.sql
WITH customer AS (
    SELECT 
        customer_id,
        username,
        first_name,
        last_name,
        email,
        -- Full name 생성
        CONCAT(first_name, ' ', last_name) AS full_name,
        -- 가입 연도 추출
        EXTRACT(YEAR FROM date_joined) AS signup_year,
        -- 전화번호의 국가 코드 추출 (가정: 전화번호 형식이 '+82-10-1234-5678' 형태일 경우)
        CASE
            WHEN phone_number LIKE '+%' THEN SUBSTRING(phone_number FROM 1 FOR POSITION('-' IN phone_number) - 1)
            ELSE NULL
        END AS country_code,
        {{ timestamp_to_string('last_update_time', 'YYYY-MM-DD HH24:MI:SS') }} AS last_update_time
    FROM {{ source('ly1_raw','customer')}}
)

SELECT * FROM customer
