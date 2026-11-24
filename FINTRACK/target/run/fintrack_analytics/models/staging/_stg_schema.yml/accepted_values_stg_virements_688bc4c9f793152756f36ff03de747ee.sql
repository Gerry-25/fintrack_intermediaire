
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        statut as value_field,
        count(*) as n_records

    from FINTRACK_DB.DEV_GERRY_STAGING.stg_virements
    group by statut

)

select *
from all_values
where value_field not in (
    'execute','en_attente','annule'
)



  
  
      
    ) dbt_internal_test