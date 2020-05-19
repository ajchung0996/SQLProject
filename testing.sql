SELECT COUNT(title) AS 'Total Title of Books' from books;

SELECT released_year AS 'Year Released', COUNT(*) AS 'Number of Books Released' FROM books GROUP BY released_year;

SELECT SUM(stock_quantity) AS 'Total Quantity of Books' FROM books;

SELECT DISTINCT author_lname AS 'Last Name', author_fname AS 'First Name', AVG(released_year) AS 'Average Release Year' FROM books GROUP BY author_lname, author_fname;

SELECT CONCAT(author_fname, " ", author_lname) AS 'Author with the longest book' FROM books WHERE pages=(SELECT MAX(pages) FROM books);

SELECT released_year AS 'year', COUNT(*) AS '# books', AVG(pages) AS 'avg pages' FROM books GROUP BY released_year ORDER BY released_year;


--------------------------------------


CREATE TABLE other
(
M/F CHAR(1) NOT NULL,
);

CREATE TABLE inventory 
(
item_name VARCHAR(100),
price FLOAT DEFAULT 0.00,   (DECIMALS(8,2))
quantity INT DEFAULT 0,
);

DATETIME=GOES EVEN BEFORE, USE WHEN WANT TO PUT SPECIFIC NAME
TIMESTAMP=MORE OF AN AUTOMATIC SETTING, AND IT IS NOT AS FLEXIBLE

SELECT TIME(NOW());

SELECT DATE(NOW());

SELECT DAYOFWEEK(NOW());

SELECT DAYNAME(NOW());

SELECT (DATE_FORMAT(NOW(),'%m/%d/%Y %T'));

SELECT DATE_FORMAT(NOW(),'%M %D at %h:%i');

CREATE TABLE tweets
(
content VARCHAR(140),
username VARCHAR(20),
created_time TIMESTAMP DEFAULT NOW(),
);


---------------------------------------------



SELECT title FROM books WHERE released_year<1980;

SELECT title FROM books WHERE author_lname IN ('Eggers', 'Chabon');

SELECT title FROM books WHERE author_lname='Lahiri' AND released_year>2000;

SELECT title FROM books WHERE pages BETWEEN 100 AND 200;

SELECT title FROM books WHERE author_lname LIKE 'C%' || author_lname LIKE 'S%';

SELECT title, author_lname,
	CASE
		WHEN title like '%stories' THEN 'Short Stories'
		WHEN title LIKE '%Just Kids%' || title LIKE '%A Heartbreaking Work%' THEN 'Memoir'
		ELSE 'Novel'
	END AS TYPE 
FROM books;

SELECT title, author_lname,
	CASE
		WHEN COUNT(*)>1 THEN CONCAT(COUNT(*), " books")
		ELSE '1 book'
	END AS COUNT 
FROM books
GROUP BY author_lname, author_fname;



---------------------------------------------------


CREATE TABLE students
(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	first_name VARCHAR(20) NOT NULL
);
CREATE TABLE papers
(
title VARCHAR(100),
grade INT,
student_id INT,
	FOREIGN KEY(student_id) REFERENCES students(id)
);

SELECT first_name, title, grade
FROM students
INNER JOIN papers
	ON student_id=id
ORDER BY grade DESC;

SELECT first_name, title, grade 
FROM students 
LEFT JOIN papers
	ON student_id=id;
	
SELECT first_name, IFNULL(title, 'MISSING'), IFNULL(grade,0) 
FROM students 
LEFT JOIN papers
	ON student_id=id;

SELECT first_name, IFNULL(AVG(grade),0) AS average
FROM students 
LEFT JOIN papers
	ON student_id=id
GROUP BY first_name
ORDER BY average DESC;

SELECT first_name, IFNULL(AVG(grade),0) AS average, 
	CASE
		WHEN AVG(grade)>=75 THEN 'PASSING'
		ELSE 'FAILING'
	END AS passing_status
FROM students 
LEFT JOIN papers
	ON student_id=id
GROUP BY first_name
ORDER BY average DESC;

-----------------------------------------------
-- IG QUESTIONS
-----------------------------------------------


SELECT *
FROM users
ORDER BY created_at
LIMIT 5;

SELECT DAYNAME(created_at) AS days, COUNT(id) AS '# of New Users'
FROM users
GROUP BY days
ORDER BY COUNT(id) DESC;

SELECT username
FROM users
LEFT JOIN photos
	ON users.id=photos.user_id
WHERE photos.id IS NULL;

SELECT username, COUNT(*) AS 'AMOUNT OF LIKES'
FROM photos
INNER JOIN likes
	ON likes.photo_id=photos.id
INNER JOIN users
	ON photos.user_id=users.id
GROUP BY photo_id
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT AVG(photos.id / users.id) AS avg_photos
FROM photos
JOIN users
	ON photos.user_id=users.id;

SELECT tag_name, COUNT(tags.id)
FROM tags 
JOIN photo_tags 
	ON photo_tags.tag_id=tags.id
GROUP BY tags.id
ORDER BY COUNT(tags.id) DESC
LIMIT 5;

SELECT username, COUNT(*) AS total_likes
FROM users
JOIN likes
	ON likes.user_id=users.id
GROUP BY users.id
HAVING total_likes=(SELECT COUNT(*) FROM photos);


---------------------------------------------------




SELECT DATE_FORMAT(created_at,'%M %D %Y') AS earliest_date FROM users ORDER BY created_date LIMIT 1;

SELECT email, created_at FROM users ORDER BY created_date LIMIT 1;

SELECT DATE_FORMAT(created_at,'%M') AS month, COUNT(*) AS count FROM users GROUP BY month;

SELECT COUNT(*) as yahoo_users FROM users WHERE email LIKE '%yahoo.com%';

SELECT 
	CASE
		WHEN email LIKE '%gmail.com' THEN 'GMAIL'
		WHEN email LIKE '%yahoo.com' THEN 'YAHOO'
		WHEN email LIKE '%hotmail.com' THEN 'HOTMAIL'
		WHEN email LIKE '%outlook.com' THEN 'OUTLOOK'
		ELSE 'OTHER'
	END AS provider,
COUNT(*) as total_users
FROM users
GROUP BY provider;
	




