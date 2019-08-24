#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program organizes files to execute them propka3.1.

rungms="/usr/local/bin/rungms" #Path of rungms program

for i in `ls */` #Enter in each folders
do
  
  j="$(echo "$i" | cut -d':' -f1)" #cutting the ':' in the folders
  if [ -d "$j" ]; then #Checking if a directory exists
    echo "$j"
    cd "$j" #Enter in that folder
    
    for ii in `ls */` #Enter in each folders
    do
      jj="$(echo "$ii" | cut -d':' -f1)" #cutting the ':' in the folders
      if [ -d "$jj" ]; then  # -d checks whether $jj directory exist or not 
        echo "$jj"
        cd "$jj" #entering in that folder
        
 	      for input in `ls *.arc`
        do
	        cp ../../script_arc_to_pdb.sh . #copy from other path an executable for .arc files
          # output="$(echo "$input" | cut -d'.' -f1)"
	        ./script_arc_to_pdb.sh #executing script to convert .arc file into .pdb file
          echo "$input converted to pdb format"
        done
        cd ../
      fi
    done
    cd ../
  fi
done

