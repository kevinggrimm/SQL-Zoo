-- I. List the films where the yr is 1962 [Show id, title]

SELECT id, title FROM movie
  WHERE yr = 1962

-- II. Give year of 'Citizen Kane'.

SELECT yr FROM movie
  WHERE title = 'Citizen Kane'

-- III. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr FROM movie
  WHERE title LIKE ('Star Trek%')
  ORDER BY yr

-- IV. What id number does the actor 'Glenn Close' have?

SELECT id FROM actor
  WHERE name = 'Glenn Close'

-- V. What is the id of the film 'Casablanca'

SELECT id FROM movie
  WHERE title = 'Casablanca'

-- VI. Obtain the cast list for 'Casablanca'.

SELECT name
  FROM movie JOIN casting ON (movie.id = casting.movieid)
  JOIN actor ON (actor.id = casting.actorid)
  WHERE casting.movieid = (SELECT id FROM movie WHERE title = 'Casablanca')

-- VII. Obtain the cast list for the film 'Alien'

SELECT name
  FROM movie JOIN casting ON (movie.id = casting.movieid)
  JOIN actor ON (actor.id = casting.actorid)
  WHERE casting.movieid = (SELECT id FROM movie WHERE title = 'Alien')

-- VIII. List the films in which 'Harrison Ford' has appeared

SELECT title
  FROM movie JOIN casting ON (movie.id = casting.movieid)
  JOIN actor ON (actor.id = casting.actorid)
  WHERE actor.name = 'Harrison Ford'

-- IX. List the films where 'Harrison Ford' has appeared - but not in the starring role.

SELECT title
  FROM movie JOIN casting ON (movie.id = casting.movieid)
  JOIN actor ON (actor.id = casting.actorid)
  WHERE actor.name = 'Harrison Ford'
  AND casting.ord <> 1

-- X. List the films together with the leading star for all 1962 films.

SELECT title, name
  FROM movie JOIN casting ON (movie.id = casting.movieid)
  JOIN actor ON (actor.id = casting.actorid)
  WHERE yr = 1962
  AND ord = 1

-- XI. Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr, COUNT(title)
  FROM movie JOIN casting ON (movie.id = casting.movieid)
  JOIN actor ON (actor.id = casting.actorid)
  WHERE actor.name = 'John Travolta'
  GROUP BY yr
  HAVING COUNT(title) = 
    (SELECT MAX(c) FROM 
      (SELECT yr, COUNT(title) AS c FROM movie
      JOIN casting ON (movie.id = casting.movieid)
      JOIN actor ON (actor.id = casting.actorid)
      WHERE name = 'John Travolta'
      GROUP BY yr) AS t)

-- XII. List the film title and the leading actor for all of the films 'Julie Andrews' played in.

SELECT DISTINCT m.title, a.name
  FROM
    (SELECT actor.*, casting.movieid FROM actor
      JOIN casting ON (actor.id = casting.actorid)
      WHERE ord = 1) AS a
  JOIN
    (SELECT movie.* FROM movie
      JOIN casting ON (movie.id = casting.movieid)
      JOIN actor ON (actor.id = casting.actorid)
      WHERE name = 'Julie Andrews') AS m
  ON a.movieid = m.id
  ORDER BY m.title

-- XIII. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.

SELECT name FROM actor
  JOIN casting ON
    (actor.id = casting.actorid
    AND
    (SELECT COUNT(ord) FROM casting WHERE casting.actorid = actor.id AND ord = 1) >= 30)
  ORDER BY name

-- XIV. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT title, COUNT(actor.id) FROM movie
  JOIN casting ON (casting.movieid = movie.id)
  JOIN actor ON (casting.actorid = actor.id)
  WHERE yr = 1978
  GROUP BY title
  ORDER BY COUNT(name) DESC, title

-- XV. List all the people who have worked with 'Art Garfunkel'.

SELECT DISTINCT name FROM actor
  JOIN casting ON actor.id = casting.actorid
  WHERE casting.movieid IN
    (SELECT movieid FROM casting
      JOIN actor ON actor.id = casting.actorid
      WHERE name = 'Art Garfunkel')
  AND name <> 'Art Garfunkel'
