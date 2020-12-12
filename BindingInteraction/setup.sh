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

while [ $input -ne 3 ]; 2> /dev/null
do
	echo "**********The MHCBI Setup**********"
	echo "Please select your option"
	echo "1 Set external program paths"
	echo "2 Test pipeline"
	echo "3 End pipeline setup"
	echo " "
	echo " "
	read input
	case $input in
		1)
			echo "***Assigning external program paths***"
			echo " "
			chmod +x pro_paths.sh
			./pro_paths.sh
			;;
		2)
			echo "***Testing pipeline***"
			echo " "
			cd test
			chmod +x test_mhcbi.sh
			./test_mhcbi.sh
			echo "...going to the menu..."
			echo " "
			echo
			cd ..
			;;
		3)
      echo "For configuring work paths and running the pipeline type: ./pre-run.sh"
			echo "  Closing setup... bye "
			exit 1
			;;
		*)
			#clear
			echo "Sorry, you need to choose an option among 1 up to 3"
			;;
		''|*[!0-9]*)
			#clear
			echo "Sorry, you need to choose a numerical option"
			let input=0
			;;
	esac
done
echo "end"
