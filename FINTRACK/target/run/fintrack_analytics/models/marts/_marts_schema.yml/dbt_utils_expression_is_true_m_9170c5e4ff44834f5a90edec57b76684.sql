
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from FINTRACK_DB.DEV_GERRY_MARTS.mart_budget_vs_reel

where not(depassement = (ecart < 0))


  
  
      
    ) dbt_internal_test