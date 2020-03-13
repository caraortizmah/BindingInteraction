#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program deletes water coordinates from an pdb file returning it in the same format.

for i in `ls *.pdb` #for each pdb files, program execute the lines below
do

  j="$(echo "$i" | cut -d'.' -f1)" #Remove the extension (".pdb") of the file
  awk '$4!="HOH"{print $0}' "$i" >> "$j"_noW.pdb
  
  echo "fin"
done
