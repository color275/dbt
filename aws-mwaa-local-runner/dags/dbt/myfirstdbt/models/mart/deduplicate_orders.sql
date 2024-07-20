{{ dbt_utils.deduplicate(
    relation=ref('stg_orders'),
    partition_by='customer_id, order_dt',
    order_by="last_update_time desc"
) }}