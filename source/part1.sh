#!/bin/bash

arg="$1"
dir_pdb="$2"
name_pdb="$3"
work_dir="$4"
VMD="$5"
BABEL="$6"

if [ -z "$arg" ] || [ -z "$dir_pdb"  ] || [ -z "$name_pdb"  ] || [ -z "$work_dir"  ] || [ -z "$VMD"  ] || [ -z "$BABEL"  ] #execution of this program waits an additional argument
then
  echo "It lacks one or several arguments to execute this script: "
  echo "1. Optimization work path"
  echo "2. PDB path"
  echo "3. PDB name"
  echo "4. Work dir (in this case is the same 1st argument)"
  echo "5. VMD executable path"
  echo "6. OpenlBabel executable path"
  echo "Please read org_all.sh or go to https://github.com/caraortizmah/BindingInteraction for checking source code"
  exit 1
else
  echo "Executing Part 1 from Stage 1"
fi

name_f="$(echo "$name_pdb" | cut -d'.' -f1)"

cd $work_dir

mkdir -p $name_f
cp -p $dir_pdb/$name_pdb $name_f/
cd $name_f/

#mkdir -p BI_scripts
#cd BI_scripts/

# First part: Geometry starting point
#****
mkdir -p original
cp -p $name_pdb original/

#adding waters with Dowser * First step

mkdir -p dowser
cd dowser/
mkdir -p folder_1
cd ../
cp -p $arg/$name_pdb dowser/
cp -p $arg/source/dowser_loops_script.sh dowser/
cp -p $arg/source/dowser_beta.tcl dowser/folder_1/
cp -p $arg/source/dowser.tcl dowser/folder_1/
cp -p $arg/source/prepare_st1.tcl dowser/folder_1/
cp -p $arg/source/prepare_st2.tcl dowser/folder_1/
cd dowser/
./dowser_loops_script.sh $name_pdb ${VMD} ${BABEL}
cd ..

#Changing format * Second step

mkdir -p 2nd_step
cp -p $arg/source/script_dow_to_mopac.sh 2nd_step/
mv dowser/final_step.pdb 2nd_step/
cd 2nd_step/
./script_dow_to_mopac.sh final_step.pdb ${BABEL}
cd ..
