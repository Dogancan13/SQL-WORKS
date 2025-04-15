Genres with more than 3 movies rated 'R'
SELECT g.genre_name, COUNT(*) AS movie_count
FROM movie_genres mg
JOIN genres g ON mg.genre_id = g.genre_id
JOIN movies m ON mg.movie_id = m.movie_id
WHERE m.rating = 'R'
GROUP BY g.genre_name
HAVING COUNT(*) > 3;

--Directors with total revenue > $500M and at least 2 movies
SELECT d.director_id, d.name, COUNT(m.movie_id) AS movie_count, SUM(r.revenue) AS total_revenue
FROM directors d
JOIN movies m ON d.director_id = m.director_id
JOIN movie_revenues r ON m.movie_id = r.movie_id
GROUP BY d.director_id, d.name
HAVING COUNT(m.movie_id) >= 2 AND SUM(r.revenue) > 500000000;


--Actors in >2 genres and have won at least 1 award
SELECT a.actor_id, a.name
FROM actors a
JOIN cast_members cm ON a.actor_id = cm.actor_id
JOIN movie_genres mg ON cm.movie_id = mg.movie_id
JOIN actor_awards aa ON a.actor_id = aa.actor_id
GROUP BY a.actor_id, a.name
HAVING COUNT(DISTINCT mg.genre_id) > 2 AND COUNT(DISTINCT aa.award_id) >= 1;


--Movies with >3 reviews and avg rating > 7
SELECT m.movie_id, m.title, COUNT(r.review_id) AS review_count, AVG(r.rating) AS avg_rating
FROM movies m
JOIN reviews r ON m.movie_id = r.movie_id
GROUP BY m.movie_id, m.title
HAVING COUNT(r.review_id) > 3 AND AVG(r.rating) > 7;


--Production companies that invested > $100M in movies after 2015
SELECT pc.company_name, SUM(m.budget) AS total_investment
FROM movie_production_companies mpc
JOIN production_companies pc ON mpc.company_id = pc.company_id
JOIN movies m ON mpc.movie_id = m.movie_id
WHERE EXTRACT(YEAR FROM m.release_date) > 2015
GROUP BY pc.company_name
HAVING SUM(m.budget) > 100000000;


--Countries with >2 movies filmed & total budget > $150M
SELECT ml.country, COUNT(DISTINCT ml.movie_id) AS movie_count, SUM(m.budget) AS total_budget
FROM movie_locations ml
JOIN movies m ON ml.movie_id = m.movie_id
GROUP BY ml.country
HAVING COUNT(DISTINCT ml.movie_id) > 2 AND SUM(m.budget) > 150000000;


--Genres with avg duration > 120 mins and at least 1 Oscar-winning movie
SELECT g.genre_name
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
JOIN movies m ON mg.movie_id = m.movie_id
JOIN movie_awards ma ON m.movie_id = ma.movie_id
JOIN awards a ON ma.award_id = a.award_id
GROUP BY g.genre_name
HAVING AVG(m.duration) > 120 AND 
       SUM(CASE WHEN a.award_name ILIKE '%Oscar%' THEN 1 ELSE 0 END) > 0;


--Years with >3 movies and avg budget > $50M
SELECT EXTRACT(YEAR FROM m.release_date) AS release_year, COUNT(*) AS movie_count, AVG(m.budget) AS avg_budget
FROM movies m
GROUP BY release_year
HAVING COUNT(*) > 3 AND AVG(m.budget) > 50000000;


--Actors with lead roles in >2 movies with total revenue > $200M
SELECT a.actor_id, a.name, COUNT(DISTINCT cm.movie_id) AS lead_roles, SUM(r.revenue) AS total_revenue
FROM actors a
JOIN cast_members cm ON a.actor_id = cm.actor_id
JOIN movies m ON cm.movie_id = m.movie_id
JOIN movie_revenues r ON m.movie_id = r.movie_id
WHERE cm.role = 'Lead'
GROUP BY a.actor_id, a.name
HAVING COUNT(DISTINCT cm.movie_id) > 2 AND SUM(r.revenue) > 200000000;

--Top-Rated Movies View
CREATE OR REPLACE VIEW top_rated_movies AS
SELECT 
    m.title AS movie_title,
    AVG(r.rating) AS average_rating,
    COUNT(r.review_id) AS review_count,
    d.name AS director_name
FROM movies m
JOIN reviews r ON m.movie_id = r.movie_id
JOIN directors d ON m.director_id = d.director_id
GROUP BY m.title, d.name;

--Movie Financial Performance View
CREATE OR REPLACE VIEW movie_financial_performance AS
SELECT 
    m.title AS movie_title,
    m.budget,
    mr.revenue AS total_revenue,
    (mr.revenue - m.budget) AS profit,
    ROUND((mr.revenue::decimal / NULLIF(m.budget, 0)), 2) AS roi
FROM movies m
JOIN movie_revenues mr ON m.movie_id = mr.movie_id;

--Actor Filmography View
CREATE OR REPLACE VIEW actor_filmography AS
SELECT 
    a.name AS actor_name,
    COUNT(DISTINCT cm.movie_id) AS movie_count,
    STRING_AGG(DISTINCT g.genre_name, ', ') AS genre_list,
    SUM(DISTINCT mr.revenue) AS total_revenue
FROM actors a
JOIN cast_members cm ON a.actor_id = cm.actor_id
JOIN movies m ON cm.movie_id = m.movie_id
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
JOIN movie_revenues mr ON m.movie_id = mr.movie_id
GROUP BY a.name;

--Genre Statistics View
CREATE OR REPLACE VIEW genre_statistics AS
SELECT 
    g.genre_name,
    COUNT(DISTINCT mg.movie_id) AS movie_count,
    ROUND(AVG(r.rating), 2) AS average_rating,
    SUM(DISTINCT mr.revenue) AS total_revenue
FROM genres g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
JOIN movies m ON mg.movie_id = m.movie_id
JOIN reviews r ON m.movie_id = r.movie_id
JOIN movie_revenues mr ON m.movie_id = mr.movie_id
GROUP BY g.genre_name;

--Production Company Performance View
CREATE OR REPLACE VIEW production_company_performance AS
SELECT 
    pc.company_name,
    COUNT(DISTINCT mpc.movie_id) AS movie_count,
    SUM(DISTINCT m.budget) AS total_investment,
    SUM(DISTINCT mr.revenue) AS total_revenue
FROM production_companies pc
JOIN movie_production_companies mpc ON pc.company_id = mpc.company_id
JOIN movies m ON mpc.movie_id = m.movie_id
JOIN movie_revenues mr ON m.movie_id = mr.movie_id
GROUP BY pc.company_name;

