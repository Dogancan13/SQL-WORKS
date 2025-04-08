SELECT m.title AS movie_title, d.first_name || ' ' || d.last_name AS director_name
FROM movies m
JOIN directors d ON m.director_id = d.director_id;

SELECT a.first_name, a.last_name, m.title AS movie_title
FROM actors a
JOIN cast_members cm ON a.actor_id = cm.actor_id
JOIN movies m ON cm.movie_id = m.movie_id;

SELECT m.title AS movie_title, g.name AS genre_name
FROM movies m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id;

SELECT m.title AS movie_title, pc.name AS production_company
FROM movies m
JOIN movie_production_companies mpc ON m.movie_id = mpc.movie_id
JOIN production_companies pc ON mpc.company_id = pc.company_id;

SELECT a.first_name, a.last_name, aw.name AS award_name
FROM actors a
JOIN actor_awards aa ON a.actor_id = aa.actor_id
JOIN awards aw ON aa.award_id = aw.award_id;

SELECT m.title AS movie_title, aw.name AS award_name
FROM movies m
JOIN movie_awards ma ON m.movie_id = ma.movie_id
JOIN awards aw ON ma.award_id = aw.award_id;

SELECT u.username, m.title AS movie_title
FROM users u
JOIN user_watchlist uw ON u.user_id = uw.user_id
JOIN movies m ON uw.movie_id = m.movie_id;

