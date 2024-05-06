# PPP
PPP stands for python preprocessor
It is a .sh script that allows to use gcc as a preprocessor for python.

##Configuration Eclipse
1. In Preferences in PyDev>>Interpreters>>Python Interpreter ass a new Python interpreter.
a) Click on "New ..."
b) Select "Browse for python/pypy exe"
c) In the following screen browse for ppp.sh
d) Select the line with name ppp
e) In tab Environment add a variable "PROJRCT_LOC" with value "${project_loc}"
2. In yout projects Properties:
a) In "PyDev - Interpreters" in field Interpreter select "ppp"
3. In the root directory create the following directories:
a) include
b) src
c) py

In the include folder goes all macro files.
In the src folder goes all your source code
In the py folder goes all the source code processed by gcc.

## Drawbacks
Usage of ppp coemes with several drawbacks:
a) In your python source code you have to use ## for comments.
   The useage of # for comments leads to gcc to interpret is as a preprocessor directive.
b) Breakpoints are not working anymore. Because you set break points in src folder, but the
   interpreter runs code from py folder.
c) Clicking on a py file in an error output opens the file in the py folder.
   You have to switch to the coresbonding file in the src folder.
d) Line number in error messages are not correct anymore, because gcc introduces some 
   lines at the top to files in the py flder.