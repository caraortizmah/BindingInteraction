#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program converts a .arc file into a .pdb file

rungms="/usr/local/bin/rungms" #Path of GAMESS program

for i in `ls */` # for all folders
do
  
  j="$(echo "$i" | cut -d':' -f1)"
  if [ -d "$j" ]; then # if $i is a folder...
    echo "$j"
    cd "$j"
    
    for ii in `ls */` # for all folders
    do
      jj="$(echo "$ii" | cut -d':' -f1)"
      if [ -d "$jj" ]; then # if $i is a folder...
        echo "$jj"
        cd "$jj"
        
 	for input in `ls *.arc` # for all .arc files
        do
	  cp ../../script_arc_to_pdb.sh .
         # output="$(echo "$input" | cut -d'.' -f1)"
	  ./script_arc_to_pdb.sh
          echo "$input converted to pdb format"
        done
        cd ../
      fi
    done
    cd ../
  fi
done

