#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program edits input in mopac of complex, receptor and ligand.

arg="$1"

if [ -z "$arg" ]
then
  echo "It lacks one argument to execute the script"                                                  
  echo "For instance: ./script_editing_inputs.sh A11"
  exit 1
else
  echo "Executing script_editing_inputs.sh over "$arg
fi

cd opt_"$arg"_1BX2/

printf " PM7 LET 1SCF MOZYME NSPA=122 EPS=78.4 GNORM=20 GEO-OK THREADS=4 DEBUG PBDOUT AUX\n\n\n" > aux_sp.mop
awk 'BEGIN {i=1} NF==12 {printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,5),$4,$5,$6,$7,$9,$11}' 1BX2_"$arg".mop >> aux_sp.mop #editing input for single point for Complex
mv aux_sp.mop 1BX2_"$arg"_ABPV.mop
rm 1BX2_"$arg".mop

cd ..

cd comp_pep_"$arg"/

printf " PM7 LET 1SCF MOZYME NSPA=122 EPS=78.4 GNORM=20 GEO-OK THREADS=4 DEBUG PBDOUT AUX\n\n\n" > aux_sp.mop
awk 'BEGIN {i=1} NF==12 {if ($5!="P") printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,5),$4,$5,$6,$7,$9,$11}' comp_pep_"$arg".mop >> aux_sp.mop
mv aux_sp.mop 1BX2_"$arg"_ABV.mop #editing input for single point for Receptor
rm comp_pep_"$arg".mop

cd ..

cd pep_"$arg"/

printf " PM7 LET 1SCF MOZYME NSPA=122 EPS=78.4 GNORM=20 GEO-OK THREADS=4 DEBUG PBDOUT AUX\n\n\n" > aux_sp.mop
awk 'BEGIN {i=1} NF==12 {if ($5!="A" && $5!="B" && $5!="V") printf "  %s%7d%-2s%4s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,5),$4,$5,$6,$7,$9,$11}' pep_"$arg".mop >> aux_sp.mop
mv aux_sp.mop 1BX2_"$arg"_P.mop #editing input for single point for Ligand
rm pep_"$arg".mop

cd ..

echo "fin"
