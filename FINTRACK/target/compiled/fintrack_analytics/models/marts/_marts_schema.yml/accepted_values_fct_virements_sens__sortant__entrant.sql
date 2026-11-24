
    
    

with all_values as (

    select
        sens as value_field,
        count(*) as n_records

    from FINTRACK_DB.DEV_GERRY_MARTS.fct_virements
    group by sens

)

select *
from all_values
where value_field not in (
    'sortant','entrant'
)


