/*Find the total amount of poster_qty paper ordered in the orders table.*/
SELECT SUM(poster_qty) AS total_qty
FROM orders;

/*Find the total amount of standard_qty paper ordered in the orders table.*/
SELECT SUM(standard_qty) AS total_qty
FROM orders;

/*Find the total dollar amount of sales using the total_amt_usd in the orders table.*/
SELECT SUM(total_amt_usd) AS total_amount
FROM orders;

/*Find the total amount spent on standard_amt_usd and gloss_amt_usd 
paper for each order in the orders table.
This should give a dollar amount for each order in the table.*/

SELECT SUM(standard_amt_usd) AS standard_total, SUM(gloss_amt_usd) AS gloss_total
FROM orders;

/*Find the standard_amt_usd per unit of standard_qty paper.
Your solution should use both an aggregation and a mathematical operator.*/

SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_per_unit
FROM orders;

/*When was the earliest order ever placed? You only need to return the date.*/

SELECT MIN(occurred_at) earliest
FROM orders;

/*Performing the query above without using Aggregation*/

SELECT occurred_at earliest
FROM orders
ORDER BY occurred_at
LIMIT 1;

/*When did the most recent (latest) web_event occur?*/

SELECT occurred_at recent
FROM orders
ORDER BY occurred_at DESC
LIMIT 1;

SELECT MAX(occurred_at) recent
FROM orders;

/*Find the mean (AVERAGE) amount spent per order on each paper type, 
as well as the mean amount of each paper type purchased per order. 
Your final answer should have 6 values - one for each paper type for 
the average number of sales, as well as the average amount.*/

SELECT AVG(standard_amt_usd), AVG(total_amt_usd), AVG(poster_amt_usd), 
AVG(standard_qty), AVG(total), AVG(poster_qty)
FROM orders;

/*Which account (by name) placed the earliest order? 
Your solution should have the account name and the date of the order.*/

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

/*Find the total sales in usd for each account. You should include two columns - 
the total sales for each company's orders in usd and the company name.*/

SELECT a.name,SUM(o.total_amt_usd) AS total_sales
FROM orders AS o
JOIN accounts AS a
ON a.id = o.account_id
GROUP BY a.name;

/*Via what channel did the most recent (latest) web_event occur, 
which account was associated with this web_event? 
Your query should return only three values - the date, channel, and account name.*/

SELECT w.occurred_at,w.channel, a.name
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

/*Find the total number of times each type of channel from the web_events was used. 
Your final table should have two columns - the channel and the number of times the 
channel was used.*/

SELECT w.channel, COUNT(*) AS count
FROM web_events AS w
GROUP BY w.channel;

/*Who was the primary contact associated with the earliest web_event?*/
SELECT a.primary_poc, w.occurred_at
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

/*What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. 
Order from smallest dollar amounts to largest, where total amount is greater than 0*/

SELECT a.name, MIN(o.total_amt_usd) AS min
FROM accounts AS a
JOIN orders AS o
ON o.account_id = a.id
GROUP BY a.name
HAVING MIN(o.total_amt_usd) > 0
ORDER BY min;

/*Find the number of sales reps in each region. Your final table should have two columns
the region and the number of sales_reps. Order from fewest reps to most reps.*/

SELECT r.name, COUNT(*) AS no_sales_rep
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY no_sales_rep;

/*Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. 
Do you notice any trends in the yearly sales totals?*/

SELECT DATE_PART('year', occurred_at) AS year,  SUM(total_amt_usd) AS total_amount
FROM orders
GROUP BY year
ORDER BY total_amount DESC;

/*Which month did Parch & Posey have the greatest sales in terms of total dollars? 
Are all months evenly represented by the dataset?*/
SELECT DATE_PART('month', occurred_at) AS month,  SUM(total_amt_usd) AS total_amount
FROM orders
GROUP BY month
ORDER BY total_amount DESC;

/*Which year did Parch & Posey have the greatest sales in terms of total number of orders?
Are all years evenly represented by the dataset?*/

SELECT DATE_PART('year', occurred_at) AS year, COUNT(*) AS no_orders
FROM orders
GROUP BY year
ORDER BY no_orders DESC;

/*Which month did Parch & Posey have the greatest sales in terms of total number of 
orders? Are all months evenly represented by the dataset?*/

SELECT DATE_PART('month', occurred_at) AS month, COUNT(*) AS no_orders
FROM orders
GROUP BY month
ORDER BY no_orders DESC;

/*In which month of which year did Walmart spend the most on gloss paper in terms of dollars?*/
SELECT DATE_TRUNC('month',o.occurred_at) AS month, SUM(o.gloss_amt_usd) AS gloss_amt
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY month
ORDER BY gloss_amt DESC
LIMIT 1;

/*Write a query to display for each order, the account ID, total amount of the order
and the level of the order - ‘Large’ or ’Small’ - depending on if the order is $3000 
or more, or smaller than $3000.*/

SELECT id, total_amt_usd, 
CASE WHEN total_amt_usd > 3000 THEN 'Large' ELSE 'Small' END AS case
FROM orders;

/*Write a query to display the number of orders in each of three categories, 
based on the total number of items in each order. The three categories are: 
'At Least 2000', 'Between 1000 and 2000' and 'Less than 1000'.*/

SELECT id, total AS no_orders, 
CASE WHEN
total >=2000 THEN 'At Least 2000' 
WHEN total BETWEEN 1000 AND 2000 THEN 'Between 1000 and 2000'
ELSE 'Less than 1000' END AS total_quantity_discretized
FROM orders;

/*We would like to identify top performing sales reps, which are sales reps 
associated with more than 200 orders. Create a table with the sales rep name, 
the total number of orders, and a column with top or not depending on if they 
have more than 200 orders.
Place the top sales people first in your final table.*/

SELECT s.name, COUNT(*) AS count, 
CASE WHEN 
COUNT(*) > 200 THEN 'TOP' ELSE 'NOT' END AS position
FROM sales_reps AS s
JOIN accounts AS a
ON a.sales_rep_id = s.id
JOIN orders AS o
ON o.account_id = a.id
GROUP BY s.name
ORDER BY count DESC;