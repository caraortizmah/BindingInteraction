#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program changes a mopac output into a new input file with other specific instructions

mopac16="/opt/mopac/MOPAC2016.exe" #Path of mopac program

arg="$1"

if [ -z "$arg" ] #execution of this program waits an additional argument
then
  echo "It lacks one argument to execute the script"                                                  
  echo "For instance: ./script_optH_to_optall.sh output_file.arc"
  exit 1
else
  echo "Executing script_optH_to_optall.sh over "$arg #This argument is an output pdb file from dowser execution
fi

printf " PM7 LET MOZYME GEO_REF=\"SELF\" GNORM=20 GEO-OK PDBOUT HTML\n\n\n" > input_Optall.mop #Put mopac commands in a .mop file to optimize restrictively from the initial geometry

awk 'BEGIN{i=1} NF=="12"{printf "  %6s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,$2,substr($0,16,6),$4,$5,$6,$7,$9,$11}' "$arg" >> input_Optall.mop #adding all atoms from the input_OptH.arc to the new mopac input

$mopac16 input_Optall.mop # Execute input with mopac16

echo "fin"
