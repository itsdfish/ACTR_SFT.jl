
To run the ACT-R Standalone extract the "ACT-R" folder from the zip archive. 

Then to run the ACT-R software just run the run-act-r.bat batch file.  That
will open a command prompt window titled "ACT-R" and the ACT-R Environment
GUI in a window titled "Control Panel".

There are a few known issues which may cause problems when trying to run the 
Standalone version of ACT-R for Windows.

1) The application might not run if it is located in a directory which has 
non-ASCII characters in its path.  Thus, if you are using a machine with 
support for a language other than English you may need to make sure that the 
ACT-R files are extracted to a directory with a name containing only ASCII 
characters.

2) The pieces of the software communicate using a TCP/IP socket.  If you get a
warning about allowing the software to open a port you must allow that for the
software to run correctly.  

3) By default the software will use the localhost address for the ACT-R 
interface, but if you need to make external connections delete the 
force-local.lisp file from the patches directory before starting the software.


The "run-act-r-only.bat" batch file can be run to open only the ACT-R terminal
application without the Environment.

The "run-extra-listener.bat" batch file can be run to open another terminal 
running Lisp which connects to the running ACT-R.  That terminal provides
functions/macros to call the ACT-R commands which are described in the tutorial
and may be useful for inspecting or debugging a model.  By default that 
terminal will not display the ACT-R model trace but it does display the other
traces.  If the model trace is desired in that terminal, the function 
include-model-trace can be called to add it.  Any number of extra listeners may
be run at the same time.

The "run-html-environment.bat" batch file can be run to start an application
which allows one to use an alternate version of the ACT-R Environment that
is implemented in javascript and works from a browser (it can be run instead
of or in addition to the default Tcl/Tk based Environment).  After you start
the application you should then open a browser and open the act-r.html file
which is found in the ACT-R directory.  It will show two links.  One goes
to the Environment tools and the other opens a viewer for the experiment
windows created by the ACT-R AGI tools.

You can also run the standard ACT-R Environment from source code using Python 3
if there is a problem with the application or you prefer not to use it.  To
do so run the envstarter.py script in the ACT-R/environment directory using
either "python envstarter.py" or "python3 envstarter.py" depending on the
name of the application for Python 3 on your machine.

See the tutorial, reference manual, and environment manual for more details.

This distribution is built using Clozure Common Lisp (CCL) which is available
at <http://clozure.com/>.  Clozure Common Lisp is distributed under the Apache
License, and the license is included in the ccl_license folder in the docs 
folder.

If you have any problems, questions or comments please let me know.

Dan (db30@andrew.cmu.edu)

