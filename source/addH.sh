#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates a mopac input file from a pdb file available in mopac


mopac16="/opt/mopac/MOPAC2016.exe" #Path of mopac program

arg="$1"

if [ -z "$arg" ] #execution of this program waits two additional arguments
then
  echo "It lacks one argument to execute the script"                                                  
  echo "For instance: ./addH.sh molecule.pdb" 
  exit 0
else
  echo "Executing script_clean_O.sh over "$arg #This argument is an output pdb file from dowser execution
fi

j="$(echo "$arg" | cut -d'.' -f1)" #remove the extension (".pdb") of the file
printf " PDB ADD-H GEO-OK DEBUG AUX PDBOUT\n\n\n" > "$j"_H.mop #Put mopac commands in a .mop file to add hydrogens

awk 'NF=="12"{print $0}' "$arg" >> "$j"_H.mop #adding all atoms of the pdb file to the new mopac input

#mv "$arg" "$arg"-old #Remove auxiliar files
$mopac16 "$j"_H.mop # Execute input with mopac16

echo "fin"
