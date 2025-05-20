USE adashi_staging;
-- 2
/*select the 3 entries:

-Frequency_category

-customer_count

-avg_transaction_per_month*/

SELECT
/* select Frequency_category */
   CASE
      WHEN(
        SELECT(
          COUNT(SSA.transaction_date) /
          TIMESTAMPDIFF (month,
						MIN(SSA.transaction_date),
						MAX(SSA.transaction_date)
						 )
		      ) 
		FROM savings_savingsaccount SSA
          ) >= 10 THEN "High Frequency"
      WHEN(
        SELECT(
          COUNT(SSA.transaction_date) /
          TIMESTAMPDIFF (month,
						MIN(SSA.transaction_date),
						MAX(SSA.transaction_date)
						 )
		      )
		FROM savings_savingsaccount
           ) BETWEEN 3 AND 9  THEN "Medium Frequency"
	  ELSE "Low Frequency"

   END As Frequency_category,

   /* select customer_count */
   COUNT(DISTINCT(UC.id)) AS customer_count,

   /* select avg_transaction_per_month */
	(
   (COUNT(SSA.transaction_date))/
       (SELECT TIMESTAMPDIFF (month,
                     MIN(SSA.transaction_date),
                     MAX(SSA.transaction_date)
                             ) FROM savings_savingsaccount SSA
	   )
	) AS avg_transaction_per_month
      
FROM users_customuser UC, savings_savingsaccount SSA

/* implicit join statement */
WHERE UC.id = SSA.owner_id






