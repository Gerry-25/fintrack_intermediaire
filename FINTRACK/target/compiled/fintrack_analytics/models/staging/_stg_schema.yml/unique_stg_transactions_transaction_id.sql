
    
    

select
    transaction_id as unique_field,
    count(*) as n_records

from FINTRACK_DB.DEV_GERRY_STAGING.stg_transactions
where transaction_id is not null
group by transaction_id
having count(*) > 1


