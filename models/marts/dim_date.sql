{{ config(materialized='table') }}

{{ date_spine("'2017-01-01'", "'2018-12-31'") }}