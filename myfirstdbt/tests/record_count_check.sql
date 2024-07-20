-- tests/record_count_check.sql

-- Define the expected record counts for each table
{% set expected_counts = {
    'stg_customer': 0,
    'stg_orders': 20,
    'stg_product': 0
} %}

-- Define the current date at 00:00
{% set today_00 = "DATE_TRUNC('day', now())" %}

-- Test the count of records in each table
{% for table, expected_count in expected_counts.items() %}
SELECT '{{ table }}' AS table_name,
       (SELECT COUNT(*) FROM {{ ref(table) }} WHERE last_update_time > {{ today_00 }}) AS record_count,
       {{ expected_count }} AS expected_count
WHERE (SELECT COUNT(*) FROM {{ ref(table) }} WHERE last_update_time > {{ today_00 }}) < {{ expected_count }}
{% if not loop.last %} UNION ALL {% endif %}
{% endfor %}