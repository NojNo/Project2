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
-- first check if tournament exists, if so, it will be dropped. If not: CREATE DATABASE
\c tournament;
-- You are now connected to database "tournament" as user "vagrant".
DROP TABLE IF EXISTS players;
create TABLE players(player_id SERIAL NOT NULL PRIMARY KEY, name TEXT);
-- first check if Players exists, if so, it will be dropped. If not: CREATE TABLE
DROP TABLE IF EXISTS matches;
create TABLE matches(winner INTEGER REFERENCES (players.player_id), loser INTEGER REFERENCES (players.player_id), match_id SERIAL NOT NULL Primary KEY);
-- first check if Matches exists, if so, it will be dropped. If not: CREATE TABLE
create VIEW number_of_wins AS select players.player_id, players.name, count(matches.winner) AS wins FROM players left join matches on players.player_id = matches.winner group by players.player_id;

create VIEW matches_played AS SELECT players.name, players.player_id, count(*) AS matches FROM players left join matches on players.player_id = matches.winner OR players.player_id = matches.loser group by players.player_id;

create VIEW standings AS SELECT matches_played.player_id, matches_played.name, COALESCE(number_of_wins.wins,0) As wins, COALESCE(matches_played.matches,0) As matches from matches_played left join number_of_wins on matches_played.player_id = number_of_wins.player_id OR wins = 0 Order By wins desc;
