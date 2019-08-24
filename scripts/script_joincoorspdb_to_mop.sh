#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates an input for optimizing restrictively the mono-substituted residue

arg="$1"
org="$2"

if [ -z "$arg" ] || [ -z "$org" ] #asking for arguments $arg and $org to start the program
then
  echo "It lacks one or two pdb file to execute the script"
  echo "For instance: ./script_pdb_to_mop.sh mutation_resid_file.pdb original_cordinates_file.arc"
  exit 1                                                                                          
else
  echo "Executing script_pdb_to_mop.sh over "$arg  "and "$org
fi


sed -i 's/TRE/HOH/g' "$arg" #replacing all words with TRE by HOH
sed -i 's/OW/O /g' "$arg" #replacing all words with OW by O
sed -i 's/HETATM/ATOM   /g' "$arg" #replacing all words with HETATM by ATOM

name="$(echo "${arg#*_}" | cut -d'.' -f1)" #cutting argument in the first '_' and the extension of the name of the file, and returning all characters after the '_'
let j="$(echo "$arg" | cut -d'_' -f2 | cut -d'.' -f1 | tr -dc '0-9')" # returning just the number (position of the residue) in the name of the file 

let ini=$(grep -n "P  $j" $org | head -1 | cut -d ":" -f1)-1 #finding the first atom of the residue $j in the original molecule
let fin=$(grep -n "P  $j" $org | tail -1 | cut -d ":" -f1)+1 #finding the last atom of the residue $j in the original molecule

awk 'NR == 1,NR == x {if (NF==12) printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,$2,substr($0,16,5),$4,$5,$6,$7,$9,$11}' x="$ini" "$org" > aux.pdb  #editing a new pdb file with the new mono-substituted residue with coortinates of $org file intul the firts atom in the original molecule

let ini1=$(grep -n "P  $j" "$arg" | head -1 | cut -d ":" -f1) #finding the first atom of the residue $j in the mono-substituted molecule
let fin2=$(grep -n "P  $j" "$arg" | tail -1 | cut -d ":" -f1) #finding the last atom of the residue $j in the mono-substituted molecule

awk 'NR == x,NR == y {if (NF==12) printf "  %s(%s%7d%-2s%3s %1s%4d)%13.8f%13.8f%13.8f\n",$12,$1,$2,substr($0,12,6),$4,$5,$6,$7,$8,$9}' x="$ini1" y="$fin2" "$arg" >> aux.pdb # adding in the same last file the coordinates of the mono-subtituted residue 

awk 'NR == x,NR == y {if (NF==12) printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,$2,substr($0,16,5),$4,$5,$6,$7,$9,$11}' x="$fin" y="$num" "$org" >> aux.pdb # adding in the last file the coordinates of the rest of atoms of the original molecule

res=$j; printf " PM7 LET PL OPT(\"P %d\"=2.0) RAPID MOZYME NSPA=122 EPS=78.4 GNORM=20 GEO-OK THREADS=4 DEBUG PBDOUT AUX\n\n\n" "$j" > 1BX2_"$name"_2A.mop # creating flags for the restricted optimization in a .mop file according to the mono-substituted residue

awk 'BEGIN{i=1} NF=="9"{printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,5),$4,$5,$6,$7,$8,$9}' aux.pdb >> 1BX2_"$name"_2A.mop #rewriting in the same .mop file all edited coordinates of the aux.pdb

rm aux.pdb

echo "fin"
