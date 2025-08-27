WITH ingredients_data AS (
    SELECT * FROM {{ ref('stg_ingredients') }}
),

final_cleaning AS (
    SELECT 
        ingredient_id,
        name,
        category
    FROM ingredients_data
    WHERE name IS NOT NULL OR name != ''
)

SELECT * FROM final_cleaning