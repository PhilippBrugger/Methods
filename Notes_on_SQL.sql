### These notes are based on Udacitys Data Analyst Nanodegree

### Seeting display limits with LIMIT
/* This is how I will keep my SQL notes during this course.
The selected columns from the table web_events are queried and the result is limited to 15 rows to keep it neat.
*/
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

###  Filtering with ORDER BY
/* The ORDER BY command can be used to order by the data in a specific column.
By derault this will be ascending, i.e. a-z, small to high and early to late.
If I want to change that the command is DESC.
The ORDER BY statement is always after the SELECT and FROM statements, but it is before the LIMIT statement.
*/

/* Question
Write a query to return the 10 earliest orders in the orders table.
Include the id, occurred_at, and total_amt_usd.:
*/

SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

/* Question
Write a query to return the top 5 orders in terms of largest total_amt_usd.
Include the id, account_id, and total_amt_usd.
*/

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

/* Question
Write a query to return the bottom 20 orders in terms of least total.
Include the id, account_id, and total.
*/

SELECT id, account_id, total
FROM orders
ORDER BY total
LIMIT 20;

/* Question
Write a query that returns top 5 rows from orders.
Newest to oldest, i.e. desending.
But then sort that by a second column, so put that next with a comma.
This is total_amt_usd from large to small, i.e. also descending.
Later on, truncating can help to solve that more elegantly and avoid seeing each date separately.
*/
SELECT *
FROM orders
ORDER BY occurred_at DESC, total_amt_usd DESC
LIMIT 5;

/* Question
Now write a similar query that returns top 10 rows on the same fields, but with oldest to newest
and smallest to largest amount.
So ascending order.
*/
SELECT *
FROM orders
ORDER BY occurred_at, total_amt_usd
LIMIT 10;

### Filtering with WHERE
/* The WHERE clause allows you to filter results.
You are querying the table such that the data in one particular column has a certain value.
You will then get the foll row displayed.
See this as one data point, as all of the data in one row of e.g. orders belongs to one order.
The WHERE clause goes after SELECT and FROM but before ORDER BY.
Using the WHERE statement, we can subset out tables based on conditions that must be met.
The above video shows how this can be used, and in the next sections,
you will learn some of the common operators that are used with the WHERE statement.
Common symbols used within WHERE statements include:
> (greater than)
< (less than)
>= (greater than or equal to)
<= (less than or equal to)
= (equal to)
!= (not equal to)*/

/* Question
Pull the first 5 rows and all columns from the orders table that have a
dollar amount of gloss_amt_usd greater than or equal to 1000.
*/
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

/* Question
Pull the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.
*/
SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

/*Note
Non-numeric data
If you work with comparison operators like, =, > and so on and they do not apply to numeric values,
then you have to put the value in ' '.


The WHERE statement can also be used with non-numerical data.
We can use the = and != operators here.
You also need to be sure to use single quotes (just be careful if you have quotes in the original text) with the text data.
Commonly when we are using WHERE with non-numeric data fields, we use the LIKE, NOT, or IN operators.
We will see those before the end of this lesson!
*/

/* Question
Filter the accounts table to include the company name,
website, and the primary point of contact (primary_poc) for Exxon Mobil in the accounts table.
*/
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

### Arithmetic operators
/*Note
Derived columns
We can do more than just query what is there.
We can also manipulate existing columns to create derived columns and give it a name using AS at the end of the line.
Example: columns A + column B AS sum_column

Creating a new column that is a combination of existing columns is known as a derived column.
Common operators include:
* (Multiplication)
+ (Addition)
- (Subtraction)
/ (Division)
*/

/* Question
Create a column that divides the standard_amt_usd by the standard_qty to find the unit price for standard paper for each order.
Limit the results to the first 10 orders, and include the id and account_id fields
*/
SELECT
id,
account_id,
standard_amt_usd / standard_qty AS unit_price
FROM orders
LIMIT 10;

/* Question
Write a query that finds the percentage of revenue that comes from poster paper for each order.
You will need to use only the columns that end with _usd.
(Try to do this without using the total column).
Include the id and account_id fields.
NOTE - you will be thrown an error with the correct solution to this question.
This is for a division by zero.
You will learn how to get a solution without an error to this query when you learn about CASE statements in a later section.
For now, you might just add some very small value to your denominator as a work around.
*/
SELECT id, account_id, standard_amt_usd, gloss_amt_usd, poster_amt_usd,
poster_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS poster_percentage_revenue
FROM orders;


### Logical operators
/* Note
In the next concepts, you will be learning about Logical Operators. Logical Operators include:
LIKE
This allows you to perform operations similar to using WHERE and =,
but for cases when you might not know exactly what you are looking for.
IN
This allows you to perform operations similar to using WHERE and =, but for more than one condition.
NOT
This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.
AND & BETWEEN
These allow you to combine operations where all combined conditions must be true.
OR
This allow you to combine operations where at least one of the combined conditions must be true.
*/

/* Note on LIKE
LIKE is super helpful to query text that is similar but not exactly the same.
The % sign can be used as a wild card standing for any one or many characters.
So use the LIKE operator instead of an equal sign in a WHERE query.

The LIKE operator is extremely useful for working with text. You will use LIKE within a WHERE clause.
The LIKE operator is frequently used with %.
The % tells us that we might want any number of characters leading up to a particular set of characters or
following a certain set of characters, as we saw with the google syntax above.
Remember you will need to use single quotes for the text you pass to the LIKE operator,
because of this lower and uppercase letters are not the same within the string.
Searching for 'T' is not the same as searching for 't'. In other SQL environments (outside the classroom),
you can use either single or double quotes.
Hopefully you are starting to get more comfortable with SQL, as we are starting to move toward operations
that have more applications, but this also means we can't show you every use case.
Hopefully, you can start to think about how you might use these types of applications to identify phone numbers
from a certain region, or an individual where you can't quite remember the full
*/

/*Question
Use the accounts table to find
All the companies whose names start with 'C'.
All companies whose names contain the string 'one' somewhere in the name.
All companies whose names end with 's'.
*/
SELECT *
FROM accounts
WHERE name LIKE 'C%';

SELECT *
FROM accounts
WHERE name LIKE '%one%';

SELECT *
FROM accounts
WHERE name LIKE '%s';

/*Note on IN
IN can be used if I want to query for more than one value inside a column.
it alsow works in conjunction with the  WHERE command, just like in the above WHERE ... LIKE... combination.

The IN operator is useful for working with both numeric and text columns.
This operator allows you to use an =, but for more than one item of that particular column.
We can check one, two or many column values for which we want to pull data, but all within the same query.
In the upcoming concepts, you will see the OR operator that would also allow us to perform these tasks,
but the IN operator is a cleaner way to write these queries.
Expert Tip
In most SQL environments, you can use single or double quotation marks -
and you may NEED to use double quotation marks if you have an apostrophe within the text you are attempting to pull.
In the work spaces in the classroom, note you can include an apostrophe by putting two single quotes together.
Example Macy's in our work space would be 'Macy''s'.
*/

/*question
Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
*/
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

/*question
Use the web_events table to find all information regarding
individuals who were contacted via the channel of organic or adwords
*/
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/*Note
The NOT command looks at the inverse. Use it with LIKE or IN to NOT LIKE and NOT IN.

The NOT operator is an extremely useful operator for working with the previous two operators we introduced: IN and LIKE.
By specifying NOT LIKE or NOT IN, we can grab all of the rows that do not meet a particular criteria.
*/

/*Question
Questions using the NOT operator
We can pull all of the rows that were excluded from the queries in the previous two concepts with our new operator.
Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.
Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
Use the accounts table to find:
All the companies whose names do not start with 'C'.
All companies whose names do not contain the string 'one' somewhere in the name.
All companies whose names do not end with 's'
*/
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%';

SELECT *
FROM accounts
WHERE name NOT LIKE '%one%';

SELECT *
FROM accounts
WHERE name NOT LIKE '%s';

/*Note
The AND command allows you to combine two logical statements.
Both need to be formulated in full.
The AND operator is used within a WHERE statement to consider more than one logical clause at a time.
Each time you link a new statement with an AND, you will need to specify the column you are interested in looking at. You may link as many statements as you would like to consider at the same time. This operator works with all of the operations we have seen so far including arithmetic operators (+, *, -, /).
LIKE, IN, and NOT logic can also be linked together using the AND operator.
BETWEEN Operator
Sometimes we can make a cleaner statement using BETWEEN than we can using AND.
Particularly this is true when we are using the same column for different parts of our AND statement.
In the previous video, we probably should have used BETWEEN.
Instead of writing :
WHERE column >= 6 AND column <= 10
we can instead write, equivalently:
WHERE column BETWEEN 6 AND 10
*/

/*Question
Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0, and the gloss_qty is 0.
Using the accounts table find all the companies whose names do not start with 'C' and end with 's'.
Use the web_events table to find all information regarding individuals who were contacted via organic
or adwords and started their account at any point in 2016 sorted from newest to oldest.
*/
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%' AND name NOT LIKE '%s';

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at >= '2016-1-1' AND occurred_at <= '2016-12-31'
ORDER BY occurred_at DESC;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

/* Note on the above solution: *You will notice that using BETWEEN is tricky for dates!
While BETWEEN is generally inclusive of endpoints, it assumes the time is at 00:00:00 (i.e. midnight) for dates.
This is the reason why we set the right-side endpoint of the period at '2017-01-01'.
*/

/*Note
OR satisfyis either of various conditions. AND satisfies all of the logical statements.
with parentheses we can turn several logical statements that are connected with an OR into one single logical statement
that will resolve to true or false. As long as one statement in the block is true, the entire block is considered to be true.

Similar to the AND operator, the OR operator can combine multiple statements. Each time you link a new statement with an OR,
you will need to specify the column you are interested in looking at. You may link as many statements as you would like
to consider at the same time. This operator works with all of the operations we have seen so far including arithmetic operators (+, *, -, /),
LIKE, IN, NOT, AND, and BETWEEN logic can all be linked together using the OR operator.
When combining multiple of these operations, we frequently might need to use parentheses to assure
that logic we want to perform is being executed correctly. The video below shows an example of one of these situations.
*/

/*Questions
Find list of orders ids where either gloss_qty or poster_qty is greater than 4000.
Only include the id field in the resulting table.
Write a query that returns a list of orders where the standard_qty is zero and either the gloss_qty or poster_qty is over 1000.
Find all the company names that start with a 'C' or 'W', and the primary contact contains 'ana' or 'Ana', but it doesn't contain 'eana'.
*/
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%') AND
primary_poc NOT LIKE '%eana%');

/* Note
As I continue to write, I could use a more generalized way, LIKESELECT col1, col2
FROM table1
WHERE col3  > 5 AND col4 LIKE '%os%'
ORDER BY col5
LIMIT 10;
Notice, you can retrieve different columns than those being used in the ORDER BY and WHERE statements.
Assuming all of these column names existed in this way
*/(col1, col2, col3, col4, col5) within a table called table1, this query would run just fine.
SELECT col1, col2
FROM table1
WHERE col3  > 5 AND col4 LIKE '%os%'
ORDER BY col5
LIMIT 10;
