{{ config(materialized='table') }}

SELECT 
    cons.record_id,
    cons.date,
    cons.child_id,
    child.age,
    child.sex,
    child.ward,
    cons.meal_id,
    meals.meal_type,
    meals.menu_name,
    cons.rejected,
    cons.served_g,
    cons.consumed_g,
    cons.waste_g,
    cons.waste_ratio

FROM {{ ref('stg_consumption')}} as cons

LEFT JOIN {{ ref('stg_meals')}} as meals 
    ON cons.meal_id = meals.meal_id

LEFT JOIN {{ ref('stg_children')}} as child
    ON cons.child_id = child.child_id