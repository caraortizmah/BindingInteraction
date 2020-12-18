#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

FILE=paths.out
FILE2=pro_paths.out

#First level

if [ -f "$FILE" ]; then
	MHCBI_PATH=$(grep "1 " ${FILE} | cut -d':' -f2)
	PDB_PATH=$(grep "2 " ${FILE} | cut -d':' -f2)
	PDB_NAME=$(grep "3 " ${FILE} | cut -d':' -f2)
	WORK_PATH=$(grep "4 " ${FILE} | cut -d':' -f2)
	WORK_NAME=$(grep "5 " ${FILE} | cut -d':' -f2)
  echo -e "Running paths source found...           \e[1;32m passed \e[0m"
else
	echo "paths.out doesn't exist"
	echo -e "Running paths source found...           \e[1;31m failded \e[0m"
	exit 1
fi

if [ -f "$FILE2" ]; then
  MOPAC_PATH=$(grep "1 " ${FILE2} | cut -d':' -f2)
  PKA_PATH=$(grep "2 " ${FILE2} | cut -d':' -f2)
  VMD_PATH=$(grep "3 " ${FILE2} | cut -d':' -f2)
  GAMESS_PATH=$(grep "4 " ${FILE2} | cut -d':' -f2)
  BABEL_PATH=$(grep "5 " ${FILE2} | cut -d':' -f2)
  CHIMERA_PATH=$(grep "6 " ${FILE2} | cut -d':' -f2)
  echo -e "External program paths source found...           \e[1;32m passed \e[0m"
else
  echo "pro_paths.out doesn't exist"
  echo -e "External program paths source found...           \e[1;31m failded \e[0m"
  exit 1
fi

echo "1st Stage directory folder"
if [ -d "optimizations" ]; then
  echo -e "Optimizations folder created...           \e[1;32m passed \e[0m"
else
  echo -e "Optimizations folder created...           \e[1;31m failed \e[0m"
fi

echo "2nd Stage directory folder"
if [ -d "mutations" ]; then
  echo -e "Mutations folder created...           \e[1;32m passed \e[0m"
else
  echo -e "Mutations folder created...           \e[1;31m failed \e[0m"
fi

echo "3rd Stage directory folder"
if [ -d "calculations" ]; then
  echo -e "Calculations folder created...           \e[1;32m passed \e[0m"
else
  echo -e "Calculations folder created...           \e[1;31m failed \e[0m"
fi

#Second level

current_dir="$(echo "${WORK_PATH}/${WORK_NAME}")"

if [ "${current_dir}" = "$PWD" ]; then
  echo "Directory: "${current_dir}
  echo -e "Stage 1: work directory found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: work directory found...           \e[1;31m failed \e[0m"
fi

cd optimizations

var="$(echo "${PDB_NAME}" | cut -d'.' -f1)"

if [ -d ${var} ]; then
  echo -e "Stage 1: work folder found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: work folder found...           \e[1;31m failed \e[0m"
fi

cd ${var}

if [ -d "original" ]; then
  echo -e "Stage 1: Initial PDB structure found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Initial PDB structure found...           \e[1;31m failed \e[0m"
fi

if [ -d "dowser" ]; then
  echo -e "Stage 1: Dowser work folder found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Dowser work folder found...           \e[1;31m failed \e[0m"
fi

if [ -d "2nd_step" ]; then
  echo -e "Stage 1: 2nd step found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: 2nd step found...           \e[1;31m failed \e[0m"
fi

cd 2nd_step

if [ -e "final_step.pdb" ]; then
  echo -e "Stage 1: Dowser procedure completed...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Dowser procedure completed...           \e[1;31m failed \e[0m"
fi

if [ -e "pdbformopac_final_step.pdb" ]; then
  echo -e "Stage 1: 2nd step completed...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: 2nd step completed...           \e[1;31m failed \e[0m"
fi

cd ..

if [ -d "3rd_step" ]; then
  echo -e "Stage 1: 3rd step found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: 3rd step found...           \e[1;31m failed \e[0m"
fi

cd 3rd_step

if [ -e "molpdbw.pdb" ]; then
  echo -e "Stage 1: Dowser output as input found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Dowser output as input found...           \e[1;31m failed \e[0m"
fi

if [ -e "molpdbw_H.mop" ]; then
  echo -e "Stage 1: Mopac input for adding hydrogens found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Mopac input for adding hydrogens found...           \e[1;31m failed \e[0m"
fi

if [ -e "molpdbw_H.arc" ]; then
  echo -e "Stage 1: Mopac input completed...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Mopac input completed...           \e[1;31m failed \e[0m"
fi

cd ..

if [ -d "4th_step" ]; then
  echo -e "Stage 1: 4th step found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: 4th step found...           \e[1;31m failed \e[0m"
fi

cd 4th_step

if [ -e "input_OptH.mop" ]; then
  echo -e "Stage 1: Mopac input for optimizing hydrogens found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Mopac input for optimizing hydrogens found...           \e[1;31m failed \e[0m"
fi

if [ -e "input_OptH.arc" ]; then
  echo -e "Stage 1: Mopac output hydrogen optimization completed...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Mopac output hydrogen optimization completed...           \e[1;31m failed \e[0m"
fi

cd ..

if [ -d "5th_step" ]; then
  echo -e "Stage 1: 5th step found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: 5th step found...           \e[1;31m failed \e[0m"
fi

cd 5th_step

if [ -e "input_Optall.mop" ]; then
  echo -e "Stage 1: Mopac input for all-atom optimizing found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Mopac input for all-atom optimizing found...           \e[1;31m failed \e[0m"
fi

if [ -e "input_Optall.arc" ]; then
  echo -e "Stage 1: Mopac output all-atom optimization completed...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Mopac output all-atom optimization completed...           \e[1;31m failed \e[0m"
fi

cd ..

if [ -d "6th_step" ]; then
  echo -e "Stage 1: 6th step found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: 6th step found...           \e[1;31m failed \e[0m"
fi

cd 6th_step

if [ -e "org_coord.pdb" ]; then
  echo -e "Stage 1: Final PDB structure with no water molecules found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Final PDB structure with no water molecules found...           \e[1;31m failed \e[0m"
fi

if [ -e "org_coord.arc" ]; then
  echo -e "Stage 1: MOPAC no-water output found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: MOPAC no-water output found...           \e[1;31m failed \e[0m"
fi

cd ../../

if [ -d "output" ]; then
  echo -e "Stage 1: Overall output stage 1 found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 1: Overall output stage 1 found...           \e[1;31m failed \e[0m"
fi

cd ../mutations

if [ -e "listm.log" ]; then
  echo -e "Stage 2: to-be-substituted residue list found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 2: to-be-substituted residue list found...           \e[1;31m failed \e[0m"
fi

if [ -e "res_charges.pdb" ]; then
  echo -e "Stage 2: Residues charged found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 2: Residues charged found...           \e[1;31m failed \e[0m"
fi

if [ -e "chimera_mut_${var}.py" ]; then
  echo -e "Stage 2: Chimera python script found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 2: Chimera python script found...           \e[1;31m failed \e[0m"
fi

if [ -d "tobe_charged" ]; then
  echo -e "Stage 2: Overall output found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 2: Overall output found...           \e[1;31m failed \e[0m"
fi

cd tobe_charged

let num=$(ls *.pdb | wc -l)

if [ ${num} = "1" ]; then
  echo -e "Stage 2: Substituted PDB structures found...           \e[1;33m incomplete \e[0m"
elif [ ${num} = "0" ]; then
  echo -e "Stage 2: Substituted PDB structures found...           \e[1;31m failed \e[0m"
else
  echo -e "Stage 2: Substituted PDB structures found...           \e[1;32m passed \e[0m"
fi
echo "Check yourself that substitutions amount (listm.log) matches with PDB structures number (inside tobe_charged folder)"

let num=$(ls *.arc | wc -l)

if [ ${num} = "1" ]; then
  echo -e "Stage 2: Substituted MOPAC ouputs found...           \e[1;33m incomplete \e[0m"
elif [ ${num} = "0" ]; then
  echo -e "Stage 2: Substituted MOPAC ouputs found...           \e[1;31m failed \e[0m"
else
  echo -e "Stage 2: Substituted MOPAC ouputs found...           \e[1;32m passed \e[0m"
fi
echo "Check yourself that substitutions amount (listm.log) matches with MOPAC outputs number (inside tobe_charged folder)"

cd ../../calculations

if [ -d "tobe_charged" ]; then
  echo -e "Stage 3: Overall input found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 3: Overall input found...           \e[1;31m failed \e[0m"
fi

cd tobe_charged

let num=$(ls *.arc | wc -l)

if [ ${num} = "1" ]; then
  echo -e "Stage 3: Substituted MOPAC ouputs found...           \e[1;33m incomplete \e[0m"
elif [ ${num} = "0" ]; then
  echo -e "Stage 3: Substituted MOPAC ouputs found...           \e[1;31m failed \e[0m"
else
  echo -e "Stage 3: Substituted MOPAC ouputs found...           \e[1;32m passed \e[0m"
fi
echo "Check yourself that substitutions amount (listm.log) matches with MOPAC outputs number (inside tobe_charged folder)"

cd ..

if [ -d "final_pdbs" ]; then
  echo -e "Stage 3: Overall output found...           \e[1;32m passed \e[0m"
else
  echo -e "Stage 3: Overall output found...           \e[1;31m failed \e[0m"
fi

cd final_pdbs

let num2=$(ls *.pdb | wc -l)

if [ ${num} = ${num2} ]; then
  echo -e "Stage 3: Overal substituted and charged PDB structures found...           \e[1;32m passed \e[0m"
elif [ ${num2} = "0" ]; then
  echo -e "Stage 3: Overal substituted and charged PDB structures found...           \e[1;31m failed \e[0m"
else
  echo -e "Stage 3: Overal substituted and charged PDB structures found...           \e[1;33m incomplete \e[0m"
fi
echo "Check yourself that substitutions an charged PDB structures match with the initial ones in tobe_charged folder"

let num_c=$(ls C_*.pdb | wc -l)
let num_r=$(ls R_*.pdb | wc -l)
let num_l=$(ls L_*.pdb | wc -l)

echo "Number of molecules found as complexes... "$num_c
echo "Number of molecules found as receptors... "$num_r
echo "Number of molecules found as ligands... "$num_l

echo "Check yourself that complexes, receptors and ligands from the all set (see listm.log) are in final_pdbs folder"

cd ../../

echo "****** MHCBI says: ******"
echo "  Explicitly scanning"
echo " "

grep "NORMALLY" */*/*.out
grep "NORMALLY" */*/*/*.out

let subtotal1=$(grep "NORMALLY" */*/*.out | wc -l)
let subtotal2=$(grep "NORMALLY" */*/*/*.out | wc -l)

let total=$(($subtotal1+$subtotal2))
echo -e "Total results passed ... \e[1;32m $total \e[0m"

grep "ABNORMALLY" */*/*.out
grep "ABNORMALLY" */*/*/*.out

let subtotal1=$(grep "ABNORMALLY" */*/*.out | wc -l)
let subtotal2=$(grep "ABNORMALLY" */*/*/*.out | wc -l)

let total=$(($subtotal1+$subtotal2))
echo -e "Total results failed ... \e[1;31m $total \e[0m"

echo ""
echo "Resume finished"
