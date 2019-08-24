#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program find optimization files to execute them propka3.1.

rungms="/usr/local/bin/rungms" #Path of rungms program
propka="/home/caom/propka-3.1/scripts/propka31.py" #Path of propka3.1 program

for i in `ls */` #Enter in each folders
do
  
  j="$(echo "$i" | cut -d':' -f1)" #cutting the ':' in the folders
  if [ -d "$j" ]; then #Checking if a directory exists
    echo "$j"
    cd "$j" #Enter in that folder
    
    for ii in `ls */` #Enter in each folders
    do
      jj="$(echo "$ii" | cut -d':' -f1)" #cutting the ':' in the folders
      if [[ "$ii" = *"opt_"* ]]; then #checking if the name has the word "opt" 
        echo "$jj"
        cd "$jj" #entering in the optimization folder
        
 	      for input in `ls *.pdb`
        do
	        $propka $input #executing propka program in all pdb files from $jj (optimization folder)
          $propka -d $input #executing another option of propka
          echo "execution of propka3.1 over $input"
        done
        cd ../
      fi
    done
    cd ../
  fi
done

