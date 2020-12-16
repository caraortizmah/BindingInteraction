#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#  This is the configuration pipeline through Shell Script, a straightforward to use it.
#*************************************


FILE=paths.log
FILE2=pro_paths.log

MHCBI_PATH=$PWD

#requires

echo "  "
echo "****Note****"
echo "Make sure that you have already installed the following programs:"
echo " "
echo "Linux text processing tools such as:"
echo "  1. Grep"
echo "  2. Cut "
echo "  3. Awk "
echo "  4. Gawk"
echo "  4. Sed "
echo "The chemical softwares and toolboxes such as"
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
	read -p "Do you already install all of requierements? (Yes(Y/y)/No(N/n)): " answer
	answer=${answer,,}

	if [ $answer == "yes" ] || [ $answer == "y" ]; then
		echo " *** "
		echo " "
    count=1
	elif [ $answer == "no" ] || [ $answer == "n" ]; then
		echo "Please make sure that you have installed all of required programs prior to run MHCBI pipeline"
		echo " bye..."
		exit 1;
	else
		echo "Please enter again your answer - yes (y) or no (n)"
	fi

done

#MHCBI directory
if [ -f "$FILE" ]; then

	#Work directory
	let cond=`grep -c "Work path" paths.log`
	if [ ${cond} -eq 1 ]; then
		WORK_PATH=$(grep "Work path" paths.log | cut -d':' -f2)
		if [[ -z "${WORK_PATH// }" ]] ; then
			echo "Work directory is empty"
		else
		        WORK_PATH=$(echo "$WORK_PATH" | awk '$1=$1')
			echo "work_path finished" $WORK_PATH
		fi
	else
		echo "Work directory was not detected"
		echo "Something in paths.log would be wrong. Set all paths again"
	fi

	#PDB structure path
	let cond=`grep -c "PDB path" paths.log`
	if [ ${cond} -eq 1 ]; then
		PDB_PATH=$(grep "PDB path" paths.log | cut -d':' -f2)
		if [[ -z "${PDB_PATH// }" ]] ; then
			echo "PDB structure path is empty"
		else
		        PDB_PATH=$(echo "$PDB_PATH" | awk '$1=$1')
			echo "pdb_path finished" $PDB_PATH
		fi
	else
		echo "PDB structure path was not detected"
		echo "Something in paths.log would be wrong. Set all paths again"
	fi

	#PDB name
	let cond=`grep -c "PDB name" paths.log`
	if [ ${cond} -eq 1 ]; then
		PDB_NAME=$(grep "PDB name" paths.log | cut -d':' -f2)
		if [[ -z "${PDB_NAME// }" ]] ; then
			echo "PDB structure name is empty"
		else
		        PDB_NAME=$(echo "$PDB_NAME" | awk '$1=$1')
			echo "pdb_name finished" $PDB_NAME
		fi
	else
		echo "PDB structure name was not detected"
		echo "Something in paths.log would be wrong. Set all paths again"
	fi

	#Work name
	let cond=`grep -c "Work name" paths.log`
	if [ ${cond} -eq 1 ]; then
		WORK_NAME=$(grep "Work name" paths.log | cut -d':' -f2)
		if [[ -z "${WORK_NAME// }" ]] ; then
			echo "To-do work name is empty"
			echo "Work name will be assigned as pdb structure name"
			WORK_NAME=$(echo "$PDB_NAME" | cut -d'.' -f1)
			echo "work_name finished" $WORK_NAME
		else
			echo "work_name finished" $WORK_NAME
		fi
		WORK_NAME=$(echo "$WORK_NAME" | awk '$1=$1')
	else
		echo "To-do work name was not detected"
		echo "Work name will be assigned as pdb structure name"
		WORK_NAME=$(echo "$PDB_NAME" | cut -d'.' -f1)
		echo "work_name finished" $WORK_NAME
		WORK_NAME=$(echo "$WORK_NAME" | awk '$1=$1')
	fi

	#Creating directories

	cd ${WORK_PATH}
	mkdir -p ${WORK_NAME}
	cd ${MHCBI_PATH}
	cp -r source/ ${WORK_PATH}/${WORK_NAME}
	cd ${WORK_PATH}/${WORK_NAME}/source/
	chmod +x *.sh #giving permissions
	chmod +x *.tcl
	cd ../
	cp ${PDB_PATH}/${PDB_NAME} .
	mkdir -p optimizations
	mkdir -p mutations
	mkdir -p calculations

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

  cd ${MHCBI_PATH} #pro_paths.log in this directory

else
	echo "First of all set the list of directories"
	echo "(execute pre-run.sh and select option 1)"
	exit 1
fi


#external programs
if [ -f "$FILE2" ]; then

	#MOPAC path
	let cond=`grep -c "MOPAC path" pro_paths.log`
	if [ ${cond} -eq 1 ]; then
		MOPAC_PATH=$(grep "MOPAC path" pro_paths.log | cut -d':' -f2) # After this cut.. there is a non-empty string assigned in this variable
		if [[ -z "${MOPAC_PATH// }" ]] ; then # This ( ${param //} ) expands the param variable and replaces all matches of the pattern (a single space) with nothing
			echo "MOPAC path is empty"
		else
		        MOPAC_PATH=$(echo "$MOPAC_PATH" | awk '$1=$1') #remove blank spaces (head & tail)
			echo "MOPAC_path finished" $MOPAC_PATH
		fi
	else
		echo "MOPAC path was not detected"
		echo "Something in pro_paths.log would be wrong. Set all program paths again"
	fi

	#Propka 3.1 path
	let cond=`grep -c "Propka 3.1 path" pro_paths.log`
	if [ ${cond} -eq 1 ]; then
		PKA_PATH=$(grep "Propka 3.1 path" pro_paths.log | cut -d':' -f2)
		if [[ -z "${PKA_PATH// }" ]] ; then
			echo "Work directory is empty"
		else
		        PKA_PATH=$(echo "$PKA_PATH" | awk '$1=$1')
			echo "PKA_path finished" $PKA_PATH
		fi
	else
		echo "Propka 3.1 path was not detected"
		echo "Something in pro_paths.log would be wrong. Set all paths again"
	fi

	#VMD path
	let cond=`grep -c "VMD path" pro_paths.log`
	if [ ${cond} -eq 1 ]; then
		VMD_PATH=$(grep "VMD path" pro_paths.log | cut -d':' -f2)
		if [[ -z "${VMD_PATH// }" ]] ; then
			echo "VMD structure path is empty"
		else
		        VMD_PATH=$(echo "$VMD_PATH" | awk '$1=$1')
			echo "VMD_path finished" $VMD_PATH
		fi
	else
		echo "VMD path was not detected"
		echo "Something in pro_paths.log would be wrong. Set all paths again"
	fi

	#GAMESS path
	let cond=`grep -c "GAMESS path" pro_paths.log`
	if [ ${cond} -eq 1 ]; then
		GAMESS_PATH=$(grep "GAMESS path" pro_paths.log | cut -d':' -f2)
		if [[ -z "${GAMESS_PATH// }" ]] ; then
			echo "gamess path is empty"
		else
		        GAMESS_PATH=$(echo "$GAMESS_PATH" | awk '$1=$1')
			echo "GAMESS_PATH finished" $GAMESS_PATH
		fi
	else
		echo "gamess path was not detected"
		echo "Something in pro_paths.log would be wrong. Set all paths again"
	fi

	#OpenBabel path
	let cond=`grep -c "Babel path" pro_paths.log`
	if [ ${cond} -eq 1 ]; then
		BABEL_PATH=$(grep "Babel path" pro_paths.log | cut -d':' -f2)
		if [[ -z "${BABEL_PATH// }" ]] ; then
			echo "OpenBabel path is empty"
		else
		        BABEL_PATH=$(echo "$BABEL_PATH" | awk '$1=$1')
			echo "BABEL_PATH finished" $BABEL_PATH
		fi
	else
		echo "openbabel path was not detected"
		echo "Something in pro_paths.log would be wrong. Set all paths again"
	fi

	#Chimera path
	let cond=`grep -c "Chimera path" pro_paths.log`
	if [ ${cond} -eq 1 ]; then
		CHIMERA_PATH=$(grep "Chimera path" pro_paths.log | cut -d':' -f2)
		if [[ -z "${CHIMERA_PATH// }" ]] ; then
			echo "Chimera path is empty"
		else
		        CHIMERA_PATH=$(echo "$CHIMERA_PATH" | awk '$1=$1')
			echo "CHIMERA_PATH finished" $CHIMERA_PATH
		fi
	else
		echo "Chimera path was not detected"
		echo "Something in pro_paths.log would be wrong. Set all paths again"
	fi

  cd ${WORK_PATH}/${WORK_NAME}/ #locating pro_paths.out in the same place to paths.out

  cat << EOF > pro_paths.out
***Program path List***
***Do not change any word in this file***
1 :$MOPAC_PATH
2 :$PKA_PATH
3 :$VMD_PATH
4 :$GAMESS_PATH
5 :$BABEL_PATH
6 :$CHIMERA_PATH
***
EOF


	cp source/organizer.sh .
	cp ${MHCBI_PATH}/pre-run.sh .
	echo "**** Bear in mind: "
	echo "To run the work pipeline, type: ./pre-run.sh (option 3) in this path: " ${WORK_PATH}/${WORK_NAME}/
	echo "*** "
	echo "    "
	chmod +x organizer.sh
	chmod +x pre-run.sh
	./organizer.sh

	echo "For running type: cd "${WORK_PATH}/${WORK_NAME}/
	echo "and then type ./pre-run.sh (option 3)"

else
	echo "Error: set the external program paths"
	echo "(execute setup.sh and select option 1)"
	exit 1
fi

echo "  Overall configuration finished"
echo "  Now you can test the MHCBI pipeline"
echo "  "

