{#
  Section 7.2 : pre-hook de fct_transactions.
  Avant chaque run, on note la date la plus récente déjà présente
  dans la table (le "watermark"), dans la table dbt_watermark_log.
  Au tout premier run la table n'existe pas encore : on ne fait rien.
#}
{% macro journaliser_watermark(colonne_date) %}
    {% if execute %}
        {% set relation = adapter.get_relation(
            database=this.database, schema=this.schema, identifier=this.identifier) %}
        {% if relation is not none %}
            insert into {{ this.database }}.{{ this.schema }}.dbt_watermark_log
                (modele, max_date_traitee, logged_at, invocation_id)
            select
                '{{ this.identifier }}',
                max({{ colonne_date }}),
                current_timestamp()::timestamp_ntz,
                '{{ invocation_id }}'
            from {{ this }}
        {% else %}
            select 1 /* premier run : rien à journaliser */
        {% endif %}
    {% else %}
        select 1
    {% endif %}
{% endmacro %}
