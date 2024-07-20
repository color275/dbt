-- macros/discount_price.sql
{% macro discount_price(original_price, discount_rate) %}
    {{ original_price }} * (1 - {{ discount_rate }} / 100)
{% endmacro %}