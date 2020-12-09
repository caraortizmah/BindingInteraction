#!/bin/bash

arg="$1"
name_pdb="$2"
work_dir="$3"
MOPAC="$4"

if [ -z "$arg" ] || [ -z "$name_pdb" ] || [ -z "$work_dir" ] || [ -z "$MOPAC" ] #execution of this program waits an additional argument
then
  echo "It lacks one or several arguments to execute this script: "
  echo "1. Optimization work path"
  echo "2. PDB name"
  echo "3. Work dir (in this case is the same 1st argument)"
  echo "4. MOPAC executable path"
  echo "Please read org_all.sh or go to https://github.com/caraortizmah/BindingInteraction for checking source code"
  exit 1
else
  echo "Executing Part 2 from Stage 1"
fi

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
./addH.sh molpdbw.pdb ${MOPAC}
cd ..

#Optimizing only Hydrogens * Fourth step

mkdir -p 4th_step
cp -p $arg/source/script_addH_tooptH.sh 4th_step/
cp -p 3rd_step/molpdbw_H.arc 4th_step/
cd 4th_step/
./script_addH_tooptH.sh molpdbw_H.arc ${MOPAC}
cd ..
