#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program converts a .arc file into a .pdb file

chimera="/opt/UCSF/Chimera64-1.9/bin/chimera" #Path of chimera

py="$1"
tag="$2"

if [ -z "$py" ] || [ -z "$tag"  ]
then                                                                                              
  echo "It lacks one or more arguments to execute the script"                                                  
  echo "For instance: ./script_chimera_swap.sh name_chimera_script pdbs_main_name"
  exit 1                                                                                          
else                                                                                              
  echo "Running script... "
fi

$chimera --nogui --script "$py" #execution of chimera without graphic environment

for i in `ls "$tag"-*.pdb`
do
  sed -i 's/HETATM/ATOM  /g' "$i" #replacing HETATM by ATOM
done
