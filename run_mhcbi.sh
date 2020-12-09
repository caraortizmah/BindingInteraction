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
  echo "path.out doesn't exist"
  echo "Configure the MHCBI pipeline executig setup.sh and select option 3)"
  exit 1
fi

if [ -f "$FILE2" ]; then
  MOPAC_PATH=$(grep "1 " ${FILE2} | cut -d':' -f2)
  PKA_PATH=$(grep "2 " ${FILE2} | cut -d':' -f2)
  VMD_PATH=$(grep "3 " ${FILE2} | cut -d':' -f2)
  GAMESS_PATH=$(grep "4 " ${FILE2} | cut -d':' -f2)
else
  echo "pro_path.out doesn't exist"
  echo "Configure the MHCBI pipeline executig setup.sh and select option 3)"
  exit 1
fi

cd optimizations

arg1=$(echo "${WORK_PATH}/${WORK_NAME}/optimizations")

./org_all.sh ${arg1} ${PDB_PATH} ${PDB_NAME} ${arg1}

cp output/*.arc ${WORK_PATH}/${WORK_NAME}/mutations/
cp output/*.pdb ${WORK_PATH}/${WORK_NAME}/mutations/


echo "****** MHCBI says: ******"
echo "  Stage 1 finished..."

cd ../mutations

arg2=$(echo "${WORK_PATH}/${WORK_NAME}/mutations")
name=$(awk -F '.pdb'  '{print $1}'  <<<  "${PDB_NAME}")

./org_mut.sh ${arg2} ${name}_noW listm.log

cp -r tobe_charged ../calculations/

echo "****** MHCBI says: ******"
echo "  Stage 2 finished..."

cd ../calculations

./org_calc.sh

echo "****** MHCBI says: ******"
echo "  Stage 3 finished..."

