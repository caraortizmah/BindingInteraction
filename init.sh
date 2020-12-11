#!/bin/bash

#*************************************
# The MCH Binding Interaction (MHCBI) pipeline
# @author Carlos Andres Ortiz-Mahecha
#  (email: caraortizmah@gmail.com)
#  (email: caraortizmah@unal.edu.co)
# @comment:
#  This is the initial program enabling installation, setup, and running.
#*************************************

#****************************************************************************************
#******   The Major Histocompatibility Complex Binding Interaction  pipeline       ******
#******                                                                            ******
#******           This pipeline has been developed by                              ******
#******                                                                            ******
#******               CARLOS ANDRES ORTIZ-MAHECHA                                  ******
#******                 caraortizmah@gmail.com                                     ******
#******                caraortizmah@unal.edu.co                                    ******
#******                                                                            ******
#****** Further info :                                                             ******
#******                 https://github.com/caraortizmah/BindingInteraction         ******
#****************************************************************************************

echo "**************************************************************"
echo "|||               Welcome to The MHCBI pipeline            |||"
echo "|||                                                        |||"
echo "||| Further info:                                          |||"
echo "|||   https://github.com/caraortizmah/BindingInteraction   |||"
echo "|||                                                        |||"
echo "**************************************************************"

mv BindingInteraction/install.sh .
mv BindingInteraction/clean.sh .
chmod +rx *.sh
echo "****** MHCBI says: ******"
echo "  Starting pipeline "
./install.sh

echo ""
echo "Once you are in the MHCBI path"
echo "  Type ./setup.sh"
