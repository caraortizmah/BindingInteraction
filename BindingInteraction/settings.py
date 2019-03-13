"""
*************************************
BindingInteraction

@author Carlos Andres Ortiz-Mahecha 
  (email: caraortizmah@gmail.com)
  (email: caraortizmah@unal.edu.co)

@brief Settings module
This module checks all information necessary to call each computational chemistry software.
BindingInteraction can not work if some path is lacking.
*************************************
"""

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from platform import python_version
from collections import OrderedDict

import io
import sys


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

def manager():
  """
  Manager
  """
  print("** Select an option:")
  print("** 1. Assign paths")
  print("** 2. Show paths")
  print("** 3. Save paths")
  print("** 4. Exit")

  option = v_input("** ")
  while (type(option) == str) or ((option != 1) and (option != 2) and (option != 3) and (option != 4)):
    option = v_input("** Select just a number in the four options ")

  if (option == 1):
    print("** Assigning paths")
    paths.selection()
  elif (option == 2):
    print("** Showing paths of all programs")
    paths.show_paths()
  elif (option == 3):
    print("Save paths")
  elif (option == 4):
    print("Exit program paths... bye")
    sys.exit()
  else:
    print("Something goes wrong... bye")
    sys.exit()

class Path:

  """
  This class saves information about the path of each program that BindingInteraction needs:
  1. VMD for Dowser plugin.
  3. MOPAC.
  4. Chimera.
  5. Propka3.1.
  6. GAMESS
  7. Wine and Facio FMO util
  """

  def __init__(self):
    """
    class Molecule needs a name of the protein
    """
    self.vmd = ''
    self.mopac = ''
    self.chimera = ''
    self.propka = ''
    self.gamess = ''
    self.facio = ''
    self.wine = ''

  def selection(self):
    """
    Select and option to put the program path
    """

    print("** Select an option:")
    print("** 1. VMD.")
    print("** 2. MOPAC.")
    print("** 3. Chimera.")
    print("** 4. Propka3.1.")
    print("** 5. GAMESS.")
    print("** 6. Facio FMO util.")
    print("** 7. Return")

    option = v_input("** ")
    cluase = (option != 1) and (option != 2) and (option != 3) and (option != 4) and (option != 5) \
      and (option != 6) and (option != 7)
    while (type(option) == str) or (cluase):
      option = v_input("** Select just a number in the four options ")

    if (option == 1):
      print("** Assigning VMD path")
      paths.vmd_path()
    elif (option == 2):
      print("** Assigning MOPAC path")
      paths.mopac_path()
    elif (option == 3):
      print("** Assigning Chimera path")
      paths.chimera_path()
    elif (option == 4):
      print("** Assigning Propka3.1 path")
      paths.propka_path()
    elif (option == 5):
      print("** Assigning GAMESS path")
      paths.gamess_path()
    elif (option == 6):
      print("** Assigning Facio FMO util and wine paths")
      paths.facio_path()
    elif (option == 7):
      print("Returning... bye")
      manager()
    else:
      print("Something goes wrong... bye")
      manager()

  def vmd_path(self):
    """
    recevie path of vmd
    """
    path = ''
    while (type(path) == int) or (not path.strip()):
      path = v_input("** Put the path of vmd: ")
    self.vmd = path
    paths.selection()

  def mopac_path(self):
    """
    recevie path of mopac
    """
    path = ''
    while (type(path) == int) or (not path.strip()):
      path = v_input("** Put the path of mopac: ")
    self.mopac = path
    paths.selection()

  def chimera_path(self):
    """
    recevie path of chimera
    """
    path = ''
    while (type(path) == int) or (not path.strip()):
      path = v_input("** Put the path of chimera: ")
    self.chimera = path
    paths.selection()

  def propka_path(self):
    """
    recevie path of propka
    """
    path = ''
    while (type(path) == int) or (not path.strip()):
      path = v_input("** Put the path of propka: ")
    self.propka = path
    paths.selection()

  def gamess_path(self):
    """
    recevie path of gamess
    """
    path = ''
    while (type(path) == int) or (not path.strip()):
      path = v_input("** Put the path of gamess: ")
    self.gamess = path
    paths.selection()

  def facio_path(self):
    """
    recevie path of Facio and wine
    """
    path = ''
    path2 = ''
    while (type(path) == int) or (not path.strip()):
      path = v_input("** Put the path of facio: ")
    self.facio = path
    while (type(path2) == int) or (not path2.strip()):
      path2 = v_input("** Put the path of wine: ")
    self.wine = path2
    paths.selection()

  def show_paths(self):
    """
    Print information over paths of all necessary programs
    """
    print("Paths saved")
    print("VMD path: ", self.vmd)
    print("MOPAC path: ", self.mopac)
    print("Chimera path: ", self.chimera)
    print("Propka3.1 path: ", self.propka)
    print("GAMESS path: ", self.gamess)
    print("Facio path: ", self.facio)
    print("Wine path: ", self.wine)


#  def __del__(self):
#    print ("** Destructor deleting object ", self.paths)


if __name__ == '__main__':

  print("************************************************************")
  print("**                                                        **")
  print("**              BINDINGINTERACTION 1.0.1                  **")
  print("**                  Program Paths                         **")
  print("**                                                        **")
  print("************************************************************")
  print("                                                            ")
  print("                                                            ")
  print("                                                            ")

  paths = Path()
  manager()






  #mol=Path(mol_name)
  #mol.manager_mol()