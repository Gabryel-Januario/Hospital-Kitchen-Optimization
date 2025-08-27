{{ config(materialized='table')}}

SELECT 
    cons.age_group,
    COUNT(cons.rejected) AS rejected

FROM {{ ref('int_consumption_cleaned')}} AS cons
GROUP BY cons.age_group
ORDER BY rejected DESC