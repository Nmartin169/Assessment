USE adashi_staging;
-- 4
/*  select the 5 entries:
-customer_id
-name
-tenure_months
-total_transaction
-estimated_clv */

SELECT 
   UC.id AS customer_id,    /* select the customer_id */
   CONCAT (UC.first_name," ",UC.last_name) AS name,        /* select the name */
   TIMESTAMPDIFF(month, 
				  (SELECT MIN(SSA.transaction_date)
                     FROM savings_savingsaccount SSA
				   ),
				   (SELECT MAX(SSA.transaction_date)
                     FROM savings_savingsaccount SSA
				   )
                   )  AS tenure_months,                /* select the tenure_months */
   count(SSA.transaction_date) AS total_transaction,    /* select the total_transaction */
   (SELECT
	 count(SSA.transaction_date) /
	 TIMESTAMPDIFF(month, 
				  (SELECT MIN(SSA.transaction_date)
                     FROM savings_savingsaccount SSA
				   ),
				   (SELECT MAX(SSA.transaction_date)
                     FROM savings_savingsaccount SSA
				   )
                   ) *12*
	 (AVG(0.1*(SSA.confirmed_amount)))
	FROM savings_savingsaccount SSA
   )  AS estimated_clv                             /* select the estimated_clv */

FROM users_customuser UC, savings_savingsaccount SSA

/* implicit join using the users_customuser, savings_savingsaccount */
WHERE UC.id = SSA.owner_id
GROUP BY customer_id
ORDER BY estimated_clv DESC

