SELECT m.title AS movie_title, d.first_name || ' ' || d.last_name AS director_name
FROM movies m
JOIN directors d ON m.director_id = d.director_id
WHERE m.rating = 'R';

SELECT m.title AS movie_title, g.name AS genre
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
WHERE EXTRACT(YEAR FROM m.release_date) = 2019;

SELECT a.first_name, a.last_name, m.title AS movie_title
FROM actors a
JOIN cast_members cm ON a.actor_id = cm.actor_id
JOIN movies m ON cm.movie_id = m.movie_id
WHERE a.nationality = 'American';

SELECT m.title AS movie_title, pc.name AS production_company
FROM movies m
JOIN movie_production_companies mpc ON m.movie_id = mpc.movie_id
JOIN production_companies pc ON mpc.company_id = pc.company_id
WHERE m.budget > 100000000;


SELECT m.title AS movie_title, a.first_name, a.last_name
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
JOIN cast_members cm ON m.movie_id = cm.movie_id
JOIN actors a ON cm.actor_id = a.actor_id
WHERE g.name = 'Horror';

SELECT d.first_name || ' ' || d.last_name AS director_name, m.title AS movie_title
FROM directors d
JOIN movies m ON d.director_id = m.director_id
WHERE d.nationality = 'British';

SELECT m.title AS movie_title, g.name AS genre
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
WHERE m.duration_minutes > 180;

SELECT m.title AS movie_title, d.first_name || ' ' || d.last_name AS director_name
FROM movies m
JOIN movie_awards ma ON m.movie_id = ma.movie_id
JOIN awards a ON ma.award_id = a.award_id
JOIN directors d ON m.director_id = d.director_id
WHERE a.name = 'Oscar';
