#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL"TRUNCATE TABLE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != "year" ]]
then
  # insert name into name column of teams table
  INSERT_WINNER_NAME=$($PSQL"INSERT INTO teams(name) VALUES('$WINNER')")
  INSERT_OPPONENT_NAME=$($PSQL"INSERT INTO teams(name) VALUES('$OPPONENT')")
  # get winner id
  WINNER_ID=$($PSQL"SELECT team_id FROM teams WHERE name='$WINNER'")
  # get opponent id
  OPPONENT_ID=$($PSQL"SELECT team_id FROM teams WHERE name='$OPPONENT'")
  # insert games to games table
  INSERT_GAME=$($PSQL"INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
fi
done 
