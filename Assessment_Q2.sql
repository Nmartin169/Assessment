USE adashi_staging;
-- 2
/*select the 3 entries:
-Frequency_category
-customer_count
-avg_transaction_per_month*/

SELECT
   CASE
      WHEN transactions_per_month >= 10 THEN "High Frequency"
      WHEN transactions_per_month BETWEEN 3 AND 9  THEN "Medium Frequency"
      ELSE "Low Frequency"
   END As Frequency_category,                                    /* select Frequency_category */
   COUNT(customer) AS customer_count,                            /* select customer_count */
   AVG(transactions_per_month) AS avg_transactions_per_month     /* select avg_transaction_per_month */
FROM
   (SELECT
	    SSA.owner_id AS customer,
		COUNT(SSA.transaction_date)/12 AS transactions_per_month    /*divide number of transaction by 12 month*/
	FROm
	    savings_savingsaccount SSA
	GROUP BY 
	    customer
	) AS q1 
GROUP BY Frequency_category                       /* To show the frequency category first)
ORDER BY avg_transactions_per_month DESC          /* Set to descending order of avg_transactions_per_month*/


   