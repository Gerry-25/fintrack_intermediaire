
    
        
        

        insert into FINTRACK_DB.MARTS.dbt_run_log
            (run_id, started_at, completed_at, status, nb_models)
        values (
            '977b6d1c-6e4c-49a3-bc56-2d36b272564e',
            '2026-11-24 08:09:40'::timestamp_ntz,
            convert_timezone('UTC', current_timestamp())::timestamp_ntz,
            'success',
            0
        )
    
