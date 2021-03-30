  #!/bin/bash

#Author: Carlos Andres Ortiz Mahecha
#caraortizmah@gmail.com
#comment:
#This program creates the format of the residues to be charged

cd tobe_charged/

awk '$1=="ATOM"{if ($4=="ASP" || $4=="GLU" || $4=="ARG" || $4=="LYS" || $4=="HIS") {printf "%s %3d %s\n", $4, $6, $5 }}' res_charges.pdb | sort | uniq | awk 'BEGIN{i=1} {printf "%2d. %s\n", i++, $0}' > residues_charges

#using uniq -c, there is a additional column with the number of repetition of the printed sentence
#the second awk is only for assigning number at the beginning of each row in res_charges

cd ..
