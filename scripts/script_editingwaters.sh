#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program finds and puts the selected waters from the list in a .pdb file

arg="$1"
org="$2"

if [ -z "$arg" ] || [ -z "$org" ]                                                                                  
then                                                                                              
  echo "It lacks one or two pdb file to execute the script"                                                  
  echo "For instance: ./script_editingwaters.sh chimera_file.pdb original_cordinates_file.arc"
  exit 1                                                                                          
else                                                                                              
  echo "Executing script_editingwaters over "$arg  "and "$org
fi


sed -i 's/TRE/HOH/g' "$arg" # replacing TRE for HOH
sed -i 's/OW/O /g' "$arg" # replacing OW for O
sed -i 's/HETATM/ATOM   /g' "$arg" # replacing HETATM for ATOM

awk '{if ($5=="A" || $5=="B" || $5=="P") printf "%s%7d%-2s%3s %1s%4s%12.3f%8.3f%8.3f%6.2f%6.2f%12s\n",$1,$2,substr($0,12,6),$4,$5,$6,$7,$8,$9,$10,$11,$12}' "$arg" > aux_waters.pdb  #rewriting molecule in a .pdb file

for i in $(awk 'NF==12 {print $6}' list_waters.pdb | sort -u | sort -n) #selecting lines of the list file that has the same format of the .pdb file and print just the number of the residue
do
  echo "$i"
  awk '$6 == x {if ($5=="V") printf "%s%7d%-2s%3s %1s%4s%12.3f%8.3f%8.3f%6.2f%6.2f%12s\n",$1,$2,substr($0,12,6),$4,$5,$6,$7,$8,$9,$10,$11,$12}' x="$i" "$arg" >> aux_waters.pdb #copying in an auxiliar .pdb file all sentence line that belongs to the residue with number $i and chain V of the changed molecule
done

awk '{if ($5=="A" || $5=="B" || $5=="P") printf "  %s%7d%-2s%4s %1s%5s%13.8f%3s%13.8f%3s%13.8f%3s\n",$1,$2,substr($0,16,5),$4,$5,$6,$7,$8,$9,$10,$11,$12}' "$org" > aux_waters.arc #rewriting original molecule in a .arc file

for i in $(awk 'NF==12 {print $6}' list_waters.pdb | sort -u | sort -n) #selecting lines of the list file that has the same format of the .pdb file and print just the number of the residue
do
  echo "$i"
  awk 'int($6) == x {if ($5=="V") printf "  %s%7d%-2s%4s %1s%5s%13.8f%3s%13.8f%3s%13.8f%3s\n",$1,$2,substr($0,16,5),$4,$5,$6,$7,$8,$9,$10,$11,$12}' x="$i" "$org" >> aux_waters.arc #copying in an auxiliar .arc file all sentence line that belongs to the residue with number $i and chain V of the original molecule
done

# rewriting in two formats

awk 'BEGIN{i=1} NF=="12"{printf "%s%7d%-2s%3s %1s%4s%12.3f%8.3f%8.3f%6.2f%6.2f%12s\n",$1,i++,substr($0,12,6),$4,$5,$6,$7,$8,$9,$10,$11,$12}' aux_waters.pdb > 1BX2_for_mutations.pdb

awk 'BEGIN{i=1} NF=="12"{printf "  %s%7d%-2s%4s %1s%5s%13.8f%3s%13.8f%3s%13.8f%3s\n",$1,i++,substr($0,16,5),$4,$5,$6,$7,$8,$9,$10,$11,$12}' aux_waters.arc > 1BX2_coord_complete.arc

rm aux_waters.pdb aux_waters.arc

echo "fin"
