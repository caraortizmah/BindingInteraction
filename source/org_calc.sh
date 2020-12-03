#!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#This program manages all script from the single point calculation part in the BindingInteraction pipeline.

./exec_pka.sh
./script_fishing_pka.sh
./script_H_charges.sh

echo "Single point calculation script finished"
