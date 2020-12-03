#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program changes a dowser output file into a pdb file available in mopac


arg="$1"
mop="$2"

if [ -z "$arg" ] || [ -z "$mop" ] #execution of this program waits two additional arguments
then
  echo "It lacks one or two arguments to execute the script"                                                  
  echo "For instance: ./script_clean_O.sh molecule_dowser_waters.pdb mol_dowser_water_mopac.out" 
  exit 0
else
  echo "Executing script_clean_O.sh over "$arg and $mop #This argument is an output pdb file from dowser execution
fi



if [ -z "$(grep -n "FAULT DETECTED BY KEYWORD" "$mop")" ]
then
  echo "Geometry Ok"
else 
  let var=$(grep -n "FAULT DETECTED BY KEYWORD" "$mop" | cut -d ":" -f1)
  let var_1=$var-2
  let num_o=$(sed -n "$var_1"p "$mop" | awk '{print $2}')
  
  let res_num=$(awk -v x=$num_o 'BEGIN{i=1; j=1} NF=="12"{if ($2 ==x && $5 =="W") print $6}' "$arg") 
  
  awk -v x=$res_num 'BEGIN{j=1} NF=="12"{if (!($5 =="W" && $6 ==x)) {printf "%s%7d  %-3s %3s %s%4d%12.3f%8.3f%8.3f  %3.2f  %3.2f%12s\n",$1,j++,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12}}' "$arg" > new_"$arg" #deleting one remaining water and renumbering atoms 

  #mv "$arg" "$arg"_old
  #mv new_"$arg" "$arg"

fi

./addH.sh new_"$arg"

