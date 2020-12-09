#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

FILE=paths.out
FILE2=pro_paths.out

if [ -f "$FILE" ]; then
	MHCBI_PATH=$(grep "1 " ${FILE} | cut -d':' -f2)
	PDB_PATH=$(grep "2 " ${FILE} | cut -d':' -f2)
	PDB_NAME=$(grep "3 " ${FILE} | cut -d':' -f2)
	WORK_PATH=$(grep "4 " ${FILE} | cut -d':' -f2)
	WORK_NAME=$(grep "5 " ${FILE} | cut -d':' -f2)
else
	echo "paths.out doesn't exist"
	echo "Configure the MHCBI pipeline executig setup.sh and select option 3)"
	exit 1
fi

if [ -f "$FILE2" ]; then
  MOPAC_PATH=$(grep "1 " ${FILE2} | cut -d':' -f2)
  PKA_PATH=$(grep "2 " ${FILE2} | cut -d':' -f2)
  VMD_PATH=$(grep "3 " ${FILE2} | cut -d':' -f2)
  GAMESS_PATH=$(grep "4 " ${FILE2} | cut -d':' -f2)
else
  echo "pro_paths.out doesn't exist"
  echo "Configure the MHCBI pipeline executig setup.sh and select option 3)"
  exit 1
fi


#echo "prueba de organizer.sh"
#echo ${MHCBI_PATH}
#echo ${PDB_PATH}
#echo ${PDB_NAME}
#echo ${WORK_PATH}
#echo ${WORK_NAME}

#Stage 1
cp ${PDB_NAME} optimizations/
cd optimizations
cp ../${FILE2} .
cp ../source/org_all.sh .
cp ../source/part1.sh .
cp ../source/part2.sh .
cp ../source/part3.sh .
mkdir -p source
cd source/
cp ../../source/addH.sh .
cp ../../source/arc_to_pdb.sh .
cp ../../source/checkst.sh .
cp ../../source/del_waters.sh .
cp ../../source/dowser_beta.tcl .
cp ../../source/dowser_loops_script.sh .
cp ../../source/dowser.tcl .
cp ../../source/prepare_st1.tcl .
cp ../../source/prepare_st2.tcl .
cp ../../source/script_addH_tooptH.sh .
cp ../../source/script_cleaning_dow.sh .
cp ../../source/script_clean_O.sh .
cp ../../source/script_dow_to_mopac.sh .
cp ../../source/script_optH_to_optall.sh .

#Stage 2
cd ../../mutations/
cp ../${FILE2} .
cp ../source/addH_m.sh .
cp ../source/listm.log .
cp ../source/mutmaker.sh .
cp ../source/org_mut.sh .
cp ../source/script_arc_to_pdb.sh .
cp ../source/script_chimera_swap.sh .
cp ../source/script_H_mut.sh .
cp ../source/script_joincoorspdb_to_mop.sh .
cp ../source/script_mut_to_mop.sh .
cp ../source/script_res_charges.sh .

#Stage 3
cd ../calculations/
cp ../${FILE2} .
cp ../source/exec_pka.sh .
cp ../source/exec_test.sh .
cp ../source/org_calc.sh .
cp ../source/script_arc_auxmop.sh .
cp ../source/script_arc_to_pdb.sh .
cp ../source/script_arc_to_pdb_s.sh .
cp ../source/script_build_spmop.sh .
cp ../source/script_check_ch.sh .
cp ../source/script_fishing_pka.sh .
cp ../source/script_H_charges.sh .
cp ../source/script_let.sh .
cp ../source/script_other_sp.sh .


echo "****** MHCBI says: ******"
echo "  All folders and scripts were organized"
