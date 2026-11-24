

with stats as (
    select
        count(*)                                  as nb_lignes,
        count_if(motif is null)       as nb_nulls
    from FINTRACK_DB.DEV_GERRY_STAGING.stg_virements
)

select
    nb_lignes,
    nb_nulls,
    round(nb_nulls * 100.0 / nb_lignes, 2)        as taux_null_pct
from stats
where nb_lignes > 0
  and nb_nulls * 100.0 / nb_lignes > 10

