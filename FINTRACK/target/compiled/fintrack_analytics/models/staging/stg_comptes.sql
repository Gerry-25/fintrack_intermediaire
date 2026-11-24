with source as (
    select * from FINTRACK_DB.RAW.raw_comptes
)

select
    id          as compte_id,
    nom_client,
    email,
    type_compte,
    date_ouverture,
    solde_initial,
    lower(statut) as statut

from source