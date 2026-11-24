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

{{
    config(
        materialized = 'incremental',
        unique_key = 'transaction_id',
        incremental_strategy = 'merge',
        on_schema_change = 'append_new_columns',
        tags = ['critical'],
        pre_hook = [
            "create table if not exists {{ this.database }}.{{ this.schema }}.dbt_watermark_log (
                modele varchar, max_date_traitee timestamp_ntz,
                logged_at timestamp_ntz, invocation_id varchar)",
            "{{ journaliser_watermark('date_transaction') }}"
        ]
    )
}}

with enrichies as (
    select * from {{ ref('int_transactions_enrichies') }}
    where statut = 'validee'

    {% if is_incremental() %}
      -- on ne relit que les données récentes (+ une marge de sécurité)
      and date_transaction >= (
          select dateadd('day', -{{ var('jours_recul', 7) }}, max(date_transaction))
          from {{ this }}
      )
    {% endif %}
)

select
    transaction_id,
    compte_id,
    categorie_id,
    date_transaction,
    mois_transaction,
    periode,
    montant,
    {{ convertir_centimes('montant') }} as montant_centimes,
    montant_signe,
    type_operation,
    nom_client,
    nom_categorie,
    groupe,
    statut,
    current_timestamp()::timestamp_ntz as dbt_charge_le

from enrichies
