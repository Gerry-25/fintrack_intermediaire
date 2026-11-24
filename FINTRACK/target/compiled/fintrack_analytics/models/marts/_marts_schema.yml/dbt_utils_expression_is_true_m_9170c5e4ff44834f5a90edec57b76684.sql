



select
    1
from FINTRACK_DB.DEV_GERRY_MARTS.mart_budget_vs_reel

where not(depassement = (ecart < 0))

