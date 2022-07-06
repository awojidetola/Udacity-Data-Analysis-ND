/* Pull the standard_qty, gloss_qty, and poster_qty from the 
orders table, and the website and the primary_poc 
from the accounts table.*/

SELECT o.standard_qty, o.gloss_qty, o.poster_qty, a.website, a.primary_poc
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
LIMIT 10;

/*Provide a table for all web_events associated with account name of Walmart. 
There should be three columns. Be sure to include the primary_poc, time of the event, 
and the channel for each event. Additionally, you might choose to add a 
fourth column to assure only Walmart events were chosen.*/

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events AS w
JOIN accounts AS a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

/*Provide a table that provides the region for each sales_rep 
along with their associated accounts. Your final table should include three columns: 
the region name, the sales rep name, and the account name. 
Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT region.name AS region_name, sales_reps.name AS sales_rep_name, accounts.name AS account_name
FROM sales_reps
JOIN region
ON sales_reps.region_id = region.id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id;

/*Provide a table that provides the region for each sales_rep 
along with their associated accounts. This time only for the Midwest region. 
Your final table should include three columns: the region name, the sales 
rep name, and the account name. Sort the accounts alphabetically (A-Z) according 
to account name.*/

SELECT s.name AS sales_rep, r.name AS region, a.name AS account_name
FROM sales_reps AS s
JOIN region AS r
ON s.region_id = r.id
JOIN accounts AS a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY r.name;

/*Provide a table that provides the region for each sales_rep 
along with their associated accounts. This time only for accounts 
where the sales rep has a first name starting with S and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, 
and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/

SELECT r.name AS region, s.name AS sale_rep, a.name AS account_name
FROM sales_reps AS s
JOIN region AS r
ON s.region_id = r.id
JOIN accounts AS a
ON a.sales_rep_id = s.id
where s.name LIKE ('S%') AND r.name ='Midwest'
ORDER BY a.name;

/*Provide a table that provides the region for each sales_rep along 
with their associated accounts. This time only for accounts where the sales 
rep has a last name starting with K and in the Midwest region. 
Your final table should include three columns: the region name, the sales rep name, 
and the account name. Sort the accounts alphabetically (A-Z) according to account name.*/
SELECT r.name AS region, s.name AS sales_rep, a.name AS account_name
FROM sales_reps AS s
JOIN region AS r
ON r.id = s.region_id
JOIN accounts AS a
ON a.sales_rep_id = s.id
WHERE s.name LIKE ('% K%') AND r.name = 'Midwest'
ORDER BY a.name;

/*Find all the orders that occurred in 2015. 
Your final table should have 4 columns: occurred_at, account name, 
order total, and order total_amt_usd.*/

SELECT a.name, o.occurred_at, o.total, o.total_amt_usd
FROM orders AS o
JOIN accounts AS a
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016';

/*What are the different channels used by account id 1001? 
Your final table should have only 2 columns: account name and the different channels.*/

SELECT DISTINCT w.channel, a.name
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE a.id = '1001'