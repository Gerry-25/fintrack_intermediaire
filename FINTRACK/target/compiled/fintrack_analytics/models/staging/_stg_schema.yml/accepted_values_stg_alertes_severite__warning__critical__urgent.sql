
    
    

with all_values as (

    select
        severite as value_field,
        count(*) as n_records

    from FINTRACK_DB.DEV_GERRY_STAGING.stg_alertes
    group by severite

)

select *
from all_values
where value_field not in (
    'warning','critical','urgent'
)


