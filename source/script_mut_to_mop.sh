#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates an input for optimizing restrictively the substituted residue

tag="$1"
arc="$2"
listm="$3"

if [ -z "$tag" ] || [ -z "$arc"  ] || [ -z "$listm" ]
then                                                                                              
  echo "It lacks one or more arguments to execute the script"                                                  
  echo "For instance: ./script_mut_to_mop.sh main_name arc_file mutation_list"
  exit 1                                                                                          
else                                                                                              
  echo "Running script... "
fi

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program

for i in `ls mutation_*/ | grep "/" | cut -d':' -f1` #for all folders
do
  
  j="$(echo "${i#*_}" | cut -d'/' -f1)" # cutting in the '_' and returning the second part of the name, in that case the number of the residue
  cp "$arc" "$i" #copying coordinates
  cp script_joincoorspdb_to_mop.sh "$i" #copying script 
  cd "$i"
  ./script_joincoorspdb_to_mop.sh "$tag"_"$j".pdb "$arc" "$tag" "$listm" # executing script that use original coordinates (.arc file) and the mono-substituted residue (.pdb file) to create a .mop file
  cd ..

done

echo "optimizing around 2 Angstroms"
mkdir -p tobe_charged
cp "$tag"_noW.pdb tobe_charged/
cp "$tag"_noW.arc tobe_charged/
cp res_charges.pdb tobe_charged/

for i in `ls mutation_*/ | grep "/" | cut -d':' -f1` # for all folders
do

  j="$(echo "${i#*_}" | cut -d'/' -f1)" # for all .mop files created before
  cd "$i"
  $mopac16 "$tag"_"$j"_2A.mop # executing mopac in all files

  cp "$tag"_"$j"_2A.pdb ../tobe_charged/
  cp "$tag"_"$j"_2A.arc ../tobe_charged/
  cd ..
done
