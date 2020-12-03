#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program changes a mopac output into a new input file with other specific instructions

mopac16="/opt/mopac/MOPAC2016.exe" #Path of mopac program

arg="$1"

if [ -z "$arg" ] #execution of this program waits an additional argument
then
  echo "It lacks one argument to execute the script"                                                  
  echo "For instance: ./script_addH_tooptH.sh output_addH_file.arc"
  exit 1
else
  echo "Executing script_addH_tooptH.sh over "$arg #This argument is an output pdb file from dowser execution
fi

printf " PM7 LET NOOPT OPT-H MOZYME GEO_OK NSPA=122 EPS=78.4 GNORM=20 PDBOUT HTML\n\n\n" > input_OptH.mop #Put mopac commands in a .mop file to optimize all hydrogens with implicit solvent COSMO


awk 'BEGIN{i=1} NF=="12"{printf "  %6s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,$2,substr($0,16,6),$4,$5,$6,$7,$9,$11}' "$arg" >> input_OptH.mop #adding all atoms of the "$arg" file to the new mopac input

$mopac16 input_OptH.mop # Execute input with mopac16

echo "fin"
