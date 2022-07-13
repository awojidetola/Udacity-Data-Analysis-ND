/*The average amount of standard paper, gloss paper, poster paper and total
sold on the first month that any order was placed in the orders table (in terms of quantity).*/

SELECT AVG(standard_qty) AS standard_qty, AVG(poster_qty) AS poster_qty, AVG(gloss_qty) AS gloss_qty,
AVG(total) AS total_qty
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
(SELECT(DATE_TRUNC('month', MIN(occurred_at))) FROM orders);

/*Using CTEs*/
WITH table1 AS(
SELECT DATE_TRUNC('month', MIN(occurred_at)) FROM orders)

SELECT AVG(standard_qty) AS standard_qty, AVG(poster_qty) AS poster_qty, AVG(gloss_qty) AS gloss_qty,
AVG(total) AS total_qty
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
(SELECT * FROM table1)