{{ config(
    materialized='table',
    pre_hook="INSERT INTO {{ target.schema }}.model_run_log (model_name, run_timestamp) VALUES ('{{ this.name }}', CURRENT_TIMESTAMP())",
    post_hook="GRANT SELECT ON {{ this }} TO ROLE ACCOUNTADMIN"
) }}

-- Same SQL as fct_orders
WITH orders AS (
    SELECT *
    FROM {{ ref('stg_orders') }}
),

customers AS (
    SELECT *
    FROM {{ ref('stg_customers') }}
),

order_items AS (
    SELECT *
    FROM {{ ref('stg_order_items') }}
),

payments AS (
    SELECT *
    FROM {{ ref('stg_payments') }}
),

order_totals AS (
    SELECT
        oi.order_id,
        SUM(oi.price) AS total_order_value,
        SUM(oi.freight_value) AS total_freight_value
    FROM order_items oi
    GROUP BY oi.order_id
),

payment_totals AS (
    SELECT
        p.order_id,
        SUM(p.payment_value) AS total_payment_value
    FROM payments p
    GROUP BY p.order_id
),

final AS (
    SELECT
        o.order_id,
        o.customer_id,
        c.customer_city,
        c.customer_state,
        o.order_status,
        o.order_purchase_timestamp,
        ot.total_order_value,
        ot.total_freight_value,
        pt.total_payment_value
    FROM orders o
    LEFT JOIN customers c
        ON o.customer_id = c.customer_id
    LEFT JOIN order_totals ot
        ON o.order_id = ot.order_id
    LEFT JOIN payment_totals pt
        ON o.order_id = pt.order_id
)

SELECT * FROM final