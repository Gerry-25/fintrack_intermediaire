
  
    

create or replace transient table FINTRACK_DB.DEV_GERRY_MARTS.mart_solde_mensuel
    
    
    
    
    

    as (-- ============================================================
-- mart_solde_mensuel (Section 3.3)
-- Solde mensuel par compte = transactions + virements internes.
--
-- Matérialisation : TABLE (pas incrémental).
-- Le solde cumulé dépend de TOUS les mois précédents (fonction de
-- fenêtre). En incrémental, une correction sur un vieux mois ne serait
-- pas répercutée sur les mois suivants. La table est petite
-- (1 ligne par compte et par mois) : la reconstruire coûte peu.
-- ============================================================

with flux_transactions as (
    select
        compte_id,
        periode,
        case when type_operation = 'credit' then montant else 0 end as credit,
        case when type_operation = 'debit'  then montant else 0 end as debit,
        0 as virement_entrant,
        0 as virement_sortant,
        montant_signe
    from FINTRACK_DB.DEV_GERRY_MARTS.fct_transactions
),

flux_virements as (
    select
        compte_id,
        periode,
        0 as credit,
        0 as debit,
        case when sens = 'entrant' then montant else 0 end as virement_entrant,
        case when sens = 'sortant' then montant else 0 end as virement_sortant,
        montant_signe
    from FINTRACK_DB.DEV_GERRY_MARTS.fct_virements
),

flux as (
    select * from flux_transactions
    union all
    select * from flux_virements
),

mensuel as (
    select
        compte_id,
        periode,
        sum(credit)            as total_credits,
        sum(debit)             as total_debits,
        sum(virement_entrant)  as total_virements_entrants,
        sum(virement_sortant)  as total_virements_sortants,
        sum(montant_signe)     as solde_net_mois
    from flux
    group by compte_id, periode
),

comptes as (
    select compte_id, nom_client, type_compte, solde_initial
    from FINTRACK_DB.DEV_GERRY_MARTS.dim_comptes
)

select
    m.compte_id,
    c.nom_client,
    c.type_compte,
    m.periode,
    m.total_credits,
    m.total_debits,
    m.total_virements_entrants,
    m.total_virements_sortants,
    m.solde_net_mois,
    c.solde_initial + sum(m.solde_net_mois) over (
        partition by m.compte_id
        order by m.periode
        rows between unbounded preceding and current row
    ) as solde_cumule

from mensuel m
inner join comptes c on m.compte_id = c.compte_id
    )
;


  