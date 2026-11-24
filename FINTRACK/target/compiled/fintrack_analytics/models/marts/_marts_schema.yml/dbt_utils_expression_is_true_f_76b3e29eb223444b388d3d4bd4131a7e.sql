



select
    1
from FINTRACK_DB.DEV_GERRY_MARTS.fct_transactions

where not(date_transaction <= current_timestamp()::timestamp_ntz)

