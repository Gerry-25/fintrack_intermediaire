
    
    

select
    virement_id as unique_field,
    count(*) as n_records

from FINTRACK_DB.DEV_GERRY_STAGING.stg_virements
where virement_id is not null
group by virement_id
having count(*) > 1


