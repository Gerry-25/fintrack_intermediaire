
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select montant
from FINTRACK_DB.DEV_GERRY_STAGING.stg_virements
where montant is null



  
  
      
    ) dbt_internal_test