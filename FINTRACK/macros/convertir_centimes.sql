{# Section 5.1 : convertit un montant en euros en centimes (entier) #}
{% macro convertir_centimes(colonne) -%}
    cast(round({{ colonne }} * 100, 0) as integer)
{%- endmacro %}
