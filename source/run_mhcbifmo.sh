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

cd ${WORK_PATH}/${WORK_NAME}/fmo-calculations/fmo_molecules/

count=0
while [ $count -eq 0 ]
do
  read -p "Did you complete all three running stages? If you really finished all stages type (Yes(Y/y), otherwise (No(N/n)): " answer
  answer=${answer,,}

  if [ "$answer" == "yes" ] || [ "$answer" == "y" ]; then
    echo " *** "
    echo " "
    cp ../../source/dftb_input.info .
    cp ../../source/script_dftb_inp.sh .

    count1=0
    while [ $count1 -eq 0 ]
    do
      read -p "Did you perform GAMESS inputs using GUI Facio? type (Yes(Y/y) or (No(N/n)): " answer1
      answer1=${answer1,,}

      if [ "$answer1" == "yes" ] || [ "$answer1" == "y" ]; then
        echo " *** "
        echo " "
        chmod +x script_dftb_inp.sh
        chmod +x exec_fmo.sh
        for i in `ls *.inp`
        do
          ./script_dftb_inp.sh $i
        done
        ./exec_fmo.sh
        count1=1
      elif [ "$answer1" == "no" ] || [ "$answer1" == "n" ]; then
        echo "Go to fmo-calculations/input_pdbs/ path, in that directory there are all complex, receptor and ligand PDB structures from substitutions set. Use GUI Facio to convert them into FMO GAMESS inputs. Please make sure that you have installed all of required programs prior to run the test"
        echo " "
        echo "Once you complete this step type ./run.sh in" ${WORK_PATH}/${WORK_NAME}
        echo " bye..."
        exit 1;
      else
        echo "Please enter again your answer - yes (y) or no (n)"
      fi

    done

    count=1
  elif [ "$answer" == "no" ] || [ "$answer" == "n" ]; then
    echo "Please make sure that you have finished all of running stages prior to run pipeline using FMO method in GAMESS"
    echo " bye..."
    exit 1;
  else
    echo "Please enter again your answer - yes (y) or no (n)"
  fi

done

echo "****** MHCBI says: ******"
echo "  All GAMESS calculations were performed"
