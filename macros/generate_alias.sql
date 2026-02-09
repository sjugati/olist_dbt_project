{% macro generate_alias(table_name, prefix) %}
    {{ prefix }}_{{ table_name }}
{% endmacro %}