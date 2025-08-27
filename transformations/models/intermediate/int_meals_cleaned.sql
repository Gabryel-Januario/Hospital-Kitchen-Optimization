WITH meals_data AS (
    SELECT * FROM {{ ref('stg_meals' )}}
),

final_cleaning AS (
    SELECT 
        meal_id,
        date,
        meal_type,
        menu_name,
        COALESCE(planned_portions, 0) AS planned_portions
    FROM meals_data
)

SELECT * FROM final_cleaning