SELECT 
    "ingredient_id"::VARCHAR AS "ingredient_id",
    "name"::VARCHAR AS "name",
    "category"::VARCHAR As "category"
FROM {{ source('raw_data', 'ingredients')}}