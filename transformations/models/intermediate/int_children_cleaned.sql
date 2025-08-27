WITH children_data AS (
    SELECT * FROM {{ ref('stg_children') }}
),

standardized_sex AS (
    SELECT *,
        CASE
            WHEN LOWER(sex) IN ('m', 'male', 'masculino') THEN 'Masculino'
            WHEN LOWER(sex) IN ('f', 'female', 'feminino') THEN 'Feminino'
            ELSE 'Não informado'
        END AS sex_standardized
    FROM children_data
), 

final_cleaning AS (
    SELECT
        child_id,
        COALESCE(age,0) AS age,
        sex_standardized AS sex,
        ward,
        days_admitted,
        CASE
            WHEN age BETWEEN 0 AND 2 THEN 'Bebê'
            WHEN age BETWEEN 3 AND 12 THEN 'Criança'
            WHEN age >= 12 THEN 'Adolescente'
            ELSE 'Idade não informada'
        END AS age_group
    FROM standardized_sex
)

SELECT * FROM final_cleaning