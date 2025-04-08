SELECT * 
FROM movies
WHERE EXTRACT(YEAR FROM release_date) = 2019;

SELECT * 
FROM actors
WHERE nationality = 'British';

SELECT * 
FROM movies
WHERE rating = 'PG-13';

SELECT * 
FROM directors
WHERE nationality = 'American';

SELECT * 
FROM actors
WHERE last_name = 'Pitt';

SELECT * 
FROM movies
WHERE budget > 100000000;

SELECT * 
FROM reviews
WHERE rating = 5;

SELECT * 
FROM movies
WHERE language = 'English';

SELECT * 
FROM production_companies
WHERE location = 'California';