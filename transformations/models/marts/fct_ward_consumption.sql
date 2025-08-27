{{ config(materialized='table')}}

SELECT 
    cons.ward,
    cons.meal_type,
    ROUND(AVG(cons.served_g),2) AS  served_g,
    ROUND(AVG(cons.consumed_g),2) AS consumed_g,
    ROUND(AVG(cons.waste_g),2) AS waste_g,
    ROUND(AVG(cons.waste_ratio)::NUMERIC , 2) AS waste_ratio,
    COUNT(cons.rejected) AS rejected

FROM {{ ref('int_consumption_cleaned') }} AS cons
GROUP BY cons.ward, cons.meal_type
ORDER BY waste_ratio DESC, cons.ward, rejected