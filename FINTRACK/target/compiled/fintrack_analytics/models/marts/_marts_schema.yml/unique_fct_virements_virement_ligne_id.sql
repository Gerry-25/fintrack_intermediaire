
    
    

select
    virement_ligne_id as unique_field,
    count(*) as n_records

from FINTRACK_DB.DEV_GERRY_MARTS.fct_virements
where virement_ligne_id is not null
group by virement_ligne_id
having count(*) > 1


