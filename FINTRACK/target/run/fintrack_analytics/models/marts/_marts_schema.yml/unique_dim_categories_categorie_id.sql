
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    categorie_id as unique_field,
    count(*) as n_records

from FINTRACK_DB.DEV_GERRY_MARTS.dim_categories
where categorie_id is not null
group by categorie_id
having count(*) > 1



  
  
      
    ) dbt_internal_test