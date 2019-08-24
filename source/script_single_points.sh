#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program executes mopac16 in all files

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program

for i in `ls mutation_*/ | grep "/" | cut -d':' -f1` #for all folders
do
  
  j="$(echo "${i#*_}" | cut -d'/' -f1)" # cutting in the '_' and returning the second part of the name, in that case the number of the residue
  
  cd "$i"
  mkdir opt_2A_"$j"
  mv *.* opt_2A_"$j"/
  mkdir comp_pep_"$j"
  cp opt_2A_"$j"/1BX2_"$j"_2A.arc comp_pep_"$j"/1BX2_"$j"_ABV.mop
  mkdir pep_"$j"/
  cp opt_2A_"$j"/1BX2_"$j"_2A.arc pep_"$j"/1BX2_"$j"_P.mop

  cd ..

done

for i in `ls mutation_*/ | grep "/" | cut -d':' -f1` #for all folders
do

  j="$(echo "${i#*_}" | cut -d'/' -f1)" # cutting in the '_' and returning the second part of the name, in that case the number of the residue
  cp script_editing_inputs.sh "$i"/
  cd "$i"
  ./script_editing_inputs.sh "$j" # executing script
  cd ..
done

for i in `ls mutation_*/ | grep "/" | cut -d':' -f1` #for all folders
do

  j="$(echo "${i#*_}" | cut -d'/' -f1)" # cutting in the '_' and returning the second part of the name, in that case the number of the residue
  cd "$i"/comp_pep_"$j"/
  $mopac16 1BX2_"$j"_ABV.mop # executing mopac16
  cd ../pep_"$j"/
  $mopac16 1BX2_"$j"_P.mop # executing mopac16
  cd ../../
  echo "calculations for "$j "have finished"
done

