#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program manages all script from the single point calculation part in the BindingInteraction pipeline.

PROPKA="$1"
MOPAC="$2"

if [ -z "$PROPKA" ] || [ -z "$MOPAC" ]
then
  echo "It lacks one argument to execute the script"
  echo "For instance: ./org_calc.sh propka 3.1 and MOPAC paths"
  exit 1
else
  echo "Running script... "
fi

./exec_pka.sh ${PROPKA}
./script_fishing_pka.sh
./script_H_charges.sh ${MOPAC}

echo "Single point calculation script finished"
