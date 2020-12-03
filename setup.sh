#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com

let input=0

while [ $input -ne 3 ]; 2> /dev/null
do
	echo "**** The MHCBI Pipeline ****"
	echo "Please select your option"
	echo "1 Set paths"
	echo "2 Configure workdir"
	echo "3 End pipeline"
	echo " "
	echo " "
	read input
	case $input in
		1)
			echo "***Assigning paths***"
			echo " "
			./paths.sh
			echo "...going to the menu..."
			;;
		2)
			echo "***Configuring work directory***"
			echo " "
			./conf.sh
			echo "...going to the menu..."
			;;
		3)
			echo "  Closing pipeline... bye "
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
