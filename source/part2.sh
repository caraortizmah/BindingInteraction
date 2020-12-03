#!/bin/bash

arg="$1"
##dir_pdb="$2"
name_pdb="$2"
work_dir="$3"

name_f="$(echo "$name_pdb" | cut -d'.' -f1)"

cd $work_dir

cd $name_f/

#Adding Hydrogens * Third step

mkdir -p 3rd_step
cp -p $arg/source/addH.sh 3rd_step/
#cp -p $arg/source/checkst.sh 3rd_step/
#cp -p $arg/source/script_clean_O.sh 3rd_step/

cp -p 2nd_step/pdbformopac_*.pdb 3rd_step/molpdbw.pdb
#cp -p 2nd_step/molpdbw_H.pdb 3rd_step/molpdbw.pdb
cd 3rd_step/
./addH.sh molpdbw.pdb
cd ..

#Optimizing only Hydrogens * Fourth step

mkdir -p 4th_step
cp -p $arg/source/script_addH_tooptH.sh 4th_step/
cp -p 3rd_step/molpdbw_H.arc 4th_step/
cd 4th_step/
./script_addH_tooptH.sh molpdbw_H.arc
cd ..
