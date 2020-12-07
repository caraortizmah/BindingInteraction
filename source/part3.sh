#!/bin/bash

arg="$1"
##dir_pdb="$2"
name_pdb="$2"
work_dir="$3"

name_f="$(echo "$name_pdb" | cut -d'.' -f1)"

cd $work_dir

cd $name_f/

#Optimizing all molecule restrictely * Fifth step

mkdir -p 5th_step
cp -p $arg/source/script_optH_to_optall.sh 5th_step/
cp -p 4th_step/input_OptH.arc 5th_step/
cd 5th_step/
./script_optH_to_optall.sh input_OptH.arc
cd ..

#Optimizing all molecule restrictely * sixth step

mkdir -p 6th_step
cp -p $arg/source/arc_to_pdb.sh 6th_step/
cp -p $arg/source/del_waters.sh 6th_step/
cp -p 5th_step/input_Optall.arc 6th_step/org_coord.arc
cd 6th_step/
./arc_to_pdb.sh org_coord.arc
./del_waters.sh org_coord.pdb org_coord.arc $name_f
cd ../../

mkdir -p output
cp ${name_f}/6th_step/${name_f}_noW.arc output/
cp ${name_f}/6th_step/${name_f}_noW.pdb output/
