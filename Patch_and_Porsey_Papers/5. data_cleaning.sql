/*In the accounts table, there is a column holding the website for each company. 
The last three digits specify what type of web address they are using. */

SELECT RIGHT(website,3) AS domain, COUNT(*) AS freq
FROM accounts
GROUP BY domain
ORDER BY freq DESC;

/*There is much debate about how much the name (or even the first letter of a company name) 
matters. Use the accounts table to pull the first letter of each company name to see the
distribution of company names that begin with each letter (or number).*/

SELECT LEFT(name,1) AS first_letter, COUNT(*) AS freq
FROM accounts
GROUP BY first_letter
ORDER BY freq DESC;

/*Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, 
and what percent start with anything else?*/
WITH table1 AS(
SELECT CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') THEN 1 ELSE 0 END AS vowels,
CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') THEN 0 ELSE 1 END AS others
FROM accounts)
SELECT SUM(vowels) AS no_vowels, SUM(others) AS no_others
FROM table1;

/*Use the accounts table to create first and last name columns that hold the first and 
last names for the primary_poc.*/

SELECT primary_poc, LEFT(primary_poc, STRPOS(primary_poc,' ')-1) AS first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - (STRPOS(primary_poc, ' ')-1)) AS last_name
FROM accounts;

/*Now see if you can do the same thing for every rep name in the sales_reps table. 
Again provide first and last name columns.*/

SELECT name, LEFT(name, STRPOS(name,' ')-1) AS first_name,
RIGHT(name, LENGTH(name) - (STRPOS(name, ' ')-1)) AS last_name
FROM sales_reps;

/*Each company in the accounts table wants to create an email address for each primary_poc. 
The email address should be the first name of the primary_poc . last name 
primary_poc @ company name .com. Some company names have trailling spaces that should be removed*/

SELECT CONCAT(LEFT(LOWER(primary_poc), STRPOS(primary_poc,' ')-1),'.',
	  RIGHT(LOWER(primary_poc), LENGTH(primary_poc) - (STRPOS(primary_poc, ' '))),
	  '@',REPLACE(LOWER(name),' ',''),'.com') AS email
FROM accounts

