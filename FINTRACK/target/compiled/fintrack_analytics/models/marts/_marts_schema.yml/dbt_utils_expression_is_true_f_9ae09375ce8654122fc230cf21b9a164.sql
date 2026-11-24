



select
    1
from FINTRACK_DB.DEV_GERRY_MARTS.fct_virements

where not(compte_source_id != compte_dest_id)

