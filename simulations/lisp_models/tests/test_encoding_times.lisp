#|
Run instructions:
Launch ACT-R/run-act-r.bat
run the following in the terminal: 
(load "../simulations/lisp_models/tests/test_encoding_times.lisp")
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               set up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "../simulations/lisp_models/tests/test_utilities.lisp")
(setf task-path "../simulations/lisp_models/common_task_functions.lisp")
(setf model-path "../simulations/lisp_models/cross_modality_parallel_and/cross_modality_parallel_and_model.lisp")

(setf num-tests-passed 0)
(setf num-tests-failed 0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               test 1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load task-path)
(setf test-name "compute-auditory-encoding-time")
(setf time (compute-auditory-encoding-time 2))
(setf true-time 0.285)
(if (equal true-time time) 
    (let  () (print-test-result test-name 1 t)
    (incf num-tests-passed))
    (let  () (print-test-result test-name 1 nil)
    (incf num-tests-failed)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               test 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load task-path)
(setf test-name "compute-auditory-encoding-time")
(setf time (compute-auditory-encoding-time 0))
(setf true-time 0.265)
(if (equal true-time time) 
    (let  () (print-test-result test-name 2 t)
    (incf num-tests-passed))
    (let  () (print-test-result test-name 2 nil)
    (incf num-tests-failed)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               test 3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load task-path)
(setf test-name "compute-auditory-encoding-time")
(setf time (compute-auditory-encoding-time 1))
(setf true-time 0.305)
(if (equal true-time time) 
    (let  () (print-test-result test-name 3 t)
    (incf num-tests-passed))
    (let  () (print-test-result test-name 3 nil)
    (incf num-tests-failed)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               test 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(defvar *response*)
(defvar *response-time*)
(load task-path)
(load model-path)

(setf parms (list :v nil
    :trace-detail 'low
    :show-focus t 
    :tone-detect-delay 0.0
    :visual-encoding-hook 'encode-visual-stimulus
    :egs 1
))


(setf rt1 (run-trial 'present-stimuli-cross-modality "L" nil parms :seed 1 :track-history t))
(setf module-data1 (process-history-data "module-demand-times"))
(setf true-module-data "[[\"VISUAL\",[[0.05,0.135]]],[\"PRODUCTION\",[[0.0,0.05],[0.135,0.185]]],[\"MANUAL\",[[0.185,0.485]]],[\"AURAL\",null]]")

(if (equal true-module-data module-data1) 
    (let  () (print-test-result test-name 1 t)
    (incf num-tests-passed))
    (let  () (print-test-result test-name 1 nil)
    (incf num-tests-failed)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               test 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(defvar *response*)
(defvar *response-time*)
(load task-path)
(load model-path)

(setf parms (list :v nil
    :trace-detail 'low
    :show-focus t 
    :tone-detect-delay 0.0
    :visual-encoding-hook 'encode-visual-stimulus
    :egs 1
))


(setf rt1 (run-trial 'present-stimuli-cross-modality "red" nil parms :seed 1 :track-history t))
(setf module-data1 (process-history-data "module-demand-times"))
(setf true-module-data "[[\"VISUAL\",[[0.05,0.115]]],[\"PRODUCTION\",[[0.0,0.05],[0.115,0.165]]],[\"MANUAL\",[[0.165,0.465]]],[\"AURAL\",null]]")

(if (equal true-module-data module-data1) 
    (let  () (print-test-result test-name 2 t)
    (incf num-tests-passed))
    (let  () (print-test-result test-name 2 nil)
    (incf num-tests-failed)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               test 5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(defvar *response*)
(defvar *response-time*)
(load task-path)
(load model-path)

(setf parms (list :v nil
    :trace-detail 'low
    :show-focus t 
    :tone-detect-delay 0.0
    :visual-encoding-hook 'encode-visual-stimulus
    :egs 1
))


(setf rt1 (run-trial 'present-stimuli-cross-modality "black" nil parms :seed 1 :track-history t))
(setf module-data1 (process-history-data "module-demand-times"))
(setf true-module-data "[[\"VISUAL\",[[0.05,0.155]]],[\"PRODUCTION\",[[0.0,0.05],[0.155,0.205]]],[\"MANUAL\",[[0.205,0.505]]],[\"AURAL\",null]]")

(if (equal true-module-data module-data1) 
    (let  () (print-test-result test-name 3 t)
    (incf num-tests-passed))
    (let  () (print-test-result test-name 3 nil)
    (incf num-tests-failed)))

(print-suite-summary model-name num-tests-passed num-tests-failed)
