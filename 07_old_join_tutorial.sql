-- I. Show the athelete (who) and the country name for medal winners in 2000.

SELECT who, name
    FROM ttms JOIN country ON (ttms.country = country.id)
  WHERE games = 2000

-- II. Show the who and the color of the medal for the medal winners from 'Sweden'.

SELECT who, color
    FROM ttms JOIN country ON (ttms.country = country.id)
  WHERE name = 'Sweden'

-- III. Show the years in which 'China' won a 'gold' medal.

SELECT games
    FROM ttms JOIN country ON (ttms.country = country.id)
  WHERE name = 'China' AND color = 'gold'

-- IV. Show who won medals in the 'Barcelona' games.

SELECT who
    FROM ttws JOIN games ON (ttws.games = games.yr)
  WHERE city = 'Barcelona'

-- V. Show which city 'Jing Chen' won medals. Show the city and the medal color.

SELECT city, color
    FROM ttws JOIN games ON (ttws.games = games.yr)
  WHERE who = 'Jing Chen'

-- VI. Show who won the gold medal and the city.

SELECT who, city
    FROM ttws JOIN games ON (ttws.games = games.yr)
  WHERE color = 'gold'

-- VII. Show the games and color of the medal won by the team that includes 'Yan Sen'.

SELECT games, color
    FROM ttmd JOIN team ON (ttmd.team = team.id)
  WHERE team.name IN ('Yan Sen')

-- VIII. Show the 'gold' medal winners in 2004.

SELECT name
    FROM ttmd JOIN team ON (ttmd.team = team.id)
  WHERE color = 'gold' AND games = 2004

-- IX. Show the name of each medal winner country 'FRA'.

SELECT name
    FROM ttmd JOIN team ON (ttmd.team = team.id)
  WHERE country = 'FRA'
