"""
*************************************
BindingInteraction -v1.0.1

@author Carlos Andres Ortiz-Mahecha
  (email: caraortizmah@gmail.com)
  (email: caraortizmah@unal.edu.co)

@brief FrontDesk module
This module initializes .....

*************************************
"""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from platform import python_version
from collections import OrderedDict
from subprocess import call

import io
import sys
import os
import csv
from BindingInteraction import settings

#import BindingInteraction.settings, BindingInteraction.BI_module


def v_input(inp):
  """
  check version of python to decide if use input() or raw_input()
  if python version is greater or equal than 3, program uses input("")
  else program uses raw_input("")
  """

  v=python_version()
  if int(v[0]) >= 3:
    int_inp = input(inp)
    try:
      out = int(int_inp)
    except:
      out = int_inp
  else:
    int_inp = raw_input(inp)
    try:
      out = int(int_inp)
    except:
      out = int_inp
  return out

def main():
  """
  Front Desk of program
  """
  print("** Select an option:")
  print("** 1. Settings")
  print("** 2. Molecule features")
  print("** 3. Exit")

  option = v_input("** ")
  while (type(option) == str) or ((option != 1) and (option != 2) and (option != 3)):
    option = v_input("** Select just a number in the three options ")

  if (option == 1):
    file = settings.Actions()
    paths = settings.Path()
    settings.manager()
    #main()
  elif (option == 2):
    call(["python", "settings.py"])
    main()
  elif (option == 3):
    print("** Exit program... bye")
    sys.exit()
  else:
    print("** Something goes wrong... bye")
    sys.exit()


if __name__ == '__main__':

  print("************************************************************")
  print("**                                                        **")
  print("**              BINDINGINTERACTION 1.0.1                  **")
  print("**                    Welcome                             **")
  print("**                                                        **")
  print("************************************************************")
  print("")
  print("")
  print("")

  main()


