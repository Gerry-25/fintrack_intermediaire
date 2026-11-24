
  create or replace   view FINTRACK_DB.DEV_GERRY_STAGING.stg_virements
  
  
  
  
  as (
    -- Virements entre deux comptes FinTrack : on renomme les colonnes
with source as (
    select * from FINTRACK_DB.RAW.raw_virements
)

select
    id                                  as virement_id,
    compte_source_id,
    compte_dest_id,
    montant,
    date_virement::timestamp_ntz        as date_virement,
    motif,
    lower(statut)                       as statut

from source
  );

