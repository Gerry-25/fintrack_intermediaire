






    with grouped_expression as (
    select
        
        
    
  
( 1=1 and solde_cumule >= 0
)
 as expression


    from FINTRACK_DB.DEV_GERRY_MARTS.mart_solde_mensuel
    where
        type_compte = 'epargne'
    
    

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







