{% macro ko_now_string(timezone='Asia/Seoul', dt_format='YYYY-MM-DD HH24:MI:SS') %}
    TO_CHAR(TIMEZONE('{{timezone}}', CURRENT_TIMESTAMP), '{{dt_format}}')
{% endmacro %}