#|
Run instructions:
Launch ACT-R/run-act-r.bat
run the following in the terminal: 
(load "../simulations/lisp_models/intra_modality_serial_or/run_intra_modality_serial_or_model.lisp")
(load "../../../../quicklisp/setup.lisp")
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                        load model
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(defvar *response*)
(defvar *response-time*)
; load model and task files
(load "../simulations/lisp_models/intra_modality_serial_or/intra_modality_serial_or_model.lisp")
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
(setf n-sim 10000)
(setf seed 254)

(setf data (run-double-factorial-experiment
                'present-stimuli-intra-modality
                visual-stimuli 
                visual-stimuli
                parms 
                n-sim
                :seed seed))
                
; add column headers to csv
(push (list "seed" "visual1" "visual2" "choice" "rt") data)
(write-to-file-as-row data "../simulation_output/simulated_rts/intra_modality_serial_or_model.csv")