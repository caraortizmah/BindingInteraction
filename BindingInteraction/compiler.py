"""
*************************************
BindingInteraction -v1.0.1

@author Carlos Andres Ortiz-Mahecha 
  (email: caraortizmah@gmail.com)
  (email: caraortizmah@unal.edu.co)

@brief Compiler
This program compile all py files that find in all package.
This program belongs to installer package.
*************************************
"""

from __future__ import print_function
from subprocess import Popen, PIPE

p = Popen("python -m compileall -l ls *.py",shell=True,stderr=PIPE,stdout=PIPE)
for path in p.stdout.readlines():
	print (path.decode())


