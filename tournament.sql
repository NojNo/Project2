-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

-- In order to be able to run this code, turn vagrant on and log in on Git Bash
-- In the right directory (/vagrant/tournament) you use the command: psql
-- then the following:

DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
-- first check if tournament exists, if so, it will be dropped. 
-- If not: CREATE DATABASE
\c tournament;
-- You are now connected to database "tournament" as user "vagrant".
DROP TABLE IF EXISTS players;
-- if players table exists, drop it, so that we can create a new table 
-- with this name
CREATE TABLE players(player_id SERIAL NOT NULL PRIMARY KEY, name TEXT);
-- players table consists of 2 columns. The PRIMARY KEY, 
-- which is a SERIAL datatype, however never a NULL value, 
-- and the name which is a TEXT-datatype.
DROP TABLE IF EXISTS matches;
-- if matches table exists, drop it, 
-- so that we can create a new table with this name
CREATE TABLE matches(winner INTEGER REFERENCES players(player_id), 
	loser INTEGER REFERENCES 
	players(player_id), match_id SERIAL NOT NULL Primary KEY);
-- matches table consists of 3 columns. 
-- The first 2 columns datatypes are INTEGERs which 
-- REFERENCE to the players´table PRIMARY KEY
-- The last column is the PRIMARY KEY in here, 
-- which is a SERIAL datatype and never a NULL value. 
CREATE VIEW number_of_wins AS 
	SELECT players.player_id, players.name, COUNT(matches.winner) 
	AS wins 
	FROM players LEFT JOIN matches 
	ON players.player_id = matches.winner 
	GROUP BY players.player_id;
-- number_of_wins selects players´ player_id, players´ name and 
-- counts the winner in matches and name it wins. 
-- In order to see players with no wins, as well, 
-- we use a left join with the help of the REFERENCING columns in matches.
-- at the end we group the selection by players´player_id
CREATE VIEW matches_played AS 
	SELECT players.name, players.player_id, COUNT(*) 
	AS matches 
	FROM matches LEFT JOIN players 
	ON players.player_id = matches.winner 
	OR players.player_id = matches.loser 
	GROUP BY players.player_id;
-- matches_played selects players´ name, players´ player_id and 
-- counts everything in matches and name it matches. 
-- In order to see players with no matches, 
-- we use a left join with the help of the REFERENCING columns in matches. 
-- However, this time it is not enough to limit the join condition 
-- on the winner column in matches. 
-- We need to loser column, too. 
-- At the end we group the selection by players´player_id
CREATE view standings AS 
	SELECT a.player_id, a.name, a.wins, COALESCE(b.matches, 0) 
	AS matches 
	FROM number_of_wins AS a LEFT JOIN matches_played AS b 
	ON a.player_id = b.player_id 
	ORDER BY wins DESC;
-- basically, we just put the 2 previous views together with the help of alias. 
-- a stands for number_of_wins and b for matches_played. 
-- We select the player_id, name, and wins from a. and 
-- if a player has no matches in b, then 0 will be displayed 
-- for the number of matches, 
-- else the amount will be counted here. the columns title is matches.
-- this time the join condition is based on the player_ids
-- As we need to have the player listed in descending order, 
-- we add the order by keyword
