
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select virement_ligne_id
from FINTRACK_DB.DEV_GERRY_MARTS.fct_virements
where virement_ligne_id is null



  
  
      
    ) dbt_internal_test