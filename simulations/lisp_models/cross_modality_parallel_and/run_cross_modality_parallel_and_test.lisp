#|
Run instructions:
Launch ACT-R/run-act-r.bat
run the following in the terminal: 
(load "../simulations/lisp_models/cross_modality_parallel_and/run_cross_modality_parallel_and_test.lisp")
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                        load model
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(defvar *response*)
(defvar *response-time*)
; load model and task files
(load "../simulations/lisp_models/cross_modality_parallel_and/cross_modality_parallel_and_model.lisp")
(load "../simulations/lisp_models/common_task_functions.lisp")

(setf parms 
    (list 
        :v nil 
        :show-focus nil 
        :egs 1 ; noise to randomly select start-visual and start-audio rules
        :tone-detect-delay 0.0
        :visual-encoding-hook 'encode-visual-stimulus
        :randomize-time t
        :vpft t
))

;(setf seed 874)

(setf parms (list :v t
    :trace-detail 'low
    :show-focus t 
    :tone-detect-delay 0.0
))

(setf rt (run-trial 'present-stimuli-cross-modality "L" 1 parms :track-history t))
(setf module-data (process-history-data "module-demand-times"))
