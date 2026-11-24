{#
  Section 4.1 : snapshot SCD Type 2 des comptes.
  raw_comptes n'a pas de colonne "updated_at" -> stratégie "check" :
  dbt compare les colonnes listées et crée une nouvelle version
  dès que l'une d'elles change.
#}
{% snapshot snap_comptes %}

{{
    config(
        unique_key = 'id',
        strategy = 'check',
        check_cols = ['statut', 'email', 'type_compte'],
        schema = 'snapshots'
    )
}}

select * from {{ source('fintrack_raw', 'raw_comptes') }}

{% endsnapshot %}
