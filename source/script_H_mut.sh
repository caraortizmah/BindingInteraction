#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program changes mutated residue with hydrogens added in another input in mopac

for i in `ls 1BX2_geom_chim-*`
do

  name="$(echo "$i" | cut -d'-' -f2 | cut -d'.' -f1)"
  mkdir "$name"
  cp script_addH.sh "$name"/ #adding hydrogen
  cp "$i" "$name"/
  cd "$name"/
  ./script_addH.sh
  cd ../
  dir="$name/aux-$i"

  #Process below for searching and editing information of residues optimized restrictively

  j="$(echo "$i" | cut -d'-' -f2 | cut -d'.' -f1 | tr -dc '0-9' | awk '{print substr ($0,0,2)}')"

  let num=$(grep -n "V" $i | tail -1 | cut -d ":" -f1)

  let ini=$(grep -n "P  $j" $i | head -1 | cut -d ":" -f1)-1 #line number before the main residue to be changed
  let fin=$(grep -n "P  $j" $i | tail -1 | cut -d ":" -f1)+1 #line number after the main residue to be changed

  awk 'NR == 1,NR == x {if (NF==12) print $0}' x="$ini" "$i" > aux.pdb #printing all atoms before the main residue

  let ini1=$(grep -n "P  $j" "$dir" | head -1 | cut -d ":" -f1) # line number from the main residue to be changed
  let fin2=$(grep -n "P  $j" "$dir" | tail -1 | cut -d ":" -f1) # line number to the main residue to be changed

  awk 'NR == x,NR == y {print $0}' x="$ini1" y="$fin2" "$dir" >> aux.pdb #printing all atoms of the main residue
  awk 'NR == x,NR == y {print $0}' x="$ini1" y="$fin2" "$dir" >> res_charges.pdb #putting all mutations in the residues to be charged pdb

  awk 'NR == x,NR == y {print $0}' x="$fin" y="$num" "$i" >> aux.pdb ##printing all atoms after the main residue

  awk '{gsub(/PROT/,"    "); print $0}' aux.pdb > aux2.pdb
  awk 'BEGIN{i=1} NF=="12"{printf "%2s%7d%-2s%3s %1s%4d%12.3f%8.3f%8.3f%6.2f%6.2f%12s\n",$1,i++,substr($0,12,6),$4,$5,$6,$7,$8,$9,$10,$11,$12}' aux2.pdb > 1BX2_"$name".pdb #renumbering atoms of the molecular structure
 
  mkdir mutation_"$name"
  mv "$i" mutation_"$name"/
  mv 1BX2_"$name".pdb mutation_"$name"/ 
done

rm aux.pdb aux2.pdb

echo "fin"
