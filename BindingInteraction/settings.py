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
import os
import csv


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
  print("** 1. Check saved paths")
  print("** 2. Assign paths")
  print("** 3. Exit")

  option = v_input("** ")
  while (type(option) == str) or ((option != 1) and (option != 2) and (option != 3)):
    option = v_input("** Select just a number in the four options ")

  if (option == 1):
    print("** Cheking paths of programs")
    file.options()
  elif (option == 2):
    print("** Assigning paths")
    paths.selection()
  elif (option == 3):
    print("** Exit program paths... bye")
    sys.exit()
  else:
    print("** Something goes wrong... bye")
    sys.exit()

class Save:

  """
  This class saves information about the path of each program in a file:
  """

  def __init__(self):
    """
    Verify if the file of paths exist or not
    """
    self.path_dict_file = {}
    if (os.path.isfile('./conf_path.csv')): #change place
      self.isfile = True
    else:
      self.isfile = False

  def options(self):
    """
    Select and option to load from file, save, edit or adding file with program paths
    """

    print("** Select an option:")
    print("** 1. Load information.")
    print("** 2. Edit and Save information.")
    print("** 3. Detele information.")
    print("** 4. Return")

    option = v_input("** ")
    clause = (option != 1) and (option != 2) and (option != 3) and (option != 4)
    while (type(option) == str) or (clause):
      print("option ",option)
      option = v_input("** Select just a number in the four options ")

    if (option == 1):
      print("** Loading information from file")
      file.open()
    elif (option == 2):
      print("** Assigning new paths")
      file.edit()
    elif (option == 3):
      print("** Deleting information from path")
      file.delete()
    elif (option == 4):
      print("** Returning... bye")
      manager()
    else:
      print("** Something goes wrong... bye")
      manager()

  def open(self):
    """
    open file if exits
    """
    if (self.isfile):
      print("** List of paths: ")
      print("** Program \t\t Path")
      with open("conf_path.csv", "r") as f:
        creader = csv.reader(f, delimiter=",")
        for row in creader:
          if (row[1]==''):
            print("** ", row[0], "\t\tNo assigned")
          else:
            print("** ", row[0], "\t\t", row[1])

    else:
      print("conf_path.csv does not exits")
      dec=v_input("Do you want to create it? (y/n)")
      dec=dec.upper()
      while (type(dec) == int) or (not dec.strip()) or ((dec!='Y') and (dec!='N')):
        dec = v_input("** Select 'y' or 'n': ")
      if (dec=='Y'):
        print("edit")
        file.edit()
      else:
        print("Returning... bye")
        manager()

  def edit(self):
    """
    create or save conf_path.csv
    """
    if (self.isfile):
      path_file=file.get_paths_file()
      print("** ./conf_path.csv already exist")
      paths.selection()
      file.open()
    else:
      
      try:
        with open("conf_path.csv", "w") as f:
          writer = csv.writer(f, delimiter=",")
          for key in path_file.keys():
            f.write("%s , %s\n"%(key,path_file[key]))
        print("** information saved in conf_path.csv")
        self.isfile = True
      except IOError:
        print("** Something goes wrong: I/O error")
      except:
        print("** Something goes wrong")
      print("** Edited and Saved")

    manager()

  def save(self):
    """
    create or save conf_path.csv
    """
    path_file={}
    if (self.isfile):
      print("** ./conf_path.csv already exist")
      file.open()
    else:
      path_file=paths.get_paths()
      try:
        with open("conf_path.csv", "w") as f:
          writer = csv.writer(f, delimiter=",")
          for key in path_file.keys():
            f.write("%s , %s\n"%(key,path_file[key]))
        print("** information saved in conf_path.csv")
        self.isfile = True
      except IOError:
        print("** Something goes wrong: I/O error")
      except:
        print("** Something goes wrong")
      print("** Edited and Saved")

    manager()

  def get_paths_file(self):
    """
    extract all paths saved in a directory
    """
    if (self.isfile):
      with open("conf_path.csv", "r") as f:
        creader = csv.reader(f, delimiter=",")
        for row in creader:
          self.path_dict_file[row[0]]=row[1]
    return self.path_dict_file

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
    if (os.path.isfile('./conf_path.csv')):
      self.isfile = True
      file.open()
    else:
      self.isfile = False
      self.vmd = ''
      self.mopac = ''
      self.chimera = ''
      self.propka = ''
      self.gamess = ''
      self.facio = ''
      self.wine = ''
      self.path_dict = {}

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
    print("** 7. Show paths.")
    print("** 8. Return")

    option = v_input("** ")
    cluase = (option != 1) and (option != 2) and (option != 3) and (option != 4) and (option != 5) \
      and (option != 6) and (option != 7) and (option != 8)
    while (type(option) == str) or (cluase):
      option = v_input("** Select just a number in the seven options ")

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
      print("** Showing paths")
      paths.show_paths()
    elif (option == 8):
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
    print("Paths saved in temporary memory")
    print("VMD path: ", self.vmd)
    print("MOPAC path: ", self.mopac)
    print("Chimera path: ", self.chimera)
    print("Propka3.1 path: ", self.propka)
    print("GAMESS path: ", self.gamess)
    print("Facio path: ", self.facio)
    print("Wine path: ", self.wine)

  def get_paths(self):
    """
    prepare all paths to be saved returning them in a dictionary
    """
    self.path_dict['vmd']=self.vmd
    self.path_dict['mopac']=self.mopac
    self.path_dict['chimera']=self.chimera
    self.path_dict['propka']=self.propka
    self.path_dict['gamess']=self.gamess
    self.path_dict['facio']=self.facio
    self.path_dict['wine']=self.wine
    return self.path_dict





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
  file = Save()
  manager()
