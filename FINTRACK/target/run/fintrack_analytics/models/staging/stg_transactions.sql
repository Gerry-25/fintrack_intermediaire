
  create or replace   view FINTRACK_DB.DEV_GERRY_STAGING.stg_transactions
  
  
  
  
  as (
    with source as (
    select * from FINTRACK_DB.RAW.raw_transactions
)

select
    id              as transaction_id,
    compte_id,
    date_transaction::timestamp_ntz as date_transaction,
    montant,
    type_operation,
    categorie_id,
    description,
    statut,
    case
        when type_operation = 'credit' then montant
        when type_operation = 'debit'  then -montant
    end as montant_signe

from source
  );

