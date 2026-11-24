
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from FINTRACK_DB.DEV_GERRY_MARTS.fct_virements

where not(compte_source_id != compte_dest_id)


  
  
      
    ) dbt_internal_test