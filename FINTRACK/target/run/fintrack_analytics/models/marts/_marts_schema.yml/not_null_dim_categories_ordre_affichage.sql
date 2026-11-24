
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select ordre_affichage
from FINTRACK_DB.DEV_GERRY_MARTS.dim_categories
where ordre_affichage is null



  
  
      
    ) dbt_internal_test