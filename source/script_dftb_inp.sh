#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program edits a .inp file to calculate a single point using FMO-DFTB3 in GAMESS


arg="$1"

if [ -z "$arg" ]
then
  echo "It lacks one or two pdb file to execute the script"
  echo "For instance: ./script_dftb_inp.sh input_dftb.inp"
  exit 1
else
  echo "Executing script_dftb_inp.sh over "$arg
fi

awk 'NR <= 48 {printf "%s\n",$0}' dftb_input.info >> aux_dftb_inp # creating a new .inp file using keywords of dftb_input.info

let ini=$(grep -n "NLAYER=1" "$arg" | cut -d ":" -f1) # extracts the number of that position in the original .inp file
let ini1=$ini+1

let fin=$(grep -n "3-21G" "$arg" | head -1 | cut -d ":" -f1) # extracts the number of that position in the original .inp file
let fin1=$fin-1

# information between the line ini1 and the line fin1 has:
# 1. Number of fragments (NFRAG=)
# 2. Charge of fragments (ICHARG(1))
# 3. Name of fragments (FRGNAM(1))
# 4. Number of atoms that belong to each fragment (INDAT(1))

awk 'NR == x,NR == y {printf "%s\n",$0}' x="$ini1" y="$fin1" "$arg" >> aux_dftb_inp # rewriting lines from ini1 to fin1 in the new .inp file

awk 'NR == 50,NR == 54 {printf "%s\n",$0}' dftb_input.info >> aux_dftb_inp # rewriting lines of the hydrid orbital projection in $FMOHYB ... $END 

let ini=$(grep -n "3-21G      MINI" "$arg" | head -1 | cut -d ":" -f1) # first line of the $FMOBND section
let ini1=$ini-2

let fin=$(grep -n "3-21G      MINI" "$arg" | tail -1 | cut -d ":" -f1) # last line of the $FMOBND section

awk 'NR == x,NR == y {printf "%s\n",$0}' x="$ini1" y="$fin" "$arg" >> aux_dftb_inp # rewriting bond detachment description $FMOBND ... $END

let ini=$(grep -n "FMO calculation :" "$arg" | head -1 | cut -d ":" -f1) # first line for $DATA head
let ini1=$ini-2
let fin=$(grep -n "C1" "$arg" | tail -1 | cut -d ":" -f1) # last line for $DATA head (symbol of molecular symmetry)

awk 'NR == x,NR == y {printf "%s\n",$0}' x="$ini1" y="$fin" "$arg" >> aux_dftb_inp # rewriting $DATA head description

awk 'NR == 56,NR == 60 {printf "%s\n",$0}' dftb_input.info >> aux_dftb_inp # adding information for basis in parametrization for C, O, H, N and S

let ini=$(grep -n "END" "$arg" | tail -2 | cut -d ":" -f1 | head -1) #line of the $END of $DATA

#let fin=$(wc -l "$arg" | cut -d " " -f1)
#awk 'NR == x,NR == y {printf "%s\n",$0}' x="$ini" y="$fin" "$arg" >> aux_dftb_inp
awk 'NR >= x {printf "%s\n",$0}' x="$ini" "$arg" >> aux_dftb_inp # adding from $END of $DATA to all information in $FMOXYZ (geometry)

sed -i 's/3-21G      MINI/HOP_C/g' aux_dftb_inp # replacing 3-21G information of the detachment for hybrid orbital projection

name="$(echo "$arg" | cut -d'.' -f1)" # creating the name of the new .inp file according to the original .inp file

cp "$arg" "$name"-old # changing the name of the original .inp file

mv aux_dftb_inp "$arg" # changing the name of the new .inp file

