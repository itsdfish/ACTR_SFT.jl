#|
Run instructions:
Launch ACT-R/run-act-r.bat
run the following in the terminal: 
(load "../simulations/lisp_models/cross_modality_parallel_or/run_cross_modality_parallel_or_model.lisp")
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                        load model
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(defvar *response*)
(defvar *response-time*)
; load model and task files
(load "../simulations/lisp_models/cross_modality_parallel_or/cross_modality_parallel_or_model.lisp")
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

(setf visual-stimuli (list nil "black" "red"))
(setf auditory-stimuli (list nil 0 1))
(setf n-sim 2000)
(setf seed 74)

(setf data (run-double-factorial-experiment
                'present-stimuli-cross-modality 
                visual-stimuli 
                auditory-stimuli 
                parms 
                n-sim
                :seed seed))
                
; add column headers to csv
(push (list "seed" "visual" "auditory" "choice" "rt") data)
(write-to-file-as-row data "../simulation_output/simulated_rts/cross_modality_parallel_or_model.csv")