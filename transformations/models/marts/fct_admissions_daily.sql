{{ config(materialized='table') }}

SELECT 
    ward AS ala_hospitalar,
    age_group AS faixa_etaria,
    sex AS sexo,
    COUNT(child_id) AS total_de_crianças_admitidas,
    ROUND(AVG(days_admitted), 2) AS media_dias_internacao,
    MAX(days_admitted) AS maximo_dias_internacao
FROM {{ ref('int_children_cleaned') }}
GROUP BY 1, 2, 3
ORDER BY ala_hospitalar, faixa_etaria, sexo