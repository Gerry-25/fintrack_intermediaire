
    
    

select
    alerte_id as unique_field,
    count(*) as n_records

from FINTRACK_DB.DEV_GERRY_STAGING.stg_alertes
where alerte_id is not null
group by alerte_id
having count(*) > 1


