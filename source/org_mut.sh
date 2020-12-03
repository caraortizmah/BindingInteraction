#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program manages all script from the mutation part in the BindingInteraction pipeline.

dir="$1"
name="$2"
listm="$3"

if [ -z "$dir" ] || [ -z "$name" ] || [ -z "$listm" ]
then                                                                                              
  echo "It lacks one or more arguments to execute the script"                                                  
  echo "For instance: ./org_mut.sh path name_pdb list_mutations" # arc_file"
  exit 1                                                                                          
else                                                                                              
  echo "Running script... "
fi

tag=$(awk -F '_noW'  '{print $1}'  <<<  "$name")

./mutmaker.sh "$dir" "$name" "$listm"
./script_chimera_swap.sh chimera_mut_"$tag".py "$tag"
./script_H_mut.sh "$tag" "$listm"
./script_mut_to_mop.sh "$tag" "$tag"_noW.arc "$listm"
./script_res_charges.sh

echo "Mutation script finished"
