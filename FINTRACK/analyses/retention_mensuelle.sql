-- Bonus 9.1 : taux de rétention mensuel
-- Un compte est "actif" un mois s'il a au moins une transaction validée.
-- Rétention du mois M = part des comptes actifs en M-1 encore actifs en M.
-- Compiler avec : dbt compile -s retention_mensuelle
-- puis exécuter le SQL généré dans target/compiled/... sur Snowflake.

with actifs as (
    select distinct
        compte_id,
        mois_transaction as mois
    from {{ ref('fct_transactions') }}
),

paires as (
    select
        a.mois,
        a.compte_id,
        iff(b.compte_id is not null, 1, 0) as actif_mois_suivant
    from actifs a
    left join actifs b
        on a.compte_id = b.compte_id
       and b.mois = dateadd('month', 1, a.mois)
)

select
    dateadd('month', 1, mois)                  as mois,
    count(*)                                   as actifs_mois_precedent,
    sum(actif_mois_suivant)                    as toujours_actifs,
    round(100 * sum(actif_mois_suivant) / count(*), 1) as taux_retention_pct
from paires
where dateadd('month', 1, mois) <= (select max(mois) from actifs)
group by 1
order by 1
