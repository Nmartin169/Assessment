# COWRYWISE DATA ANALYST ASSESSMENT


## Per-Question Explanations:

### Assessment_Q1.sql

For this question, there were five main entries to be collected using data from tables: users_customuser, savings_savingsaccount, and plans_plan.


1. owner_id: is a column found in the users_customuser table as column “id”. In both savings_savingsaccount, and plans_plan it is found as column owner_id. This gives a foreign key connection which would be used in joining the parent child tables.
2. name: On the basic of an established join between all three tables using the “id”, the name column could be extracted using the CONCAT function on the first_name and last_name column in the users_customuser table.
3. savings_count: Considering that savings in equal to the vale’s of the is_regular_savings Colombia, we can calculate the number of savings using the COUNT function.
4. investment_count: Like the savings count, the investment is equal to the values of the is_a_fund column, hence we calculate using the COUNT function.
5. total_deposits: This is calculated using the confirmed_amount column for a SUM of total confirmed deposits.

The entire query is grouped by the owner_id and the HAVING clause is used to filter for information where total_deposits >0, investment_count>0, and savings_count>0


### Assessment_Q2.sql

A similar approach to assessment one is used, where each entry to be made is considered. In this case only two tables were considered, users_customuser, and savings_savingsaccount. However, seeing that all information required could be gotten from savings_savingsaccount alone, I made it using this table.

1. Frequency_category: A case was made which delivers an impute based on the criteria given in the assessment description: "High Frequency" (≥10 transactions/month), "Medium Frequency" (3-9 transactions/month), "Low Frequency" (≤2 transactions/month). A nested query was used to derive the transaction per month used in the frequency rendering.
2. customer_count: Calculated using the  “owner_id” column from the savings_savingsaccount table and a COUNT function was applied. The information was fetched from a nested query (sub query).
3. avg_transaction_per_month: Calculated by counting the number of transaction dates, grouping the with the unique customers and then dividing the number of transactions by 12 months.

Query was GROUPED BY the frequency to combine all the highs, mediums, and lows, respectively. ORDER BY the average transaction per month to display in descending order of frequency.



### Assessment_Q3.sql

Two tables were also considered here: the plans_plan table, and the savings_savingsaccount table. For the following queries:

1. plan_id: Considering that the plan_id column in the savings_savingsaccount table is equal to the ID column of the plans_plan table, a join is made between the primary and foreign key of both tables. And the input of the value is gotten from the plans_plan table.
2. owner_id: This is a column in the plans_plan table.
3. type: This represents the values in the  description column of the plans_plan table.
4. last_transaction_date: this was queried using the MAX function on the transaction_date column of the savings_savingsaccount table.
5. inactivity_date: This is calculated using the TIMESTAMPDIFF function on the current_timestamp and the max value from the transaction_date column in the savings_savingsaccount table.

The query is joined using the key connection between the ID column of the plans_plan table and the plan_id column of the savings_savingsaccount table.

Grouped by the plan_id column with a clause to render only information with inactivity above 365 days.


### Assessment_Q4.sql

For this as well, five entries were required which were to be queried using the users_customuser table and the savings_savingsaccount table:

1. customer_id: This gotten from the “id” column of the users_customuser table.
2. name: This was queried from the users_customuser table, using the CONCAT function to combine the first_name and last name columns of the customers information.
3. tenure_months: This was calculated using the time
4. total_transactions: Calculate using the COUNT function on the transaction_date column of the savings_savingsaccount table
5. estimated_clv: Considering that this is (total_transactions / tenure_months) * 12 * avg_profit_per_transaction, the total transaction was gotten by counting the transaction_date column of the savings_savingsaccount table. tenure_month is calculated as the difference in timestamp for MAX and MIN values. The AVG function is used to find the average profit per transaction considering that profit_per_transaction = 0.1*(confirmed_amount). With confirmed amount being a column on the savings_savingsaccount table.

The entire query is  combined using the “id” column from the users_customuser table and the owner_id column from the savings_savingsaccount table. Grouped by customer_id, and ordered by estimated_clv in descending order. Using the DESC function.l after the ORDER BY clause



## Challenges

The major challenge was found in the adaptability of the sql script which contained the creation of the tables and databases on other servers aside MySQL as it took a long time to eventually figure that certain functions like LARGETEXT which is a data type used in building the table were only used in the MYSQL server, hence the clue to switch to the MySQL server, which worked very fine.

Other difficulties were in writing and the complexity of getting by aggregate functions limiting my entries to an OK report with no table fetched. In Assessment_Q3.sql and Assessment_Q4 the difficulty go getting by nested and subqueries also proved to have been a challenge.

Many other difficulties were in the inability to accrue all the information required from the designated table to be used for each questions. Like how inactive days could best be gotten from the difference between the last login and the current timestamp however the table in which the last login information is wasn’t recommended in the assessment overview.
