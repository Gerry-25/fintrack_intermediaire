-- Alertes de budget, enrichies avec le seed seuils_alerte
with source as (
    select * from {{ source('fintrack_raw', 'raw_alertes') }}
),

seuils as (
    select * from {{ ref('seuils_alerte') }}
)

select
    a.id                                as alerte_id,
    a.compte_id,
    a.categorie_id,
    a.mois::date                        as mois,
    a.type_alerte,
    s.seuil_pct,
    s.severite,
    s.description                       as description_alerte,
    a.montant_prevu,
    a.montant_reel,
    round(a.montant_reel * 100 / nullif(a.montant_prevu, 0), 1) as taux_consommation_pct,
    a.date_generation::timestamp_ntz    as date_generation,
    a.acquittee

from source a
left join seuils s on a.type_alerte = s.code_alerte
