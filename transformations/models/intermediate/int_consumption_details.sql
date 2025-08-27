SELECT
    cons.date,
    cons.child_id,
    cons.rejected,
    meals.meal_type,
    meals.menu_name

FROM {{ ref('stg_consumption') }} AS cons

LEFT JOIN {{ ref('stg_meals') }} AS meals
    on cons.meal_id = meals.meal_id
