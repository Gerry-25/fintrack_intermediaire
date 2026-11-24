{# Section 5.2 : transforme une date / un timestamp en texte 'YYYY-MM' #}
{% macro generer_periode(colonne_date) -%}
    to_char({{ colonne_date }}, 'YYYY-MM')
{%- endmacro %}
