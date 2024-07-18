{{
  config(
    materialized='incremental',
    unique_key='order_id',
    sort=['order_id'], 
    dist='order_id',
    incremental_strategy='merge'
  )
}}



-- 테이블이 존재하지 않으면 초기 로딩 수행
{% if not is_incremental() %}

SELECT
    order_id,
    customer_id,
    product_id,
    order_cnt,
    order_price,
    order_dt::timestamp as order_dt,
    TO_CHAR(last_update_time, 'YYYY-MM-DD HH24:MI:SS') last_update_time,
    TO_CHAR(TIMEZONE('Asia/Seoul', CURRENT_TIMESTAMP), 'YYYY-MM-DD HH24:MI:SS') last_batch_time
FROM
    {{ source('source', 'orders_from_kafka') }}

{% else %}

-- 증분 로딩 시 MERGE 사용
select order_id,
    customer_id,
    product_id,
    order_cnt,
    order_price,
    order_dt::timestamp as order_dt,
    TO_CHAR(last_update_time, 'YYYY-MM-DD HH24:MI:SS') last_update_time,
    TO_CHAR(TIMEZONE('Asia/Seoul', CURRENT_TIMESTAMP), 'YYYY-MM-DD HH24:MI:SS') last_batch_time
from {{ source('source', 'orders_from_kafka') }}
where last_update_time >= ( 
                        select max(last_update_time) 
                        from {{ this }}
                   )

{% endif %}