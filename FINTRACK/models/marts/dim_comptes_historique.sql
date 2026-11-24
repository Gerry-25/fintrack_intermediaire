-- Historique des comptes (SCD Type 2) à partir du snapshot (Section 4.2)
with snap as (
    select * from {{ ref('snap_comptes') }}
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
