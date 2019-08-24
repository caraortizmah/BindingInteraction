#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program converts a .arc file into a .mop file using arguments in the name

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program
arg="$1" # .arc file
res="$2" # mutation
arg2="$3" #option

if !([ -z "$arg" ] && [ -z "$res" ]) && [ -z "$arg2"] # confirming the existence of the three arguments
then
  echo "It lacks one argument to execute the script"                       
  echo "For instance: ./script_arc_auxmop.sh file.arc A11 neutral" # an example about of the execution
  exit 1
else
  echo "Executing script_arc_auxmop.sh over "$arg "and mutation" $res " with " $arg2 " option" 
fi

#printf " PBD PM7 LET MOZYME GEO_REF=\"SELF\" GNORM=20 GEO-OK THREADS=4 DEBUG PBDOUT AUX\n\n\n" > input_Optall.mop

awk 'BEGIN{i=1} NF=="12"{if ($5=="A" || $5=="B" || $5=="P" || $5=="V") printf "  %6s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,$2,substr($0,16,6),$4,$5,$6,$7,$9,$11}' "$arg" >> Opt_"$res"_"$arg2".mop
# rewriting the arc file into a .mop file specifing the name of the file with the second and third argument given in the execution

echo "fin"
