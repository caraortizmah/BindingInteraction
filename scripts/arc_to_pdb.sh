#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program changes a mopac output into a new input file with other specific instructions

mopac16="/opt/mopac/MOPAC2016.exe" #Path of mopac program

for i in `ls *.arc` #for each arc files, program execute the lines below
do

  j="$(echo "$i" | cut -d'.' -f1)" #Remove the extension (".arc") of the file
  awk 'NF=="12"{printf "ATOM%7d%-2s%3s %1s%4d%12.3f%8.3f%8.3f  1.00  0.00%12s\n",$2,substr($0,16,6),$4,$5,$6,$7,$9,$11,substr($1,1,1)}' "$i" >> "$j".pdb #Set pdb format to output .arc file

  echo "fin"
done
