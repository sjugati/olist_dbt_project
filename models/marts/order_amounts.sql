{{ config(materialized='view') }}

SELECT
    order_id,
    {{ cents_to_dollars('payment_value') }} AS payment_amount,
    '{{ generate_alias('orders','fact') }}' AS alias_name
FROM {{ ref('stg_payments') }}