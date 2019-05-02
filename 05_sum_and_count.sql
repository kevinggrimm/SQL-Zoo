-- I. Show the total population of the world.

SELECT SUM(population) FROM world

-- II. List all the continents - just once each.

SELECT DISTINCT continent FROM world

-- III. Give the total GDP of Africa

SELECT SUM(gdp) FROM world
  WHERE continent = 'Africa'

-- IV. How many countries have an area of at least 1000000

SELECT COUNT(name) FROM world
  WHERE area >= 1000000

-- V. What is the total population of ('Estonia', 'Latvia', 'Lithuania')

SELECT SUM(population) FROM world
  WHERE name IN('Estonia', 'Latvia', 'Lithuania')
  
-- VI. For each continent show the continent and number of countries.

SELECT continent, COUNT(name) FROM world
  GROUP BY continent

-- VII. For each continent show the continent and number of countries with populations of at least 10 million.

SELECT continent, COUNT(name) FROM world
  WHERE population >= 10000000
GROUP BY continent

-- VIII. List the continents that have a total population of at least 100 million.

SELECT DISTINCT continent FROM world
  GROUP BY (continent)
HAVING SUM(population) >= 100000000
