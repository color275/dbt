{% macro timestamp_to_string(timestamp_col, dt_format='YYYY-MM-DD HH24:MI:SS') %}
    TO_CHAR({{timestamp_col}}, '{{dt_format}}')
{% endmacro %}