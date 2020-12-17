#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#  This is the setup for configuring work paths and running pipeline.
#*************************************

let input=0

while [ $input -ne 4 ]; 2> /dev/null
do
	echo "**********The MHCBI work**********"
	echo "Please select your option"
	echo "1 Set work paths"
	echo "2 Configure MHCBI work"
	echo "3 Run"
	echo "4 End pipeline work"
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
			echo "***Configuring program directories and folders***"
			echo " "

      echo "****Warning****"
      echo "  "

      count=0
      while [ $count -eq 0 ]
      do
        echo "Did you complete all of the requirements in the setup.sh first step? and"
        echo "Did you complete the test (setup.sh second step) and set work paths (pre-run.sh first step)?"
        read -p " If you really fulfil the requirements type (Yes(Y/y), otherwise (No(N/n)): " answer
        answer=${answer,,}

        if [ $answer == "yes" ] || [ $answer == "y" ]; then
          echo " *** "
          echo " "
          count=1
        elif [ $answer == "no" ] || [ $answer == "n" ]; then
          echo "Please make sure that you have successfully tested MHCBI pipeline and properly set your required paths for a new proyect."
          echo " bye..."
          exit 1;
        else
          echo "Please enter again your answer - yes (y) or no (n)"
        fi

      done
			chmod +x conf.sh
			./conf.sh
			echo "...going to the menu..."
			;;
		3)
			echo "***Running work***"
			echo " "

      FILE=paths.out

      if [ -f "$FILE" ]; then
        WORK_PATH=$(grep "4 " ${FILE} | cut -d':' -f2)
        WORK_NAME=$(grep "5 " ${FILE} | cut -d':' -f2)
      else
        echo "paths.out doesn't exist"
        echo "Configure the MHCBI pipeline executig setup.sh and select option 3)"
        exit 1
      fi

			while :
			do
				read -p "Did you previously configure your new proyect (steps 1 and 2 from pre-run.sh)? (Yes(Y/y)/No(N/n)) " answer
				answer=${answer,,}

				if [ -z "${answer}" ]; then
					echo "Empty answer, please enter again your answer - yes (y) or no (n)"
				elif [ $answer == "yes" ] || [ $answer == "y" ]; then
					echo " "
          cd ${WORK_PATH}/${WORK_NAME}/
					cp source/run.sh .
			    chmod +x run.sh
			    ./run.sh
					break
				elif [ $answer == "no" ] || [ $answer == "n" ]; then
					echo " "
					read -p "Please, first of all complete steps 1 and 2 (in that order) prior to run your new proyect"
					break
				else
					echo "Please enter again your answer - yes (y) or no (n)"
				fi
			done
			echo "...going to the menu..."
			;;
		4)
			echo "  Closing the MHCBI pipeline... bye "
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
echo "end"
