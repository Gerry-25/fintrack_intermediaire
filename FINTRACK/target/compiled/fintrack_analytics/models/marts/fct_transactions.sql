-- ============================================================
-- fct_transactions — modèle INCRÉMENTAL (Section 3.1)
-- ============================================================
-- 1. Marqueur incrémental : date_transaction
-- 2. Full refresh : `dbt run --full-refresh -s fct_transactions`
--    reconstruit toute la table depuis zéro.
-- 3. Changement de statut (en_attente -> validee) : à chaque run on
--    relit les N derniers jours (var jours_recul, 7 par défaut).
--    Grâce à unique_key + merge, une transaction déjà présente est
--    mise à jour au lieu d'être dupliquée, et une transaction validée
--    en retard est ajoutée.
-- ============================================================



with  __dbt__cte__int_transactions_enrichies as (
with transactions as (
    select * from FINTRACK_DB.DEV_GERRY_STAGING.stg_transactions
),

comptes as (
    select * from FINTRACK_DB.DEV_GERRY_STAGING.stg_comptes
),

categories as (
    select * from FINTRACK_DB.DEV_GERRY_STAGING.stg_categories
)

select
    t.transaction_id,
    t.compte_id,
    t.date_transaction,
    t.montant,
    t.montant_signe,
    t.type_operation,
    t.categorie_id,
    t.description,
    t.statut,
    -- mois sous forme de date (utile pour la jointure avec les budgets)
    date_trunc('month', t.date_transaction)::date as mois_transaction,
    -- mois sous forme de texte YYYY-MM (macro maison)
    to_char(t.date_transaction, 'YYYY-MM') as periode,

    c.nom_client,
    c.type_compte,

    cat.nom_categorie,
    cat.type_categorie,
    cat.groupe

from transactions t
left join comptes c on t.compte_id = c.compte_id
left join categories cat on t.categorie_id = cat.categorie_id
), enrichies as (
    select * from __dbt__cte__int_transactions_enrichies
    where statut = 'validee'

    
      -- on ne relit que les données récentes (+ une marge de sécurité)
      and date_transaction >= (
          select dateadd('day', -7, max(date_transaction))
          from FINTRACK_DB.DEV_GERRY_MARTS.fct_transactions
      )
    
)

select
    transaction_id,
    compte_id,
    categorie_id,
    date_transaction,
    mois_transaction,
    periode,
    montant,
    cast(round(montant * 100, 0) as integer) as montant_centimes,
    montant_signe,
    type_operation,
    nom_client,
    nom_categorie,
    groupe,
    statut,
    current_timestamp()::timestamp_ntz as dbt_charge_le

from enrichies