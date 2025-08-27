SELECT 
    "child_id"::VARCHAR AS "child_id",

    "age"::INTEGER AS "age",
    "sex"::VARCHAR As "sex",
    "ward"::VARCHAR As "ward",

    "days_admitted"::INTEGER as "days_admitted"
    
FROM {{ source('raw_data', 'children')}}