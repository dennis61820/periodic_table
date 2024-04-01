#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=<database_name> -t --no-align -c"

echo -e "\n~~~~~ Periodic Info ~~~~~\n"




 if [[ -z $1 ]]
  then
    echo -e "\nPlease provide an element as an argument."
  elif [[ $1 =~ ^[0-9]+$ ]]
    then 
      NUMBER=$($PSQL "select ")
  elif [[ ${#1} > 3 ]]
    then
      $1=NAME
  else
      $1=SYMBOL
  fi
  echo 
#echo -e "\nI could not find that element in the database."
