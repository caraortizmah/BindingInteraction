#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program executes a script without graphic environment

#chimera="/opt/UCSF/Chimera64-1.9/bin/chimera" #Path of chimera - manual mode

py="$1"
tag="$2"
CHIMERA="$3"

if [ -z "$py" ] || [ -z "$tag"  ] || [ -z "$CHIMERA" ]
then
  echo "It lacks one or several arguments to execute the script"
  echo "For instance: ./script_chimera_swap.sh name_chimera_script pdbs_main_name and Chimera path"
  exit 1
else
  echo "Running script... "
fi

${CHIMERA} --nogui --script "$py" #execution of chimera without graphic environment
#$chimera --nogui --script "$py" #execution of chimera without graphic environment - manual mode

for i in `ls "$tag"-*.pdb`
do
  sed -i 's/HETATM/ATOM  /g' "$i" #replacing HETATM by ATOM
done
