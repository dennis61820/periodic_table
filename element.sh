#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"






 if [[ -z $1 ]]
  then
    echo  "Please provide an element as an argument."
  elif [[ $1 =~ ^[0-9]+$ ]]
    then 
    echo -e "\n~~~~~ Periodic Info ~~~~~\n"
    ELEMENT=$($PSQL "select melting_point_celsius from properties where atomic_number = $1 ")
  elif [[ ${#1} > 3 ]]
    then
     ELEMENT=$($PSQL "select melting_point_celsius from properties as p left join elements using(atomic_number) where name = '$1' ")
  else
      ELEMENT=$($PSQL "select melting_point_celsius from properties where symbol = '$1' ")
  fi
 
answer=$($PSQL "")