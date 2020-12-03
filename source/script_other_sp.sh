#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program uses $arg to get the receptor and peptide input file

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program
arg="$1"

if [ -z "$arg" ]
then
  echo "It lacks one argument to execute the script"                                                  
  echo "For instance: ./script_other_sp.sh file"
  exit 1
else
  echo "Executing script_other_sp.sh over "$arg " to get comp-pep and peptide"
fi

# editing receptor input file
printf " PM6-D3H4X LET 1SCF MOZYME EPS=78.4 GNORM=20 PDBOUT CUTOFF=6 HTML\n\n\n" > comp-pep_final2.mop

awk 'BEGIN{i=1} ( NF=="9" ) && ( $5=="A" || $5=="B" ) {if (substr($0,1,2)=="  ")  {printf "  %s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,6),$4,$5,$6,$7,$8,$9} else { printf "  %s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,14,6),$4,$5,$6,$7,$8,$9}}' "$arg" >> comp-pep_final2.mop

# editing peptide input file
printf " PM6-D3H4X LET 1SCF MOZYME EPS=78.4 GNORM=20 PDBOUT CUTOFF=6 HTML\n\n\n" > pep_final2.mop

awk 'BEGIN{i=1} ( NF=="9" ) && ( $5=="P" ) {if (substr($0,1,2)=="  ")  {printf "  %s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,6),$4,$5,$6,$7,$8,$9} else { printf "  %s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,14,6),$4,$5,$6,$7,$8,$9}}' "$arg" >> pep_final2.mop

echo "fin"
