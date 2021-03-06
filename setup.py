"""A setuptools for BindingInteraction pipeline
See for more: 
https://github.com/caraortizmah/bindinginteraction.git
"""
# latin-1

from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import io, os, sys

from setuptools import setup, find_packages

with open('README.md') as f:
    readme = f.read()

with open('LICENSE') as f:
    license = f.read()

description = "Sample package for BindingInteraction pipeline"


setup(
    name='BindingInteraction',
    version='1.0.1',
    description=description,
    long_description=readme,
    url='https://github.com/caraortizmah/BindingInteraction',
    author='Carlos Andres Ortiz-Mahecha',
    author_email='caraortizmah@unal.edu.co',
    license=license,

    # See https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Scientific researcher',
        'Topic :: Software Development :: Pipelines :: Python Modules',
        'Topic :: Computational Chemistry',
        'Topic :: Scientific/Engineering :: Chemistry',
        'License :: GNU General Public License v3.0',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Bash :: 4.4',
        'Programming Language :: Bash :: 4.3',
        'Programming Language :: Tcl :: 8.6',
    ],

    # What does your project relate to?
    keywords='Ligand-Receptor Interaction',

    packages=find_packages(exclude=['docs', 'tests']),

    # Alternatively, if you want to distribute just a my_module.py, uncomment
    # this:
    #   py_modules=["my_module"],

    # List run-time dependencies here.  These will be installed by pip when
    # your project is installed. For an analysis of "install_requires" vs pip's
    # requirements files see:
    # https://packaging.python.org/en/latest/requirements.html
    install_requires=[
        'requests>=2.7.0',
    ],

    python_requires='>=2.6, !=3.0.*, !=3.1.*, !=3.2.*, <4',

    # List additional groups of dependencies here (e.g. development
    # dependencies). You can install these using the following syntax,
    # for example:
    # $ pip install -e .[dev,test]
    extras_require={
        'dev': ['check-manifest'],
        'test': ['coverage'],
    },

    # If there are data files included in your packages that need to be
    # installed, specify them here.  If using Python 2.6 or less, then these
    # have to be included in MANIFEST.in as well.
    # package_data={
    #     'package_name': ['package_data.dat'],
    # },

    # Although 'package_data' is the preferred approach, in some case you may
    # need to place data files outside of your packages. See:
    # http://docs.python.org/3.4/distutils/setupscript.html#installing-additional-files # noqa
    # In this case, 'data_file' will be installed into '<sys.prefix>/my_data'
    # data_files=[('my_data', ['data/data_file'])],

    # To provide executable scripts, use entry points in preference to the
    # "scripts" keyword. Entry points provide cross-platform support and allow
    # pip to create the appropriate form of executable for the target platform.
    entry_points={
         'console_scripts': [
             'BindingInteraction=BindingInteraction.frontdesk:main',
         ],
     },
    #scripts=[
    #    'scripts/ps.sh',
    #    'scripts/ls'
    #],
)
