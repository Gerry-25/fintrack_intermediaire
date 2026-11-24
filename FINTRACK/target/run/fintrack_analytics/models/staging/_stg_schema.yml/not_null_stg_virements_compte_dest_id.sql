
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select compte_dest_id
from FINTRACK_DB.DEV_GERRY_STAGING.stg_virements
where compte_dest_id is null



  
  
      
    ) dbt_internal_test