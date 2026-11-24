
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  





with validation_errors as (

    select
        compte_id, periode
    from FINTRACK_DB.DEV_GERRY_MARTS.mart_solde_mensuel
    group by compte_id, periode
    having count(*) > 1

)

select *
from validation_errors



  
  
      
    ) dbt_internal_test