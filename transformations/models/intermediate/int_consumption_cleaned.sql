WiTH consumption_data AS (
    SELECT * FROM {{ref('stg_consumption')}}
),

final_cleaning AS (
    SELECT
        record_id,
        date,
        meal_id,
        meal_type,
        child_id,
        COALESCE(age, 0) AS age,
        ward,
        COALESCE(served_g, 0) AS served_g,
        COALESCE(consumed_g, 0) As consumed_g,
        COALESCE(waste_g, 0) AS waste_g,
        COALESCE(waste_ratio, 0) AS waste_ratio,
        rejected,
        COALESCE(rejection_reason, '') AS rejection_reason,
        menu_name,
        COALESCE(staff_notes, '') AS staff_notes,
        CASE 
            WHEN age BETWEEN 0 AND 2 THEN 'Bebê'
            WHEN age BETWEEN 3 AND 11 THEN 'Criança'
            WHEN age >= 12 THEN 'Adolescente'
            ELSE 'Idade não informada'
        END AS age_group
    FROM consumption_data
)

SELECT * FROM final_cleaning