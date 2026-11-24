{#
  Section 5.3 : test générique maison.
  Échoue si le % de valeurs NULL de la colonne dépasse seuil_pct.
  Utilisation dans un .yml :
      - taux_null:
          seuil_pct: 10
#}
{% test taux_null(model, column_name, seuil_pct=10) %}

with stats as (
    select
        count(*)                                  as nb_lignes,
        count_if({{ column_name }} is null)       as nb_nulls
    from {{ model }}
)

select
    nb_lignes,
    nb_nulls,
    round(nb_nulls * 100.0 / nb_lignes, 2)        as taux_null_pct
from stats
where nb_lignes > 0
  and nb_nulls * 100.0 / nb_lignes > {{ seuil_pct }}

{% endtest %}
