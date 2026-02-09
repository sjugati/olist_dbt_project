{{ config(materialized='view') }}

SELECT
    order_id,
    payment_type,
    payment_value,
    '{{ target.name }}' AS target_name,
    '{{ target.schema }}' AS target_schema
FROM {{ ref('stg_payments') }}
WHERE payment_type IN (
{% for m in var('payment_methods') %}
    '{{ m }}'{% if not loop.last %},{% endif %}
{% endfor %}
)