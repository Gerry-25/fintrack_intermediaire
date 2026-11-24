
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with child as (
    select compte_source_id as from_field
    from FINTRACK_DB.DEV_GERRY_STAGING.stg_virements
    where compte_source_id is not null
),

parent as (
    select compte_id as to_field
    from FINTRACK_DB.DEV_GERRY_STAGING.stg_comptes
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null



  
  
      
    ) dbt_internal_test