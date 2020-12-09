#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program changes mutated residue with hydrogens added in another input in mopac

tag="$1"
listm="$2"
MOPAC="$3"

if [ -z "$tag" ] || [ -z "$listm" ] || [ -z "$MOPAC" ]
then
  echo "It lacks one or several arguments to execute the script"
  echo "For instance: ./script_H_mut.sh main_name, list_of_mutations and MOPAC path"
  exit 1
else
  echo "Running script... "
fi

for i in `ls ${tag}-*`
do

  #name="$(echo "$i" | cut -d'-' -f2 | cut -d'.' -f1)"
  name="$(echo "$i" | cut -d'.' -f1 | rev | cut -d'-' -f1 | rev)"
  mkdir -p "$name"
  cp addH_m.sh "$name"/
  cp "$i" "$name"/
  cd "$name"/
  ./addH_m.sh "$i" ${MOPAC} #adding hydrogen
  cd ../
  dir="$name/aux-$i"

  #Process below for searching and editing information of residues optimized restrictively

  #j="$(echo "$i" | cut -d'-' -f2 | cut -d'.' -f1 | tr -dc '0-9' | awk '{print substr ($0,0,2)}')"
  j="$(echo "$i" | cut -d'-' -f2 | cut -d'.' -f1)"

  mkdir -p mutation_"$name"
  cp "$listm" mutation_"$name"/

  chain_num="$(awk -v x=$j 'NF=="4" {if ($1==x) {printf "%d.%s\n", $3, toupper($4) }}' $listm)"

  cp "$i" "$tag"_"$name".pdb

  for ch_n in $chain_num
  do

    let num=$(grep -n "ATOM" ${tag}_${name}.pdb | tail -1 | cut -d ":" -f1)

    rnum="$(echo "$ch_n" | cut -d '.' -f1)"
    chain="$(echo "$ch_n" | cut -d '.' -f2)"

    let ini="$(awk -v x=$rnum -v y=$chain '$6~x {if ($5==y) {print NR}}' "$tag"_"$name".pdb | head -1)"-1 #finding the first atom of the residue $chain and $rnum to be changed
    let fin=$(awk -v x=$rnum -v y=$chain '$6~x {if ($5==y) {print NR}}' "$tag"_"$name".pdb | tail -1)+1 #finding the last atom of the residue $chain and $rnum to be changed
    #let ini=$(grep -n "$chain  $rnum" ${tag}_${name}.pdb | head -1 | cut -d ":" -f1)-1
    #let fin=$(grep -n "$chain  $rnum" ${tag}_${name}.pdb | tail -1 | cut -d ":" -f1)+1

    awk 'NR == 1,NR == x {if (NF==12) print $0}' x="$ini" "$tag"_"$name".pdb > aux.pdb #printing all atoms before the main residue

    ini1=$(awk -v x=$rnum -v y=$chain '$6~x {if ($5==y) {print NR}}' "$dir" | head -1) #finding the first atom of the residue $chain and $rnum to be changed
    fin2=$(awk -v x=$rnum -v y=$chain '$6~x {if ($5==y) {print NR}}' "$dir" | tail -1) #finding the last atom of the residue $chain and $rnum to be changed

    #ini1=$(grep -n "$chain  $rnum" $dir | head -1 | cut -d ":" -f1) # line number from the main residue to be changed
    #fin2=$(grep -n "$chain  $rnum" $dir | tail -1 | cut -d ":" -f1) # line number to the main residue to be changed

    awk 'NR == x,NR == y {print $0}' x="$ini1" y="$fin2" "$dir" >> aux.pdb #printing all atoms of the main residue
    awk 'NR == x,NR == y {print $0}' x="$ini1" y="$fin2" "$dir" >> res_charges.pdb #putting all mutations in the residues to be charged pdb

    awk 'NR == x,NR == y {print $0}' x="$fin" y="$num" "$tag"_"$name".pdb >> aux.pdb ##printing all atoms after the main residue

    awk '{gsub(/PROT/,"    "); print $0}' aux.pdb > aux2.pdb
    awk 'BEGIN{i=1} NF=="12"{printf "%2s%7d%-2s%3s %1s%4d%12.3f%8.3f%8.3f%6.2f%6.2f%12s\n",$1,i++,substr($0,12,6),$4,$5,$6,$7,$8,$9,$10,$11,$12}' aux2.pdb > "$tag"_"$name".pdb #renumbering atoms of the molecular structure

  done

  mv "$i" mutation_"$name"/
  mv "$tag"_"$name".pdb mutation_"$name"/

done

rm aux.pdb aux2.pdb

echo "fin"
