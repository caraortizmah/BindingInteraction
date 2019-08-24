#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates a mopac input file from a pdb file available in mopac


mopac16="/opt/mopac/MOPAC2016.exe" #Path of mopac program

for i in `ls *.pdb` #for each pdb files, program execute the lines below
do
  
  j="$(echo "$i" | cut -d'.' -f1)" #remove the extension (".pdb") of the file
  printf " PDB ADD-H DEBUG AUX PDBOUT\n\n\n" > "$j".mop #Put mopac commands in a .mop file to add hydrogens

  awk 'NF=="12"{print $0}' "$i" >> "$j".mop #adding all atoms of the pdb file to the new mopac input

  mv "$i" "$i"-old #Remove auxiliar files
  $mopac16 "$j".mop # Execute input with mopac16

  echo "fin"
done
