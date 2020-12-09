#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program creates an input for optimizing restrictively the mono- or multiple-substituted residue

arg="$1"
org="$2"
tag="$3"
listm="$4"

if [ -z "$arg" ] || [ -z "$org" ] || [ -z "$tag" ] || [ -z "$listm" ] #asking for arguments $arg and $org to start the program
then
  echo "It lacks one or several arguments to execute the script"
  echo "For instance: ./script_joincoorspdb_to_mop.sh mutation_resid_file.pdb, original_cordinates_file.arc, main_name and mutation_list"
  exit 1
else
  echo "Executing script_pdb_to_mop.sh over "$arg", "$org ", "$tag " and "$listm
fi


sed -i 's/TRE/HOH/g' "$arg" #replacing all words with TRE by HOH
sed -i 's/OW/O /g' "$arg" #replacing all words with OW by O
sed -i 's/HETATM/ATOM   /g' "$arg" #replacing all words with HETATM by ATOM

name="$(echo "${arg#*_}" | cut -d'.' -f1)" #cutting argument in the first '_' and the extension of the name of the file, and returning all characters after the '_'
#j="$(echo "$arg" | cut -d'_' -f2 | cut -d'.' -f1 | tr -dc '0-9')" # returning just the number (position of the residue) in the name of the file

j="$(echo "$arg" | cut -d'_' -f2 | cut -d'.' -f1)"
chain_num="$(awk -v x=$j 'NF=="4" {if ($1==x) {printf "%d.%s\n", $3, toupper($4) }}' $listm)"

echo "chain_num: " $chain_num
cp "$arg" aux.pdb

opt_local=""
opt_l=""
count=0

for ch_n in $chain_num
  do

    let count=$count+1

    rnum="$(echo "$ch_n" | cut -d '.' -f1)"
    chain="$(echo "$ch_n" | cut -d '.' -f2)"
    rnum_s=${rnum}")"
    echo $rnum_s

    num=$(grep -n "ATOM" $org | tail -1 | cut -d ":" -f1) #finding the last number of the line with coordinates.

    let ini="$(awk -v x=$rnum_s -v y=$chain '$6==x {if ($5==y) {print NR}}' "$org" | head -1)"-1 #finding the first atom of the residue $chain and $rnum in the original molecule
    let fin=$(awk -v x=$rnum_s -v y=$chain '$6==x {if ($5==y) {print NR}}' "$org" | tail -1)+1 #finding the last atom of the residue $chain and $rnum in the original molecule
    #Differences by "" between commands in $ini and $fin execute the same command.
    #let ini=$(grep -n "$chain  $rnum" $org | head -1 | cut -d ":" -f1)-1 #finding the first atom of the residue $j in the original molecule
    #let fin=$(grep -n "$chain  $rnum" $org | tail -1 | cut -d ":" -f1)+1 #finding the last atom of the residue $j in the original molecule

    # | Part 1
    awk -v x=$ini 'NR == 1,NR == x {if (NF==12) printf "  %s%7d%-2s%4s %1s%5s%13.8f%3s%13.8f%3s%13.8f%3s\n",$1,$2,substr($0,16,5),$4,$5,$6,$7,$8,$9,$10,$11,$12}' "$org" > aux_2.pdb
    #editing a new pdb file with the new mono-substituted residue with coortinates of $org file until the firts atom in the original molecule

    #awk -v x=$ini 'NR == 1,NR == x {if (NF==12) printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,$2,substr($0,16,5),$4,$5,$6,$7,$9,$11}' "$org" > aux_2.pdb  #editing a new pdb file with the new mono-substituted residue with coortinates of $org file until the firts atom in the original molecule | Part 1

    ini1=$(gawk -v x=$rnum -v y=$chain '$6==x {if ($5==y) {print NR}}' aux.pdb | head -1) #finding the first atom of the residue $chain and $rnum in the mono-substituted molecule
    fin2=$(gawk -v x=$rnum -v y=$chain '$6==x {if ($5==y) {print NR}}' aux.pdb | tail -1) #finding the last atom of the residue $chain and $rnum in the mono-substituted molecule

    # The use of ^ is to make a match at the begining of the string

    #ini1=$(grep -n "$chain  $rnum" aux.pdb | head -1 | cut -d ":" -f1) #finding the first atom of the residue $j in the mono-substituted molecule
    #fin2=$(grep -n "$chain  $rnum" aux.pdb | tail -1 | cut -d ":" -f1) #finding the last atom of the residue $j in the mono-substituted molecule
    #sleep 1000s
    awk 'NR == x,NR == y {if (NF==12) printf "  %s(%s%7d%-2s%3s %1s%4d)%13.8f +1%13.8f +1%13.8f +1\n",$12,$1,$2,substr($0,12,6),$4,$5,$6,$7,$8,$9}' x="$ini1" y="$fin2" aux.pdb >> aux_2.pdb # adding the coordinates of the mono-subtituted residue | Part 2
    #awk 'NR == x,NR == y {if (NF==12) printf "  %s(%s%7d%-2s%3s %1s%4d)%13.8f%13.8f%13.8f\n",$12,$1,$2,substr($0,12,6),$4,$5,$6,$7,$8,$9}' x="$ini1" y="$fin2" aux.pdb >> aux_2.pdb # adding the coordinates of the mono-subtituted residue | Part 2

    awk 'NR == x,NR == y {if (NF==12) printf "  %s%7d%-2s%4s %1s%5s%13.8f%3s%13.8f%3s%13.8f%3s\n",$1,$2,substr($0,16,5),$4,$5,$6,$7,$8,$9,$10,$11,$12}' x="$fin" y="$num" "$org" >> aux_2.pdb # adding in the last file the coordinates of the rest of atoms of the original molecule | Part 3
    #awk 'NR == x,NR == y {if (NF==12) printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,$2,substr($0,16,5),$4,$5,$6,$7,$9,$11}' x="$fin" y="$num" "$org" >> aux_2.pdb # adding in the last file the coordinates of the rest of atoms of the original molecule | Part 3

    #sleep 1000s
    mv aux_2.pdb aux_3.pdb
    org="aux_3.pdb"
    #sleep 1000s

    opt_l="\""${chain}"  "${rnum}"\""=2.0
    if [ $count -eq 1 ]
       then
	   opt_local=$opt_l
	   echo "1"
       else
           opt_local=$opt_local","$opt_l
	   echo "2"
    fi
    echo $opt_local
    echo $opt_l

done

printf " MOZYME EPS=78.4 GNORM=20 OPT(%s) HTML CUTOFF=6\n\n\n" "$opt_local" > "$tag"_"$name"_2A.mop # creating flags for the restricted optimization in a .mop file according to the mono-substituted residue
#printf " PM7 LET PL OPT(\"P %d\"=2.0) RAPID MOZYME NSPA=122 EPS=78.4 GNORM=20 GEO-OK THREADS=4 DEBUG PBDOUT AUX\n\n\n" "$j" > "$tag"_"$name"_2A.mop # creating flags for the restricted optimization in a .mop file according to the mono-substituted residue

awk 'BEGIN{i=1} NF=="12"{printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,5),$4,$5,$6,$7,$9,$11}' aux_3.pdb >> "$tag"_"$name"_2A.mop #rewriting in the same .mop file all edited coordinates of the aux.pdb
#awk 'BEGIN{i=1} NF=="9"{printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,5),$4,$5,$6,$7,$8,$9}' aux_3.pdb >> "$tag"_"$name"_2A.mop #rewriting in the same .mop file all edited coordinates of the aux.pdb

#rm aux.pdb
rm $listm

echo "fin"
