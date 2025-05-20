USE adashi_staging;

/*  select the 5 entries:
-owner_id
-name
-savings_count
-investment_count
-total_deposit */

SELECT

  UC.id AS owner_id,   /* select the owner_id */
  CONCAT (UC.first_name," ",UC.last_name) AS name,   /* select the name */
  COUNT(PP.is_regular_savings) AS savings_count,     /* select the savings_count */
  COUNT(PP.is_a_fund) AS investment_count,         /* select the investment_count */
  SUM(SSA.confirmed_amount) AS total_deposit       /* select the total_deposit */
FROM users_customuser UC, plans_plan PP, savings_savingsaccount SSA

/* implicit join using the users_customuser, savings_savingsaccount, and plans_plan */
WHERE UC.id = PP.owner_id AND PP.owner_id = SSA.owner_id
GROUP BY owner_id
HAVING total_deposit>0 AND savings_count>0 AND investment_count>0
ORDER BY total_deposit
