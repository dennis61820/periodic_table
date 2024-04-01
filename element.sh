#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


 if [[ -z $1 ]]
  then
    echo  "Please provide an element as an argument."
   else
  
      if [[ $1 =~ ^[0-9]+$ ]]
        then 
          ELEMENT="atomic_number"
          ATOMIC_NUMBER=$1
          NAME=$($PSQL "select name from elements where atomic_number = $1")
          SYMBOL=$($PSQL "select symbol from elements where atomic_number = $1")
          TYPE=$($PSQL "select t.type from types as t join properties as p using(type_id) where p.$ELEMENT = $1")
          MASS=$($PSQL "select atomic_mass from properties where atomic_number = $1")
          MELT=$($PSQL "select melting_point_celsius from properties where atomic_number = $1")
          BOIL=$($PSQL "select boiling_point_celsius from properties where atomic_number = $1")
        
      elif [[ ${#1} > 3 ]]
        then
          ELEMENT="name"
          ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where name = '$1'")
          NAME=$1
          SYMBOL=$($PSQL "select symbol from elements where name = '$1'")
          TYPE=$($PSQL "select t.type from types as t join properties as p using(type_id) join elements as e using(atomic_number) where e.$ELEMENT = '$1'")
          MASS=$($PSQL "select p.atomic_mass from properties as p join elements as e using(atomic_number) where e.name = '$1' ")
          MELT=$($PSQL "select p.melting_point_celsius from properties as p join elements as e using(atomic_number) where e.name = '$1' ")
          BOIL=$($PSQL "select p.boiling_point_celsius from properties as p join elements as e using(atomic_number) where e.name = '$1' ")
      else
          ELEMENT="symbol"
          ATOMIC_NUMBER=$($PSQL "select atomic_number from elements where symbol = '$1'")
          NAME=$($PSQL "select name from elements where symbol = '$1'")
          SYMBOL=$1
          TYPE=$($PSQL "select t.type from types as t join properties as p using(type_id) join elements as e using(atomic_number) where e.symbol = '$1'")
          MASS=$($PSQL "select p.atomic_mass from properties as p join elements as e using(atomic_number) where e.symbol = '$1'")
          MELT=$($PSQL "select p.melting_point_celsius from properties as p join elements as e using(atomic_number) where e.symbol = '$1'")
          BOIL=$($PSQL "select p.boiling_point_celsius from properties as p join elements as e using(atomic_number) where e.symbol = '$1'")
      fi
      if [[ -z $TYPE ]]
          then
          echo "I could not find that element in the database."
      else
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      fi

fi




