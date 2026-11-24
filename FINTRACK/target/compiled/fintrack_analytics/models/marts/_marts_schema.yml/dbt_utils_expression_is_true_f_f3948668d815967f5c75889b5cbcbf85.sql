



select
    1
from FINTRACK_DB.DEV_GERRY_MARTS.fct_transactions

where not((type_operation = 'debit' and montant_signe < 0) or (type_operation = 'credit' and montant_signe > 0))

