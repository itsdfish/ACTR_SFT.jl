#|
Run instructions:
Launch ACT-R/run-act-r.bat
run the following in the terminal: 
(load "../simulations/lisp_models/cross_modality_parallel_and/generate_gantt_data_parallel_and.lisp")
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                        load model
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(clear-all)
; load model and task files
(load "../simulations/lisp_models/cross_modality_parallel_and/cross_modality_parallel_and_model.lisp")
(load "../simulations/lisp_models/common_task_functions.lisp")

(setf parms (list :v t
    :trace-detail 'low
    :show-focus t 
    :tone-detect-delay 0.0
))

(setf rt (run-trial 'present-stimuli-cross-modality "L" 1000 parms :track-history t))
(setf module-data (process-history-data "module-demand-times"))
(write-string-to-file module-data "../simulation_output/gantt_plot_data/cross_modal_parallel_gantt_data.json")
