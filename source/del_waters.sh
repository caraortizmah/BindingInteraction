#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program deletes water coordinates from an pdb file returning it in the same format.

arg="$1"
org="$2"
name="$3"

if [ -z "$arg" ] || [ -z "$org" ] || [ -z "$name" ] #execution of this program waits an additional argument
then
  echo "It lacks one or several arguments to execute the script"
  echo "For instance: ./del_waters.sh output.pdb output.arc main_name"
  exit 1
else
  echo "Executing del_waters.sh over "$arg ", " $org " and " $name #This argument is an output pdb file from dowser execution
fi

#j="$(echo "$arg" | cut -d'.' -f1)" #Remove the extension (".pdb") of the file
awk '$4!="HOH"{print $0}' "$arg" >> "$name"_noW.pdb

#k="$(echo "$org" | cut -d'.' -f1)" #Remove the extension (".arc") of the file
awk '$4!="HOH"{print $0}' "$org" >> "$name"_noW.arc

echo "fin"
