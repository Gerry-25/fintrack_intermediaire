{% docs __overview__ %}
# FinTrack Analytics — Pipeline de données

Bienvenue dans la documentation du projet dbt de **FinTrack**, l'application
de gestion de budget personnel.

## Comment les données circulent

1. **RAW** : les données brutes de l'application (comptes, transactions,
   virements, budgets, alertes) arrivent dans Snowflake.
2. **STAGING** : on nettoie et on renomme les colonnes (`stg_*`).
3. **MARTS** : on construit les tables prêtes pour l'analyse :
   - `fct_transactions` et `fct_virements` (faits, incrémentaux)
   - `dim_comptes`, `dim_categories`, `dim_comptes_historique` (dimensions)
   - `mart_solde_mensuel`, `mart_budget_vs_reel` (indicateurs)
4. **Consommateurs** : le dashboard Metabase « Suivi budgétaire client » et
   le rapport « Synthèse mensuelle » (voir les *exposures*).

## Commandes utiles

| Besoin | Commande |
|---|---|
| Tout construire et tester | `dbt build` |
| Seulement les modèles critiques | `dbt build -s tag:critical` |
| Historiser les comptes | `dbt snapshot` |
| Reconstruire une table incrémentale | `dbt run --full-refresh -s fct_transactions` |

Contact : data@fintrack.example
{% enddocs %}
