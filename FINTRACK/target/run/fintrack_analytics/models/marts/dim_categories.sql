
  
    

create or replace transient table FINTRACK_DB.DEV_GERRY_MARTS.dim_categories
    
    
    
    
    

    as (-- Catégories enrichies avec le seed mapping_groupes (Partie 2)
with categories as (
    select * from FINTRACK_DB.DEV_GERRY_STAGING.stg_categories
),

mapping as (
    select * from FINTRACK_DB.DEV_GERRY_RAW.mapping_groupes
)

select
    c.categorie_id,
    c.nom_categorie,
    c.type_categorie,
    c.groupe,
    m.ordre_affichage,
    m.priorite_dashboard

from categories c
left join mapping m on c.groupe = m.groupe
    )
;


  