#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates an input for optimizing restrictively the mono-substituted residue

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program

for i in `ls mutation_*/ | grep "/" | cut -d':' -f1` #for all folders
do
  
  j="$(echo "${i#*_}" | cut -d'/' -f1)" # cutting in the '_' and returning the second part of the name, in that case the number of the residue
  cp 1BX2_coord_complete.arc "$i" #copying coordinates
  cp script_joincoorspdb_to_mop.sh "$i" #copying script 
  cd "$i"
  ./script_joincoorspdb_to_mop.sh 1BX2_"$j".pdb 1BX2_coord_complete.arc # executing script that use original coordinates (.arc file) and the mono-substituted residue (.pdb file) to create a .mop file
  cd ..

done

echo "optimizing around 2 Angstroms"

for i in `ls mutation_*/ | grep "/" | cut -d':' -f1` # for all folders
do

  j="$(echo "${i#*_}" | cut -d'/' -f1)" # for all .mop files created before
  cd "$i"
  $mopac16 1BX2_"$j"_2A.mop # executing mopac in all files
  cd ..
done
