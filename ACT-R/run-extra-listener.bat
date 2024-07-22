start "ACT-R remote" apps/act-r.exe  -n -e "(make-package :remote :use (list \"COMMON-LISP\" \"CCL\"))" -e "(in-package :remote)" -l "tutorial/lisp/remote-actr-connection.lisp" -l "set-logical.lisp" -e "(exclude-model-trace)" -e "(finish-output *error-output*)"

