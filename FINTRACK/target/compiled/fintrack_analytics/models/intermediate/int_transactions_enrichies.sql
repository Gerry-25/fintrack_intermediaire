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