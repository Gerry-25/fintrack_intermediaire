
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        type_compte as value_field,
        count(*) as n_records

    from FINTRACK_DB.DEV_GERRY_STAGING.stg_comptes
    group by type_compte

)

select *
from all_values
where value_field not in (
    'courant','epargne','joint'
)



  
  
      
    ) dbt_internal_test