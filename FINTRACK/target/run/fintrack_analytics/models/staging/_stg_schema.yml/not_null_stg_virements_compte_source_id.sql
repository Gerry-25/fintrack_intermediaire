
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select compte_source_id
from FINTRACK_DB.DEV_GERRY_STAGING.stg_virements
where compte_source_id is null



  
  
      
    ) dbt_internal_test