#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates an input in mopac to add hydrogens in a molecule

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program

arg="$1"

if [ -z "$arg" ] #execution of this program waits two additional arguments
then
  echo "It lacks one argument to execute the script"                                                  
  echo "For instance: ./addH_m.sh molecule.pdb" 
  exit 0
else
  echo "Executing addH_m.sh over "$arg #This argument is an output pdb file from dowser execution
fi

j="$(echo "$arg" | cut -d'.' -f1)"

printf " PDB ADD-H DEBUG AUX PDBOUT\n\n\n" > "$j".mop
awk 'NF=="12"{print $0}' "$arg" >> "$j".mop

mv "$arg" "$arg".old
$mopac16 "$j".mop 
mv "$j".pdb aux-"$arg"

echo "fin"
