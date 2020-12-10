#!/bin/bash
#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#Use before configuring pipeline again or making it a git operation


rm -f paths.log
rm -f pro_paths.log
cd test/
rm -f conf.sh
rm -f paths.log
rm -f *.out
rm -rf workdir_test
cd ../BindingInteraction/
mv -f ../clean.sh .
mv ../conf.sh .
mv ../paths.sh .
mv ../pro_paths.sh .
mv ../setup.sh .
chmod -x *.sh

echo "****** MHCBI says: ******"
echo "  Pipeline were cleaned"
echo "  Pipeline ready to configure or git (add, commit, pull, push...)"
