
    
    

select
    categorie_id as unique_field,
    count(*) as n_records

from FINTRACK_DB.DEV_GERRY_STAGING.stg_categories
where categorie_id is not null
group by categorie_id
having count(*) > 1


