{{ config(materialized='table')}}

SELECT
    cons.menu_name,
    COUNT(cons.rejected) AS rejected

FROM {{ ref('int_consumption_details')}} AS cons
GROUP BY cons.menu_name
ORDER BY rejected DESC