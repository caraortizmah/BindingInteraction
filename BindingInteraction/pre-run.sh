#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#  This is the setup for configuring external program paths and doing tests.
#*************************************

let input=0

while [ $input -ne 5 ]; 2> /dev/null
do
	echo "**** The MHCBI Pipeline ****"
	echo "Please select your option"
	echo "1 Set work paths"
	echo "2 Set external program paths"
	echo "3 Configure pipeline"
	echo "4 Test pipeline"
	echo "5 End pipeline setup"
	echo " "
	echo " "
	read input
	case $input in
		1)
			echo "***Assigning paths***"
			echo " "
			chmod +x paths.sh
			./paths.sh
			echo "...going to the menu..."
			;;
		2)
			echo "***Assigning external program paths***"
			echo " "
			./pro_paths.sh
			chmod +x pro_paths.sh
			;;
		3)
			echo "***Configuring program directories and folders***"
			echo " "
			chmod +x conf.sh
			./conf.sh
			echo "...going to the menu..."
			;;
		4)
			echo "***Testing pipeline***"
			echo " "
			cd test
			chmod +x test_mhcbi.sh
			./test_mhcbi.sh
			echo "...going to the menu..."
			cd ..
			;;
		5)
			echo "  Closing pipeline... bye "
			exit 1
			;;
		*)
			#clear
			echo "Sorry, you need to choose an option among 1 up to 5"
			;;
		''|*[!0-9]*)
			#clear
			echo "Sorry, you need to choose a numerical option"
			let input=0
			;;
	esac
done
echo "end"
