#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates a mopac input file from a pdb file available in mopac


mopac16="/opt/mopac/MOPAC2016.exe" #Path of mopac program

arg="$1"

if [ -z "$arg" ] #execution of this program waits two additional arguments
then
  echo "It lacks one argument to execute the script"                                                  
  echo "For instance: ./checkst.sh molecule.pdb" 
  exit 0
else
  echo "Executing chechst.sh over "$arg #This argument is an output pdb file from dowser execution
fi

j="$(echo "$arg" | cut -d'.' -f1)" #remove the extension (".pdb") of the file
printf " PDB CHECK DEBUG\n\n\n" > check_"$j".mop #Put mopac commands in a .mop file to add hydrogens

awk 'NF=="12"{print $0}' "$arg" >> check_"$j".mop #adding all atoms of the pdb file to the new mopac input

#mv "$arg" "$arg"-old #Remove auxiliar files
$mopac16 check_"$j".mop # Execute input with mopac16

echo "fin"

./script_clean_O.sh "$arg" check_"$j".out
