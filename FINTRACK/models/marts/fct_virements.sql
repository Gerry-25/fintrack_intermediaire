-- ============================================================
-- fct_virements — modèle INCRÉMENTAL (Section 3.2)
-- Un virement = 2 lignes :
--   * 'sortant' pour le compte source (montant négatif)
--   * 'entrant' pour le compte destination (montant positif)
-- Seuls les virements exécutés sont gardés.
-- ============================================================

{{
    config(
        materialized = 'incremental',
        unique_key = 'virement_ligne_id',
        incremental_strategy = 'merge',
        tags = ['critical']
    )
}}

with virements as (
    select * from {{ ref('stg_virements') }}
    where statut = 'execute'

    {% if is_incremental() %}
      and date_virement >= (
          select dateadd('day', -{{ var('jours_recul', 7) }}, max(date_virement))
          from {{ this }}
      )
    {% endif %}
),

comptes as (
    select compte_id, nom_client from {{ ref('stg_comptes') }}
),

lignes as (
    -- côté compte source : l'argent sort
    select
        virement_id,
        'sortant'           as sens,
        compte_source_id    as compte_id,
        compte_dest_id      as compte_contrepartie_id,
        compte_source_id,
        compte_dest_id,
        montant,
        -montant            as montant_signe,
        date_virement,
        motif
    from virements

    union all

    -- côté compte destination : l'argent arrive
    select
        virement_id,
        'entrant'           as sens,
        compte_dest_id      as compte_id,
        compte_source_id    as compte_contrepartie_id,
        compte_source_id,
        compte_dest_id,
        montant,
        montant             as montant_signe,
        date_virement,
        motif
    from virements
)

select
    l.virement_id || '-' || l.sens          as virement_ligne_id,
    l.virement_id,
    l.sens,
    l.compte_id,
    c.nom_client,
    l.compte_contrepartie_id,
    cc.nom_client                           as nom_client_contrepartie,
    l.compte_source_id,
    l.compte_dest_id,
    l.montant,
    {{ convertir_centimes('l.montant') }}   as montant_centimes,
    l.montant_signe,
    l.date_virement,
    date_trunc('month', l.date_virement)::date as mois_virement,
    {{ generer_periode('l.date_virement') }} as periode,
    l.motif

from lignes l
left join comptes c  on l.compte_id = c.compte_id
left join comptes cc on l.compte_contrepartie_id = cc.compte_id
