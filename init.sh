#!/bin/bash

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

cd BindingInteraction/
chmod +rx *.sh
mv *.sh ../
cd ..

echo ""
echo "****** MHCBI says: ******"
echo "  Pipeline initialized"
echo "  Type ./setup.sh"
