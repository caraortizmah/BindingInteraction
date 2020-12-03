#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates a chimera script for python. The new script can change residues froma pdb input.

dir="$1"
name="$2"
listm="$3"

if [ -z "$dir" ] || [ -z "$name" ] || [ -z "$listm" ]
then                                                                                              
  echo "It lacks one or two pdb file to execute the script"                                                  
  echo "For instance: ./mutmaker.sh path name_pdb list_mutations"
  exit 1                                                                                          
else                                                                                              
  echo "Creating a chimera script "
fi

#tag="$(echo "$name" | cut -d'.' -f1)"
tag="$(awk -F '_noW'  '{print $1}'  <<<  "$name")"

cat << EOF > script_chimera_mut.py
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This python program calls some routines in chimera to creates the substitutions using Dunbrack library


import os, sys
from chimera import runCommand as rc # use 'rc' as shorthand for runCommand
from chimera import replyobj # for emitting status messages

# change to folder with data files
os.chdir("$dir")


EOF

let linen=$(grep -n "*** Begin" "$listm" | cut -d ":" -f1) #detecting the line number of the search 
let linen=$linen+4 # line position of the features

#llist=$(awk -v x=$linen 'NF=="4" && NR>=x {printf "%s%d\n", toupper($3),$2}' "$listm") #specific search using as filter NF and NR and returning 2ns and 3rd columns
llist_name=$(awk -v x=$linen 'NF=="4" && NR>=x {print $1}' "$listm") #specific search using as filter NF and NR and returning first column
listu=$(echo "$llist_name" | sort -u) #removing duplicates

for i in $listu
do
  printf "rc (\"open $name\") #1)\n" >> script_chimera_mut.py
  awk -v x=$linen -v y=$i 'NR>=x {if ($1==y) {printf "rc (\"swapaa %s #0:%s.%s\") #2)\n", $2, $3, $4}}' "$listm"  >> script_chimera_mut.py
  printf "rc (\"write format pdb 0 ${tag}-${i}.pdb\") #3)\n" >> script_chimera_mut.py
  printf "rc (\"close #0\") #4)\n\n" >> script_chimera_mut.py
done

printf "rc (\"open $name\") #1)\n" >> script_chimera_mut.py
printf "rc (\"select #0: .P za<8\") #5)\n" >> script_chimera_mut.py
printf "rc (\"write selected format pdb 0 res_charges.pdb\") #3)\n" >> script_chimera_mut.py
printf "rc (\"close #0\") #4)\n\n" >> script_chimera_mut.py

cat << EOF >> script_chimera_mut.py
#------------
#1) opening the original geometry
#2) swapping a residue
#3) writing the new format
#4) closing .pdb file
#5) selecting 8-Angstrom radii from chain P (ligand)

EOF

mv script_chimera_mut.py chimera_mut_"$tag".py
