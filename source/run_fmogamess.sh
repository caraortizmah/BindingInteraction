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
	echo "Configure the MHCBI pipeline executing setup.sh and select option 3)"
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
  echo "Configure the MHCBI pipeline executing setup.sh and select option 3)"
  exit 1
fi

let input=0

while [ $input -ne 4 ]; 2> /dev/null
do
  echo "**** The MHCBI Pipeline FMO calculations****"
  echo "Please select your option"
  echo "1. Configure FMO folders"
  echo "2. Prepare running GAMESS execution command"
  echo "3. Run MHCBI FMO"
  echo "4. End running pipeline"
  echo " "
  echo " "
  read input
  case $input in
    1)
      echo "***Configuring folders for FMO calculations***"
      echo " "
      cd ${WORK_PATH}/${WORK_NAME}/
      cp source/org_fmocalc.sh .
      chmod +x org_fmocalc.sh
      ./org_fmocalc.sh
      echo "...going to the menu..."
      rm -f org_fmocalc.sh
      ;;
    2)
      echo "***Preparing GAMESS execution command***"
      echo " "
      cd ${WORK_PATH}/${WORK_NAME}/
      cp source/fmoexemaker.sh .
      chmod +x fmoexemaker.sh

      ./fmoexemaker.sh "${GAMESS_PATH}"
      rm -f fmoexemaker.sh

      echo " "
      echo "...going to the menu..."
      ;;
    3)
      echo "***Running input GAMESS***"
      echo " "
      cd ${WORK_PATH}/${WORK_NAME}/
      cp -r misc/param_DFTB3 fmo-calculations/
      cp source/run_mhcbifmo.sh .
      mv -f exec_fmo.sh fmo-calculations/fmo_molecules/
      chmod +x run_mhcbifmo.sh
      ./run_mhcbifmo.sh
      echo " "
      echo "...going to the menu..."
      rm -f run_mhcbifmo.sh
      ;;
    4)
      echo "  Closing pipeline... bye "
      exit 1
      ;;
    *)
      #clear
      echo "Sorry, you need to choose an option among 1 up to 4"
      ;;
    ''|*[!0-9]*)
      #clear
      echo "Sorry, you need to choose a numerical option"
      let input=0
      ;;
  esac
done

cd ${WORK_PATH}/${WORK_NAME}

echo "****** MHCBI says: ******"
echo "  All folders and scripts were organized"
