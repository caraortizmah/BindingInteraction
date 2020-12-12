#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

echo "****Warning****"
echo "Make sure that you have already installed the following linux text processing tools: "
echo "  1. Grep"
echo "  2. Cut"
echo "  3. Awk"
echo "  4. Sed"
echo "and the following specialized softwares such as: "
echo "  5. Open Babel"
echo "  6. VMD - Visual Molecular Dynamics"
echo "  7. MOPAC - Molecular Orbital PACkage"
echo "  8. UCSF Chimera"
echo "  9. PROPKA 3.1"
echo " 10. GAMESS - General Atomic and Molecular Electronic Structure System"
echo " 11. python 2.7 or higher"
echo "****Warning****"
echo "  "

count=0
while [ $count -eq 0 ]
do
  read -p "Do you complete until third step when executing ./setup.sh? If you really fulfil the requirements type (Yes(Y/y), otherwise (No(N/n)): " answer
  answer=${answer,,}

  if [ $answer == "yes" ] || [ $answer == "y" ]; then
    echo " *** "
    echo " "
    count=1
  elif [ $answer == "no" ] || [ $answer == "n" ]; then
    echo "Please make sure that you have installed all of required programs prior to run the test and that you configure MHCBI pipeline until 3rd step"
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
    PDB_NAME="1bx2-shortx2.pdb"
    WORK_NAME="1bx2-short_test"
    echo " "
    break
  elif [ $answer == "2" ]; then
    echo "***Using 3OXS***"
    PDB_NAME="example-3oxs.pdb"
    WORK_NAME="3oxs_test"
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
cp ../../paths.out .

cd ${WORK_PATH}/${WORK_NAME}/
cp source/organizer.sh .
cp source/run_mhcbi.sh .

./organizer.sh
cp ../../listm_test-tmp mutations/listm.log
./run_mhcbi.sh

echo "**** Bear in mind: "
echo "Run the pipeline typing ./pre-run.sh in this path: " ${WORK_PATH}/${WORK_NAME}/
echo "*** "
echo "    "

