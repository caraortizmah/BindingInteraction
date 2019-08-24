#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates an input in mopac to add hydrogens in a molecule

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program

for i in `ls *.pdb`
do
  
  j="$(echo "$i" | cut -d'.' -f1)"
  printf " PDB ADD-H DEBUG AUX PDBOUT\n\n\n" > "$j".mop

  awk 'NF=="12"{print $0}' "$i" >> "$j".mop
  
  mv "$i" "$i".old

  $mopac16 "$j".mop 

  mv "$j".pdb aux-"$i"

  echo "fin"
done
