
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from FINTRACK_DB.DEV_GERRY_MARTS.fct_transactions

where not(date_transaction <= current_timestamp()::timestamp_ntz)


  
  
      
    ) dbt_internal_test