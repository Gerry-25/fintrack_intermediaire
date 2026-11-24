{#
  Section 7.1 : hook on-run-end.
  Ajoute une ligne dans MARTS.dbt_run_log à la fin de chaque commande dbt.
#}
{% macro journaliser_run(results) %}
    {% if execute %}
        {% set ns = namespace(nb_models=0, nb_erreurs=0) %}
        {% for r in results %}
            {% if r.node.resource_type == 'model' %}
                {% set ns.nb_models = ns.nb_models + 1 %}
            {% endif %}
            {% if r.status in ['error', 'fail', 'runtime error'] %}
                {% set ns.nb_erreurs = ns.nb_erreurs + 1 %}
            {% endif %}
        {% endfor %}

        insert into {{ target.database }}.MARTS.dbt_run_log
            (run_id, started_at, completed_at, status, nb_models)
        values (
            '{{ invocation_id }}',
            '{{ run_started_at.strftime("%Y-%m-%d %H:%M:%S") }}'::timestamp_ntz,
            convert_timezone('UTC', current_timestamp())::timestamp_ntz,
            '{{ "error" if ns.nb_erreurs > 0 else "success" }}',
            {{ ns.nb_models }}
        )
    {% else %}
        select 1
    {% endif %}
{% endmacro %}
