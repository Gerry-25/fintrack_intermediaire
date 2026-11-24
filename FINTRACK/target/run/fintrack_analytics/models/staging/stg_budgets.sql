
  create or replace   view FINTRACK_DB.DEV_GERRY_STAGING.stg_budgets
  
  
  
  
  as (
    with source as (
    select * from FINTRACK_DB.RAW.raw_budgets
)

select
    id              as budget_id,
    compte_id,
    categorie_id,
    mois::date      as mois,
    montant_prevu

from source
  );

