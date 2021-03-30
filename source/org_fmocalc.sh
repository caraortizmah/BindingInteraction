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
	echo "Configure the MHCBI pipeline executing setup.sh and select the option 3)"
	exit 1
fi

if [ -f "$FILE2" ]; then
  MOPAC_PATH=$(grep "1 " ${FILE2} | cut -d':' -f2)
  PKA_PATH=$(grep "2 " ${FILE2} | cut -d':' -f2)
  VMD_PATH=$(grep "3 " ${FILE2} | cut -d':' -f2)
  GAMESS_PATH=$(grep "4 " ${FILE2} | cut -d':' -f2)
  BABEL_PATH=$(grep "5 " ${FILE2} | cut -d':' -f2)
  CHIMERA_PATH=$(grep "6 " ${FILE2} | cut -d':' -f2)
else
  echo "pro_paths.out doesn't exist"
  echo "Configure the MHCBI pipeline executing setup.sh and select the option 3)"
  exit 1
fi

cd ${WORK_PATH}/${WORK_NAME}

#Optional stage
mkdir -p fmo-calculations

if [ -d "calculations" ]; then
  cd calculations
  if [ -d "final_pdbs" ]; then
    cp -r final_pdbs/ ../fmo-calculations/
    echo " "
    echo "****Note***"
    echo "All 3rd stage results are in PDB format in the FMO-calculations folder"
    echo "Use GUI Facio for creating GAMESS inputs under Fragment Molecular Orbital (FMO) method"
  else
    echo "***Warning***"
    echo "final_pdbs folder was not found in the 3rd stage methodology"
  fi
else
  echo "****Warning***"
  echo "Something went wrong, at this point third stage should be completed first. calculations folder was not found."
fi

cd ../fmo-calculations
mv final_pdbs input_pdbs

mkdir -p fmo_molecules

echo "***MHCBI says***"
echo "  "
echo "All input GAMESS that you create using Facio must be placed in " ${WORK_PATH}/${WORK_NAME}"/fmo-calculations/fmo_molecules/"
echo "  "
echo " "
echo "  All folders were organized"
