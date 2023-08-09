USE sakila;
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals. Hint: look for floor and round functions.
SELECT CONCAT(FLOOR(AVG(length) / 60), ' Hours ', ROUND(AVG(length) % 60), ' Minutes') AS avg_duration
FROM film;

-- 2.1 Calculate the number of days that the company has been operating.

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.

SELECT *, MONTH(rental_date) AS 'Month', DAYNAME(rental_date) AS 'Weekday'
FROM rental
LIMIT 20;

-- 2.3 Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week

SELECT *, MONTH(rental_date) AS 'Month', DAYNAME(rental_date) AS 'Weekday',
CASE
WHEN DAYNAME(rental_date) IN ('Saturday', 'Sunday') THEN 'weekend'
WHEN DAYNAME(rental_date) NOT IN ('Saturday', 'Sunday') THEN 'weekday'
ELSE 'No status'
END AS 'DAY_TYPE'
FROM rental;

-- 3. Retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results by the film title in ascending order.

SELECT title, IFNULL(rental_duration, 'Not Available') AS 'rental_duration'
FROM film
ORDER BY title ASC;

-- 4. retrieve the concatenated first and last names of our customers, along with the first 3 characters of their email address

SELECT CONCAT(first_name, ' ', last_name, ' ', LEFT(email, 3)) AS 'new_name'
FROM customer
ORDER BY last_name ASC;


-- Challenge 2
-- 1.1 The total number of films that have been released.

SELECT COUNT(DISTINCT title) AS 'released_films'
FROM film;

-- 1.2 The number of films for each rating.

SELECT rating, COUNT(DISTINCT title)
FROM film
GROUP BY rating
ORDER BY rating;

-- 1.3 The number of films for each rating, and sort the results in descending order of the number of films. 
SELECT rating, COUNT(DISTINCT title)
FROM film
GROUP BY rating
ORDER BY COUNT(DISTINCT title) DESC;

-- 2. Determine the number of rentals processed by each employee.

SELECT staff_id, COUNT(DISTINCT rental_id)
FROM rental
GROUP BY staff_id
ORDER BY staff_id;

-- 3.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places.

SELECT rating, ROUND(AVG(length),2)
FROM film
GROUP BY rating
ORDER BY AVG(length) DESC;

-- 3.2 Identify which ratings have a mean duration of over two hours

SELECT rating, ROUND(AVG(length),2)
FROM film
GROUP BY rating
HAVING AVG(length) > 120;

-- 4. Determine which last names are not repeated in the table actor.

SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1;
