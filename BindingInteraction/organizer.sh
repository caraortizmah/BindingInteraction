#!/bin/bash

arg="$1"
dir_pdb="$2"
name_pdb="$3"

cd $arg/../
mkdir -p BI_scripts
cd BI_scripts/

# First part: Geometry starting point
#****
mkdir -p original
cp $dir_pdb/$name_pdb original/

#adding waters with Dowser * First step

mkdir -p dowser
cd dowser/
mkdir -p folder_1
cd ../
cp $arg/source/dowser_loops_script.sh dowser/
cp $arg/source/dowser_beta.tcl dowser/folder_1/
cp $arg/source/dowser.tcl dowser/folder_1/
cp $arg/source/prepare_st.tcl dowser/folder_1/
cd dowser/
./dowser_loops_script.sh $name_pdb
cd ..

#Changing format * Second step

mkdir -p 2nd_step
cp $arg/source/script_dow_to_mopac.sh 2nd_step/
mv dowser/final_step.pdb 2nd_step/
cd 2nd_step/
./script_dow_to_mopac.sh final_step.pdb
cd ..

#Adding Hydrogens * Third step

mkdir -p 3rd_step
cp $arg/source/addH.sh 3rd_step/
cp 2nd_step/pdbformopac_*.pdb 3rd_step/molpdbw.pdb
cd 3rd_step/
./addH.sh molpdbw.pdb
cd ..

#Optimizing only Hydrogens * Fourth step

mkdir -p 4th_step
cp $arg/source/script_addH_tooptH.sh 4th_step/
cp 3rd_step/molpdbw.arc 4th_step/
cd 4th_step/
./script_addH_tooptH.sh molpdbw.arc
cd ..

#Optimizing all molecule restrictely * Fifth step

mkdir -p 5th_step
cp $arg/source/script_optH_to_optall.sh 5th_step/
cp 4th_step/input_OptH.arc 5th_step/
cd 5th_step/
./script_optH_to_optall.sh input_OptH.arc
cd ..

#Optimizing all molecule restrictely * sixth step

mkdir -p 6th_step
cp $arg/source/arc_to_pdb.sh 6th_step/
cp $arg/source/del_waters.sh 6th_step/
cp 5th_step/input_Optall.arc 6th_step/org_coord.arc
cd 6th_step/
./arc_to_pdb.sh org_coord.arc
./del_waters.sh org_coord.pdb
cd ..
#****

# Second part: Single points
#****
mkdir -p charges
cp $arg/source/exec_pka.sh charges/
cp $arg/source/exec_test.sh charges/
cp $arg/source/script_arc_auxmop.sh charges/
cp $arg/source/script_arc_to_pdb.sh charges/
cp $arg/source/script_arc_to_pdb_s.sh charges/
cp $arg/source/script_build_spmop.sh charges/
cp $arg/source/script_H_charges.sh charges/
cp $arg/source/script_H_charges_aux.sh charges/
cp $arg/source/script_other_sp.sh charges/



mkdir -p FMO_set
cp $arg/source/exec_dftb_to_inps.sh FMO_set/
cp $arg/source/exec_test_fmo.sh FMO_set/
cp $arg/source/script_arc_to_pdb.sh FMO_set/
cp $arg/source/script_dftb_inp.sh FMO_set/
cp $arg/source/dftb_input.info FMO_set/

mkdir -p mutation_step
cp $arg/source/mut_arc_to_pdb.sh mutation_step/
cp $arg/source/script_addH.sh mutation_step/
cp $arg/source/script_chimera_swap.sh mutation_step/
cp $arg/source/script_ed_inp.sh mutation_step/
cp $arg/source/script_editing_inputs.sh mutation_step/
cp $arg/source/script_H_mut.sh mutation_step/
cp $arg/source/script_joincoorspdb_to_mop.sh mutation_step/
cp $arg/source/SCRIPT_MOPAC_DR1.py mutation_step/
cp $arg/source/script_mut_to_mop.sh mutation_step/
cp $arg/source/script_single_points.sh mutation_step/
cp $arg/source/script_sps_opt.sh mutation_step/
mkdir -p water_step
cp $arg/source/script_chimera_waters.sh water_step/
cp $arg/source/script_editingwaters.sh water_step/
cp $arg/source/select_waters.py water_step/
