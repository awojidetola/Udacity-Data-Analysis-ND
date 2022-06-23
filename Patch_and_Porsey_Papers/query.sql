--FIRST AND LAST ORDERS--

SELECT MIN(occurred_at) AS started_at, MAX(occurred_at) AS ended_at
FROM orders;


--NO. OF SALE REPS IN EACH REGION--
SELECT r.name AS region_name, COUNT(r.name) AS count
FROM sales_reps AS s
JOIN region as r
ON s.region_id = r.id
GROUP BY r.name;

--NO. OF ACCOUNTS HANDELLED BY EACH SALE REPS--
SELECT COUNT(s.name), s.name
FROM accounts AS a
JOIN sales_reps AS s
ON a.sales_rep_id = s.id
GROUP BY s.name;


--FREQUENCY OF CHANNELS--
SELECT channel, COUNT(channel) AS count
FROM web_events
GROUP BY channel
ORDER BY count DESC;

--FREQUENCY OF WEB-EVENTS BY YEAR--
SELECT EXTRACT(YEAR FROM occurred_at) AS YEAR,
COUNT(EXTRACT(YEAR FROM occurred_at)) AS Frequency
FROM web_events
GROUP BY EXTRACT(YEAR FROM occurred_at);

--QUANTITY ORDERS BY ACCOUNTS--
SELECT accounts.name AS account,SUM(standard_qty) AS standard, SUM(poster_qty) AS poster, SUM(gloss_qty) AS gloss
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
GROUP BY accounts.name;

--SUMMARY STATISTICS OF THE TOTAL AMOUNT SPENT ON ORDERS--
SELECT MIN(total_amt_usd), MAX(total_amt_usd), AVG(total_amt_usd)
FROM orders