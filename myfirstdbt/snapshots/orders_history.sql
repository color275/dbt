{% snapshot orders_history %}

{{
    config(
        target_schema='ly2_stg',
        unique_key='order_id',
        strategy='timestamp',
        updated_at='last_update_time'
    )
}}

SELECT * FROM {{ source('ly1_raw', 'orders') }}

{% endsnapshot %}