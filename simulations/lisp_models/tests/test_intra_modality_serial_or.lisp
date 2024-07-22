#|
Run instructions:
Launch ACT-R/run-act-r.bat
run the following in the terminal: 
(load "../simulations/lisp_models/tests/test_intra_modality_serial_or.lisp")
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                               set up
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "../simulations/lisp_models/tests/test_utilities.lisp")
(setf model-path "../simulations/lisp_models/intra_modality_serial_or/intra_modality_serial_or_model.lisp")
(setf task-path "../simulations/lisp_models/common_task_functions.lisp")
(setf model-name "intra-modality serial or")

(defvar *response*)
(defvar *response-time*)
(setf parms (list :v nil
    :trace-detail 'low
    :show-focus t 
    :tone-detect-delay 0.0
))
(setf num-tests-passed 0)
(setf num-tests-failed 0)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                 run tests 1 and 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(setf *response* 0)
(setf *response-time* 0)
; load model and task files
(load model-path)
(load task-path)

(print (format nil "running ~A" model-name))
(setf true-module-times1 "[[\"VISUAL\",[[0.05,0.135]]],[\"PRODUCTION\",[[0.0,0.05],[0.135,0.185]]],[\"MANUAL\",[[0.185,0.485]]],[\"AURAL\",null]]")
(setf rt1 (run-trial 'present-stimuli-intra-modality "L" "L" parms :track-history t))
(setf module-data1 (process-history-data "module-demand-times"))
; test 1
(if (string= module-data1 true-module-times1) 
    (let  () (print-test-result model-name 1 t)
    (incf num-tests-passed))
    (let  () (print-test-result model-name 1 nil)
    (incf num-tests-failed)))
; test 2
(setf true-rt1 '(1 "L" "L" "j" 0.395))
(if (equal true-rt1 rt1) 
    (let  () (print-test-result model-name 2 t)
    (incf num-tests-passed))
    (let  () (print-test-result model-name 2 nil)
    (incf num-tests-failed)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                 run tests 3 and 4
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(setf *response* 0)
(setf *response-time* 0)
; load model and task files
(load model-path)
(load task-path)

(print (format nil "running ~A" model-name))
(setf true-module-times2 "[[\"VISUAL\",[[0.05,0.135]]],[\"PRODUCTION\",[[0.0,0.05],[0.135,0.185]]],[\"MANUAL\",[[0.185,0.485]]],[\"AURAL\",null]]")
(setf rt2 (run-trial 'present-stimuli-intra-modality "L" nil parms :track-history t))
(setf module-data2 (process-history-data "module-demand-times"))
; test 3
(if (string= module-data2 true-module-times2) 
    (let  () (print-test-result model-name 3 t)
    (incf num-tests-passed))
    (let  () (print-test-result model-name 3 nil)
    (incf num-tests-failed)))
; test 4
(setf true-rt2 '(1 "L" NIL "j" 0.395))
(if (equal true-rt2 rt2) 
    (let  () (print-test-result model-name 4 t)
    (incf num-tests-passed))
    (let  () (print-test-result model-name 4 nil)
    (incf num-tests-failed)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                 run tests 5 and 6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(setf *response* 0)
(setf *response-time* 0)
; load model and task files
(load model-path)
(load task-path)

(print (format nil "running ~A" model-name))
(setf true-module-times3 "[[\"VISUAL\",null],[\"PRODUCTION\",[[0.0,0.05],[0.05,0.1],[0.1,0.15]]],[\"MANUAL\",[[0.15,0.45]]],[\"AURAL\",null]]")
(setf rt3 (run-trial 'present-stimuli-intra-modality nil nil parms :track-history t))
(setf module-data3 (process-history-data "module-demand-times"))
; test 5
(if (string= module-data3 true-module-times3) 
    (let  () (print-test-result model-name 5 t)
    (incf num-tests-passed))
    (let  () (print-test-result model-name 5 nil)
    (incf num-tests-failed)))
; test 6
(setf true-rt3 '(1 NIL NIL "f" 0.36))
(if (equal true-rt3 rt3) 
    (let  () (print-test-result model-name 6 t)
    (incf num-tests-passed))
    (let  () (print-test-result model-name 6 nil)
    (incf num-tests-failed)))

(print-suite-summary model-name num-tests-passed num-tests-failed)

