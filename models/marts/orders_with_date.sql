{{ config(materialized='table') }}

SELECT
    o.order_id,
    o.order_purchase_timestamp,
    d.date_day,
    o.order_status
FROM {{ ref('stg_orders') }} o
INNER JOIN {{ ref('dim_date') }} d
    ON DATE(o.order_purchase_timestamp) = d.date_day