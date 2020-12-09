#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program changes a mopac output into a new input file with other specific instructions


arg="$1"

if [ -z "$arg" ] #execution of this program waits an additional argument
then
  echo "It lacks one argument to execute this script"
  echo "For instance: ./script_arc_to_pdb.sh arc file"
  exit 1
else
  echo "Executing arc_to_pdb.sh over "$arg #This argument is an output pdb file from dowser execution
fi

j="$(echo "$arg" | cut -d'.' -f1)" #Remove the extension (".arc") of the file
awk 'NF=="12"{printf "ATOM%7d%-2s%3s %1s%4d%12.3f%8.3f%8.3f  1.00  0.00%12s\n",$2,substr($0,16,6),$4,$5,$6,$7,$9,$11,substr($1,1,1)}' "$arg" >> "$j".pdb #Set pdb format to output .arc file

echo "fin"
