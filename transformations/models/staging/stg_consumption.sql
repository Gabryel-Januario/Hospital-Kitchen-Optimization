SELECT
    "record_id"::VARCHAR AS "record_id",
    
    "date"::DATE AS "date",
    "meal_id"::VARCHAR AS "meal_id",
    "meal_type"::VARCHAR AS "meal_type",
    "child_id"::VARCHAR AS "child_id",
    "age"::INTEGER AS "age",
    "ward"::VARCHAR AS "ward",
    "served_g"::INTEGER AS "served_g",
    "consumed_g"::INTEGER AS "consumed_g",
    "waste_g"::INTEGER AS "waste_g",
    "waste_ratio"::DOUBLE PRECISION As "waste_ratio",
    "rejected"::INTEGER AS "rejected",
    "rejection_reason"::VARCHAR AS "rejection_reason",
    "menu_name"::VARCHAR AS "menu_name",
    "ingredients"::VARCHAR AS "ingredients",
    "staff_notes"::VARCHAR AS "staff_notes"

FROM {{ source('raw_data', 'consumption') }}