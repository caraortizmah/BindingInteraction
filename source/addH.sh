#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates a mopac input file from a pdb file available in mopac


#mopac16="/opt/mopac/MOPAC2016.exe" #Path of mopac program - manual mode

arg="$1"
MOPAC="$2"

if [ -z "$arg" ] || [ -z "$MOPAC" ] #execution of this program waits two additional arguments
then
  echo "It lacks one or several arguments to execute this script"
  echo "For instance: ./addH.sh molecule.pdb and MOPAC path"
  exit 1
else
  echo "Executing addH.sh over "$arg #This argument is an output pdb file from dowser execution
fi

j="$(echo "$arg" | cut -d'.' -f1)" #remove the extension (".pdb") of the file
printf " PDB ADD-H GEO-OK DEBUG PDBOUT\n\n\n" > "$j"_H.mop #Put mopac commands in a .mop file to add hydrogens

awk 'NF=="12"{print $0}' "$arg" >> "$j"_H.mop #adding all atoms of the pdb file to the new mopac input

#mv "$arg" "$arg"-old #Remove auxiliary files

${MOPAC} "$j"_H.mop # Execute input with mopac16
#$mopac16 "$j"_H.mop # Execute input with mopac16 - manual mode

#echo "fin"
