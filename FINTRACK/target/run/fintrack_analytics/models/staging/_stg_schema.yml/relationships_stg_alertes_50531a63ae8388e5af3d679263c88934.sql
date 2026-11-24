
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select type_alerte as from_field
    from FINTRACK_DB.DEV_GERRY_STAGING.stg_alertes
    where type_alerte is not null
),

parent as (
    select code_alerte as to_field
    from FINTRACK_DB.DEV_GERRY_RAW.seuils_alerte
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test