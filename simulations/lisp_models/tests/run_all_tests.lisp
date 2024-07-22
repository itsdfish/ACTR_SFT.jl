#|
Run instructions:
Launch ACT-R/run-act-r.bat
run the following in the terminal: 
(load "../simulations/lisp_models/tests/run_all_tests")
|#
(setf total-passed-tests 0)
(setf total-failed-tests 0)

(load "../simulations/lisp_models/tests/test_intra_modality_serial_and.lisp")
(incf total-passed-tests num-tests-passed)
(incf total-failed-tests num-tests-failed)

(load "../simulations/lisp_models/tests/test_intra_modality_serial_or.lisp")
(incf total-passed-tests num-tests-passed)
(incf total-failed-tests num-tests-failed)

(load "../simulations/lisp_models/tests/test_cross_modality_serial_and.lisp")
(incf total-passed-tests num-tests-passed)
(incf total-failed-tests num-tests-failed)

(load "../simulations/lisp_models/tests/test_cross_modality_serial_or.lisp")
(incf total-passed-tests num-tests-passed)
(incf total-failed-tests num-tests-failed)

(load "../simulations/lisp_models/tests/test_cross_modality_parallel_or.lisp")
(incf total-passed-tests num-tests-passed)
(incf total-failed-tests num-tests-failed)

(load "../simulations/lisp_models/tests/test_cross_modality_parallel_and.lisp")
(incf total-passed-tests num-tests-passed)
(incf total-failed-tests num-tests-failed)

(load "../simulations/lisp_models/tests/test_encoding_times.lisp")
(incf total-passed-tests num-tests-passed)
(incf total-failed-tests num-tests-failed)

(print-suite-summary "all " total-passed-tests total-failed-tests)
