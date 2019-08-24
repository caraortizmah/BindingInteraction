#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program converts a .arc file into a .pdb file

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program

#awk 'NF=="12"{printf "ATOM%7d %-4s %3s %1s%4d%12.3f%8.3f%8.3f  1.00  0.00%12s\n",$2,$3,$4,$5,$6,$7,$9,$11,substr($1,1,1)}' input_OptH.arc >> pdb_OptH.pdb

for i in `ls *.arc`
do

  j="$(echo "$i" | cut -d'.' -f1)" 
  awk 'NF=="12"{printf "ATOM%7d%-2s%3s %1s%4d%12.3f%8.3f%8.3f  1.00  0.00%12s\n",$2,substr($0,16,6),$4,$5,$6,$7,$9,$11,substr($1,1,1)}' "$i" >> "$j".pdb

  echo "fin"
done
