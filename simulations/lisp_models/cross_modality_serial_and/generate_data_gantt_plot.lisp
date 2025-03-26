#|
Run instructions:
Launch ACT-R/run-act-r.bat
run the following in the terminal: 
(load "../simulations/lisp_models/cross_modality_serial_and/generate_data_gantt_plot.lisp")
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                        load model
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
(defvar *response*)
(defvar *response-time*)
; load model and task files
(load "../simulations/lisp_models/cross_modality_serial_and/cross_modality_serial_and_model.lisp")
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

(setf rt (run-trial 'present-stimuli-cross-modality "L" "L" parms :track-history t))
(setf module-data (process-history-data "module-demand-times"))
(write-string-to-file module-data "../simulation_output/gantt_plot_data/cross_modal_serial_and_gantt_data.json")
