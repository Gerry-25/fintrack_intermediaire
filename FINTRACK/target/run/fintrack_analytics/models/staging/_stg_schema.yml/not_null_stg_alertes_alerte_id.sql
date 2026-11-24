
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select alerte_id
from FINTRACK_DB.DEV_GERRY_STAGING.stg_alertes
where alerte_id is null



  
  
      
    ) dbt_internal_test