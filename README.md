# PPP
PPP stands for python preprocessor
It is a .sh script that allows to use gcc as a preprocessor for python.

##Configuration Eclipse
1. In Preferences in PyDev>>Interpreters>>Python Interpreter ass a new Python interpreter.
  1. Click on "New ..."
  2. Select "Browse for python/pypy exe"
  3. In the following screen browse for ppp.sh
  4. Select the line with name ppp
  5. In tab Environment add a variable "PROJRCT_LOC" with value "${project_loc}"
2. In yout projects Properties:
  1. In "PyDev - Interpreters" in field Interpreter select "ppp"
3. In the root directory create the following directories:
  1. include
  2.  src
  3. py

In the include folder goes all macro files.
In the src folder goes all your source code
In the py folder goes all the source code processed by gcc.

## Drawbacks
Usage of ppp coemes with several drawbacks:
1. In your python source code you have to use ## for comments.
   The useage of # for comments leads to gcc to interpret is as a preprocessor directive.
2. Breakpoints are not working anymore. Because you set break points in src folder, but the
   interpreter runs code from py folder.
3. Clicking on a py file in an error output opens the file in the py folder.
   You have to switch to the coresbonding file in the src folder.
4. Line number in error messages are not correct anymore, because gcc introduces some 
   lines at the top to files in the py flder.