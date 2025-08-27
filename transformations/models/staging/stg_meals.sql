SELECT 
    "meal_id"::VARCHAR AS "meal_id",
    "date"::DATE AS "date",
    "meal_type"::VARCHAR AS "meal_type",
    "menu_name"::VARCHAR AS "menu_name",
    "ingredients"::VARCHAR AS "ingredients",
    "planned_portions"::INTEGER AS "planned_portions"
FROM {{ source('raw_data', 'meals')}}