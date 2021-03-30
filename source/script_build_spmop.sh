#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#@comment:
#This program converts a .arc file into a .mop file

arg="$1"

if [ -z "$arg" ]  # confirming the existence of the argument
then
  echo "It lacks one argument to execute the script"
  echo "For instance: ./script_build_spmop.sh file"
  exit 1
else
  echo "Executing script_editing_inputs.sh over "$arg " to get " $arg".mop version"
fi

printf " PM6-D3H4X LET 1SCF MOZYME EPS=78.4 GNORM=20 PDBOUT CUTOFF=6 HTML\n\n\n" > "$arg".mop

#awk 'BEGIN{i=1} NF=="9"{if ($5=="A" || $5=="B" || $5=="P" || $5=="V") printf "  %s%7d%-2s%5s %1s%5s%13.8f%13.8f%13.8f\n",$1,$2,substr($0,16,6),$4,$5,$6,$7,$8,$9}' "$arg" >> "$arg".mop
#awk 'BEGIN{i=1} NF=="9" || $5=="A" || $5=="B" || $5=="P" || $5=="V" {if (substr($0,1,2)=="  ")  {printf "  %s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,$2,substr($0,16,6),$4,$5,$6,$7,$8,$9} else{ printf "  %s\n",$0 }}' "$arg" >> "$arg".mop

# putting format into the .mop file
awk 'BEGIN{i=1} ( NF=="9" ) && ( $5=="A" || $5=="B" || $5=="P" ) {if (substr($0,1,2)=="  ")  {printf "  %s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,16,6),$4,$5,$6,$7,$8,$9} else { printf "  %s%7d%-2s%3s %1s%5s%13.8f%13.8f%13.8f\n",$1,i++,substr($0,14,6),$4,$5,$6,$7,$8,$9}}' "$arg" >> "$arg".mop

#echo "fin"
