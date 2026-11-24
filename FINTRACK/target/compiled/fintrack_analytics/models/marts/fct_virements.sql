-- ============================================================
-- fct_virements — modèle INCRÉMENTAL (Section 3.2)
-- Un virement = 2 lignes :
--   * 'sortant' pour le compte source (montant négatif)
--   * 'entrant' pour le compte destination (montant positif)
-- Seuls les virements exécutés sont gardés.
-- ============================================================



with virements as (
    select * from FINTRACK_DB.DEV_GERRY_STAGING.stg_virements
    where statut = 'execute'

    
      and date_virement >= (
          select dateadd('day', -7, max(date_virement))
          from FINTRACK_DB.DEV_GERRY_MARTS.fct_virements
      )
    
),

comptes as (
    select compte_id, nom_client from FINTRACK_DB.DEV_GERRY_STAGING.stg_comptes
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
    cast(round(l.montant * 100, 0) as integer)   as montant_centimes,
    l.montant_signe,
    l.date_virement,
    date_trunc('month', l.date_virement)::date as mois_virement,
    to_char(l.date_virement, 'YYYY-MM') as periode,
    l.motif

from lignes l
left join comptes c  on l.compte_id = c.compte_id
left join comptes cc on l.compte_contrepartie_id = cc.compte_id