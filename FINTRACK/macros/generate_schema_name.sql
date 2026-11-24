{#
  Section 8.2 : choisit le schéma Snowflake selon la target.
  - prod : schéma "propre"  ->  STAGING, MARTS, RAW, SNAPSHOTS
  - dev  : schéma personnel ->  DEV_VOTRENOM_STAGING, DEV_VOTRENOM_MARTS ...
  Ainsi un développeur ne peut jamais écraser les tables de prod.
#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- elif target.name == 'prod' -%}
        {{ custom_schema_name | trim | upper }}
    {%- else -%}
        {{ default_schema }}_{{ custom_schema_name | trim | upper }}
    {%- endif -%}
{%- endmacro %}
