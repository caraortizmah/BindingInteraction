#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates an input in mopac to add hydrogens in a molecule

#mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program - manual mode

arg="$1"
MOPAC="$2"

if [ -z "$arg" ] || [ -z "$MOPAC" ] #execution of this program waits two additional arguments
then
  echo "It lacks one or several arguments to execute the script"
  echo "For instance: ./addH_m.sh molecule.pdb and MOPAC path"
  exit 1
else
  echo "Executing addH_m.sh over "$arg #This argument is an output pdb file from dowser execution
fi

j="$(echo "$arg" | cut -d'.' -f1)"

printf " PDB ADD-H DEBUG AUX PDBOUT\n\n\n" > "$j".mop
awk 'NF=="12"{print $0}' "$arg" >> "$j".mop

mv "$arg" "$arg".old
${MOPAC} "$j".mop
#$mopac16 "$j".mop # manual mode
mv "$j".pdb aux-"$arg"

echo "fin"
