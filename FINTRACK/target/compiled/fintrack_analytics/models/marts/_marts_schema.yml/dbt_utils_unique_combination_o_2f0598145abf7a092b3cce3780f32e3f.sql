





with validation_errors as (

    select
        compte_id, periode
    from FINTRACK_DB.DEV_GERRY_MARTS.mart_solde_mensuel
    group by compte_id, periode
    having count(*) > 1

)

select *
from validation_errors


