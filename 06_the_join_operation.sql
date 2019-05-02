-- I. Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

SELECT matchid, player FROM goal
  WHERE teamid = 'GER'

-- II. Show id, stadium, team1, team2 for just game 1012

SELECT id, stadium, team1, team2 FROM game
  WHERE id = 1012

-- III. Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id = matchid)
  WHERE teamid = 'GER'

-- IV. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
  WHERE player LIKE 'Mario%'

-- V. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (teamid=id)
  WHERE gtime <= 10

-- VI. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
  FROM game JOIN eteam ON (team1 = eteam.id)
  WHERE coach = 'Fernando Santos'

-- VII. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player
  FROM game JOIN goal ON (id=matchid)
  WHERE stadium = 'National Stadium, Warsaw'

-- VIII. Instead show the name of all players who scored a goal against Germany.

SELECT DISTINCT player
  FROM game JOIN goal ON (matchid = id)
  WHERE (team1 = 'GER' OR team2 = 'GER')
  AND teamid <> 'GER'

-- IX. Show teamname and the total number of goals scored.

SELECT teamname, COUNT(gtime)
  FROM goal JOIN eteam ON (teamid=id)
  GROUP BY teamname

-- X. Show the stadium and the number of goals scored in each stadium.

SELECT stadium, COUNT(gtime)
  FROM game JOIN goal ON (id=matchid)
  GROUP BY stadium

-- XI. For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid, mdate, COUNT(gtime)
  FROM game JOIN goal ON (id = matchid)
  WHERE (team1 = 'POL' OR team2 = 'POL')
  GROUP BY matchid, mdate

-- XII. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(gtime)
  FROM game JOIN goal ON (id = matchid)
  WHERE teamid = 'GER'
  GROUP BY matchid, mdate

-- XIII. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
Sort your result by mdate, matchid, team1 and team2.

SELECT mdate,
  team1,
    SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
  team2,
    SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2,
  FROM game LEFT JOIN goal ON (matchid = id)
  GROUP BY mdate, team1, team2
  ORDER BY mdate, matchid, team1, team2
