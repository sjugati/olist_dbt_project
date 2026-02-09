{% macro cents_to_dollars(amount_col) %}
    ({{ amount_col }} / 100.0)
{% endmacro %}