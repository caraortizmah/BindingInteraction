#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program executes mopac16 in original geometry

mopac16="/opt/mopac/MOPAC2016.exe" #Path of MOPAC program


# creating folders for the original geometry
mkdir 1BX2_org
cd 1BX2_org/
mkdir opt_org_1BX2
cp ../1BX2_coord_complete.arc opt_org_1BX2/1BX2_org.mop
mkdir comp_pep_org
cp opt_org_1BX2/1BX2_org.mop comp_pep_org/comp_pep_org.mop
mkdir pep_org
cp opt_org_1BX2/1BX2_org.mop pep_org/pep_org.mop

cp ../script_ed_inp.sh .

./script_ed_inp.sh org #editing original input 

echo "fin"

cd opt_org_1BX2/ #for complex

for i in `ls *.mop`
do
  $mopac16 "$i" # executing mopac16
done
cd ..

cd comp_pep_org/ #for receptor

for i in `ls *.mop`
do
  $mopac16 "$i"
done
cd ..

cd pep_org/ #for ligand

for i in `ls *.mop`
do
  $mopac16 "$i"
done
cd ..

echo "calculations for original set have finished"

