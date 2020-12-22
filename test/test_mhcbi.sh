#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

echo "****Warning****"
echo "  "

count=0
while [ $count -eq 0 ]
do
  read -p "Did you complete all of the requirements in the setup.sh first step? If you really fulfil the requirements type (Yes(Y/y), otherwise (No(N/n)): " answer
  answer=${answer,,}

  if [ $answer == "yes" ] || [ $answer == "y" ]; then
    echo " *** "
    echo " "
    count=1
  elif [ $answer == "no" ] || [ $answer == "n" ]; then
    echo "Please make sure that you have installed all of required programs prior to run the test"
    echo " bye..."
    exit 1;
  else
    echo "Please enter again your answer - yes (y) or no (n)"
  fi

done

#cleaning previous test

echo "cleaning previous test"
rm -f *.out
rm -f *.log
rm -f conf.sh
rm -rf workdir_test

while :
do

  echo "Please select an option"
  echo "1. Short test"
  echo "2. Straight test"
  echo "3. End test"
  echo " "
  read answer

  if [ -z "${answer}" ]; then
    echo "Empty answer, please choose an option - (1), (2) or (3)"
  elif [ $answer == "1" ]; then
    echo "***Using 1BX2 fraction***"
    PDB_NAME="1bx2shortened.pdb"
    WORK_NAME="1bx2shortened"
    si_short="si_short"
    echo " "
    break
  elif [ $answer == "2" ]; then
    echo "***Using 3OXS***"
    PDB_NAME="3oxsstraight.pdb"
    WORK_NAME="3oxsstraight"
    si_short="si_straight"
    break
  else
    echo "Sorry, you need to choose an option (1, 2 or 3)"
    exit 1
  fi

done

PDB_PATH=$PWD
WORK_PATH=$(echo "${PWD}/workdir_test")

cat << EOF > paths.out
***Path List***
***Do not change any word in this file***
1 :$MHCBI_PATH
2 :$PDB_PATH
3 :$PDB_NAME
4 :$WORK_PATH
5 :$WORK_NAME
***
EOF

mkdir -p workdir_test
cp ../pro_paths.log .
cp ../conf.sh .
cp ../source/get_propaths.sh .
chmod +x get_propaths.sh
./get_propaths.sh

cd ${WORK_PATH}
mkdir -p ${WORK_NAME}
cp -r ../../source/ ${WORK_PATH}/${WORK_NAME}
cd ${WORK_PATH}/${WORK_NAME}/source/
chmod +x *.sh #giving permissions
chmod +x *.tcl
cd ../
cp ${PDB_PATH}/${PDB_NAME} .
#cp ../../paths.out .
cp ../../pro_paths.out .
mkdir -p optimizations
mkdir -p mutations
mkdir -p calculations
mkdir -p fmo-calculations
cp ../../paths.out .

cd ${WORK_PATH}/${WORK_NAME}/
cp source/organizer.sh .
cp source/tester.sh .
cp source/run_mhcbi.sh .

./organizer.sh
cp ../../listm_test-tmp mutations/listm.log
./run_mhcbi.sh

echo " "
echo "****Checking test..."
echo " "
./tester.sh

echo "**** Bear in mind: "
echo "Run the pipeline typing ./pre-run.sh in this path: " ${WORK_PATH}/${WORK_NAME}/
echo "*** "
echo "    "

echo "For FMO test is not necessary to have installed GUI Facio"
echo "In test folder there are two aditional folders containing FMO input GAMESS (si_short and si_straight) aiming to facilitate a complete test"

count=0
while [ $count -eq 0 ]
do
  read -p "Do you want to test FMO section? type (Yes(Y/y), otherwise (No(N/n)): " answer
  answer=${answer,,}

  if [ "$answer" == "yes" ] || [ "$answer" == "y" ]; then
    echo " *** "
    echo " "
    count=1
  elif [ "$answer" == "no" ] || [ "$answer" == "n" ]; then
    echo "Ending test..."
    exit 1;
  else
    echo "Please enter again your answer - yes (y) or no (n)"
  fi

done

cd fmo-calculations
cp -r ../calculations/final_pdbs input_pdbs

mkdir -p fmo_molecules

#***only for test
cp ../../../${si_short}/*.inp fmo_molecules/
#***

cd ${WORK_PATH}/${WORK_NAME}/

if [ -f "pro_paths.out" ]; then
  GAMESS_PATH=$(grep "4 " pro_paths.out | cut -d':' -f2)
else
  echo "There is no absolute path for GAMESS"
fi

cp source/fmoexemaker.sh .
chmod +x fmoexemaker.sh

./fmoexemaker.sh "${GAMESS_PATH}"
rm -f fmoexemaker.sh

cd ${WORK_PATH}/${WORK_NAME}/
cp source/run_mhcbifmo.sh .
mv exec_fmo.sh fmo-calculations/fmo_molecules/
chmod +x run_mhcbifmo.sh
./run_mhcbifmo.sh
rm -f run_mhcbifmo.sh

echo "**** Bear in mind: "
echo "Run the pipeline typing ./pre-run.sh in this path: " ${WORK_PATH}/${WORK_NAME}/
echo "*** "
echo "    "
