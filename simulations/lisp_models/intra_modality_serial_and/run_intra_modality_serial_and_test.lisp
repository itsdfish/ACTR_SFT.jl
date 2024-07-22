#|
Run instructions:
Launch ACT-R/run-act-r.bat
run the following in the terminal: 
(load "../simulations/lisp_models/intra_modality_serial_and/run_intra_modality_serial_and_test.lisp")
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                        load model
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(defvar *response*)
(defvar *response-time*)
; load model and task files
(load "../simulations/lisp_models/intra_modality_serial_and/intra_modality_serial_and_model.lisp")
(load "../simulations/lisp_models/common_task_functions.lisp")

(setf parms (list :v t
    :trace-detail 'low
    :show-focus t 
    :tone-detect-delay 0.0
))

(setf rt (run-trial 'present-stimuli-intra-modality "L" "L" parms :track-history t))
(setf module-data (process-history-data "module-demand-times"))
