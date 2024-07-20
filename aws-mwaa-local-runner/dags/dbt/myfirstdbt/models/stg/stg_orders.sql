{{
  config(
    materialized='incremental',
    unique_key='order_id',
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
    order_dt,
    order_cnt * order_price AS total_order_value,
    {{ timestamp_to_string('last_update_time') }} AS last_update_time,
    {{ ko_now_string() }} as last_batch_time
FROM {{ source('ly1_raw','orders')}}

{% else %}

-- 증분 로딩 시 MERGE 사용
select order_id,
    customer_id,
    product_id,
    order_cnt,
    order_price,
    order_dt,
    order_cnt * order_price AS total_order_value,
    {{ timestamp_to_string('last_update_time') }} AS last_update_time,
    {{ ko_now_string() }} as last_batch_time
FROM {{ source('ly1_raw','orders')}}
where {{ timestamp_to_string('last_update_time') }} >= ( 
                        select max(last_update_time) 
                        from {{ this }}
                   )

{% endif %}

