USE adashi_staging;
-- 3

/* write queries for 
-plan_id, 
-owner_id, 
-type, 
-last_transaction_date, 
inactivity_days */

SELECT
     PP.ID as plan_id,         /* select plan_id */
     PP.owner_id as owner_id,     /* select owner_id */
     PP.description as type,     /* select type */
     MAX(SSA.transaction_date) as  last_transaction_date,      /* select last_transaction_date */
     TIMESTAMPDIFF(day, 
				  (SELECT MIN(SSA.transaction_date)
                     FROM savings_savingsaccount SSA
				   ),
				   (SELECT MAX(SSA.transaction_date)
                     FROM savings_savingsaccount SSA
				   )
                   ) as inactivity_days                  /* select values for inactivity_days */

FROM plans_plan PP, savings_savingsaccount SSA

/* implicit joint between plans_plan PP savings_savingsaccount SSA */
WHERE PP.ID = SSA.plan_id

GROUP BY plan_id
HAVING inactivity_days > 365