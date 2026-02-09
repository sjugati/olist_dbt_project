{% macro date_spine(start_date, end_date) %}
WITH RECURSIVE dates AS (
    SELECT {{ start_date }}::DATE AS d
    UNION ALL
    SELECT DATEADD(day, 1, d)
    FROM dates
    WHERE d < {{ end_date }}::DATE
)
SELECT d AS date_day
FROM dates
{% endmacro %}