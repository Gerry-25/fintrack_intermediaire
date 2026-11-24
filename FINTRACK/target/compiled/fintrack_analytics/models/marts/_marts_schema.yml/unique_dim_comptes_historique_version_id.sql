
    
    

select
    version_id as unique_field,
    count(*) as n_records

from FINTRACK_DB.DEV_GERRY_MARTS.dim_comptes_historique
where version_id is not null
group by version_id
having count(*) > 1


