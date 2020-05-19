CREATE TABLE shirts 
(shirt_id INT NOT NULL AUTO_INCREMENT,
article VARCHAR(20) NOT NULL, 
color VARCHAR(10) NOT NULL,
shirt_size VARCHAR(1) NOT NULL,
last_worn INT NOT NULL DEFAULT 0,
PRIMARY KEY (shirt_id)
);

INSERT INTO shirts (article, color, shirt_size, last_worn) 
VALUES('polo shirt', 'purple' , 'M', 50);

UPDATE shirts SET shirt_size='L' WHERE article='polo shirt';
UPDATE shirts SET last_worn=0 WHERE last_worn=15;
UPDATE shirts SET shirt_size='X' WHERE color='white';
DELETE FROM shirts WHERE last_worn-200;
mysql-
CREATE TABLE cats 
(
	cat_id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(200),
	age INT,
	PRIMARY KEY (cat_id)
)

SELECT title, released_year,
	CASE 
		WHEN released_year >= 2000 THEN 'Modern Lit'
		ELSE '20th Century Lit'
	END AS GENRE
FROM books;


SELECT title, stock_quantity,
	CASE 
		WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
		WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
		ELSE '***'
	END AS STOCK
FROM books;

----------------------------------
JOINS
---------------------------------

-- INNER JOINS (implicit) = this is the common data that two tables have

SELECT first_name, last_name, order_date, amount FROM customers, orders WHERE customers.id=customer_id;

-- INNER JOINS (explicit) = same as before, jsut has the word JOIN in the query

SELECT first_name, last_name, order_date, amount 
FROM customers 
JOIN orders 
	ON customers.id=orders.customer_id;

-- RIGHT JOIN = takes every record from the right and add matching records from the left. This means that it could have some Null entries

SELECT *
FROM customers
RIGHT JOIN orders
	ON customers.id=orders.customer_id;


-- LEFT JOIN = takes every record from the left and add matching records from the right. This means that it could have some Null entries 

SELECT first_name, last_name, IFNULL(SUM(amount), 0) AS total_spent
FROM customers 
LEFT JOIN orders
	ON customers.id=orders.customer_id
GROUP BY customers.id
ORDER BY total_spent;


----------------------------------------------

SELECT title, rating
FROM series
JOIN reviews
	ON series_id=series.id;
	
SELECT title, AVG(rating) AS avg_rating
FROM series
JOIN reviews 
	ON series_id=series.id
GROUP BY title
ORDER BY avg_rating;

SELECT first_name, last_name, rating
FROM reviewers
JOIN reviews
	ON reviewer_id=reviewers.id;

SELECT title AS unreviewed_series
FROM reviews
RIGHT JOIN series
	ON series.id=series_id
WHERE reviews.id IS NULL;

SELECT genre, AVG(rating) AS avg_rating
FROM series
JOIN reviews
	ON series.id=reviews.series_id
GROUP BY genre
ORDER BY genre;

SELECT 
	first_name, 
	last_name, 
	COUNT(rating) AS COUNT, 
	IFNULL(MIN(rating),0) AS MIN, 
	IFNULL(MAX(rating), 0) AS MAX, 
	IFNULL(AVG(rating), 0) AS AVG,
	CASE
		WHEN COUNT(rating)=0 THEN 'INACTIVE'
		ELSE 'ACTIVE'
	END AS STATUS
FROM reviewers
LEFT JOIN reviews
	ON reviewers.id=reviews.reviewer_id
GROUP BY reviewer_id
ORDER BY status;

SELECT title, rating, CONCAT(first_name, " ", last_name)
FROM reviews, reviewers, series
WHERE reviewers.id=reviewer_id && series_id=series.id
ORDER BY title;
-- alt 
SELECT 
    title,
    rating,
    CONCAT(first_name,' ', last_name) AS reviewer
FROM reviewers
INNER JOIN reviews 
    ON reviewers.id = reviews.reviewer_id
INNER JOIN series
    ON series.id = reviews.series_id
ORDER BY title;


CREATE TABLE users 
(
	email VARCHAR(255) PRIMARY KEY,
	created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users(email)
VALUES ('katie34@yahoo.com'),('tunde@gmail.com');

mysql -u root -p



