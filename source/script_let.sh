#!/bin/bash

arg="$1"

if [ -z "$arg" ]
then
  echo "It lacks one argument to execute the script"
  echo "For instance: ./script_let.sh name of the new file"
  exit 1
else
  echo "Executing script_let.sh over "$arg
fi

set_val="$(echo -n `awk '$7<0{printf "%s%d(-),",$4,$3}; $7>0{printf "%s%d(+),",$4,$3}' chosen_charges` | head -c -1)"
echo " LET SITE=($set_val)" > "$arg"
  
printf "\n\n" >> "$arg"
