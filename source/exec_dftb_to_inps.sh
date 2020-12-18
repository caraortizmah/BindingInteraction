#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program converts a .arc file into a .pdb file

#rungms="/usr/local/bin/rungms" #Path of GAMESS program

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

 	      for input in `ls *.inp` # for all .inp files
        do

          cp ../../script_dftb_inp.sh . # copying DFTB script
          cp ../../dftb_input.info . # copying information about DFTB input keywords
          # output="$(echo "$input" | cut -d'.' -f1)"
          ./script_dftb_inp.sh "$input" # executing script to edits .inp file to calculate single points using FMO-DFTB3
          echo "$input converted to FMO-DFTB3 input for GAMESS"
          rm dftb_input.info
        done

        cd ../
      fi
    done

    cd ../
  fi
done

