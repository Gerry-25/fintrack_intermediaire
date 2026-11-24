






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and montant_prevu >= 0
)
 as expression


    from FINTRACK_DB.DEV_GERRY_MARTS.mart_budget_vs_reel
    

),
validation_errors as (

    select
        *
    from
        grouped_expression
    where
        not(expression = true)

)

select *
from validation_errors







