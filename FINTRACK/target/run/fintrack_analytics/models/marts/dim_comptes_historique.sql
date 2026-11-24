
  
    

create or replace transient table FINTRACK_DB.DEV_GERRY_MARTS.dim_comptes_historique
    
    
    
    
    

    as (-- Historique des comptes (SCD Type 2) à partir du snapshot (Section 4.2)
with snap as (
    select * from FINTRACK_DB.DEV_GERRY_SNAPSHOTS.snap_comptes
)

select
    dbt_scd_id                          as version_id,
    id                                  as compte_id,
    nom_client,
    email,
    type_compte,
    lower(statut)                       as statut,
    dbt_valid_from                      as valide_depuis,
    dbt_valid_to                        as valide_jusqu_a,
    dbt_valid_to is null                as est_version_courante,
    datediff(
        'day',
        dbt_valid_from,
        coalesce(dbt_valid_to, current_timestamp()::timestamp_ntz)
    )                                   as duree_version_jours

from snap
    )
;


  