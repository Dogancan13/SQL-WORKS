DROP FUNCTION IF EXISTS get_movies_by_rating(TEXT);

CREATE OR REPLACE FUNCTION get_movies_by_rating(rating_param TEXT)
RETURNS TABLE (
    movie_id INT,
    title TEXT,
    release_date DATE,
    rating TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT movie_id, title, release_date, rating
    FROM movies
    WHERE rating = rating_param;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS get_director_filmography(INT);

CREATE OR REPLACE FUNCTION get_director_filmography(director_id_param INT)
RETURNS TABLE (
    movie_id INT,
    title TEXT,
    release_date DATE,
    genre_list TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        m.movie_id,
        m.title,
        m.release_date,
        STRING_AGG(DISTINCT g.genre_name, ', ') AS genre_list
    FROM movies m
    LEFT JOIN movie_genres mg ON m.movie_id = mg.movie_id
    LEFT JOIN genres g ON mg.genre_id = g.genre_id
    WHERE m.director_id = director_id_param
    GROUP BY m.movie_id, m.title, m.release_date;
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS calculate_actor_age(DATE);

CREATE OR REPLACE FUNCTION calculate_actor_age(birth_date DATE)
RETURNS INT AS $$
BEGIN
    RETURN DATE_PART('year', AGE(CURRENT_DATE, birth_date))::INT;
END;
$$ LANGUAGE plpgsql;

SELECT first_name, last_name, has_won_awards(actor_id) AS has_awards
FROM actors;
