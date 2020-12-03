#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program executes propka3.1 in all pdb from "tobe_charged" folder.

propka="/home/caom/bin/propka31"

cd tobe_charged/
mv res_charges.pdb res_charges.aux-pdb

for i in `ls *.pdb`
#for i in `ls 1kpv4_A12_2A.pdb` optional for specific pdb file
do
   j="$(echo "$i" | cut -d'.' -f1)"
   mkdir -p $j
   mv $i $j/
   cd $j
   $propka $i
   $propka -d $i
   echo "execution of propka3.1 over $i"
   cd ..
done
cd ..
