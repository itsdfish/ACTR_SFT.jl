;; (defpackage :sft-actr
;;   (:use :cl))

;; (in-package :sft-actr)

;; (defun my-fun () (print "my-fun"))

(defun present-stimuli-intra-modality (window color1 color2)
  "         
            (present-stimuli-intra-modality window color1 color2)
  
  Presents stimuli in the intra-modality double factorial experiment. Black text results in
  slower encoding whereas red text results in faster visual encoding. 

  - window: experiment window
  - color1: color of top stimulus
  - color2: color of bottom stimulus
  "
  (if (eq color1 nil) () 
      (add-text-to-exp-window window "T" :x 150 :y 75 :color color1))
  (if (eq color2 nil) () 
      (add-text-to-exp-window window "B" :x 150 :y 225 :color color2)))

(defun present-stimuli-cross-modality (window color sound)
  "         
            (present-stimuli-cross-modality window color sound)
  
  Presents a text and sound stimulus in the cross-modality double factorial experiment. Black text results in
  slower encoding whereas red text results in faster visual encoding. An auditory stimulus of 0 
  results in faster auditory encoding relative to an auditory stimulus of value 1.

  - window: experiment window
  - color: color of top stimulus
  - sound: the sound value (0,1)
  "
  (if (eq color nil) () 
      (add-text-to-exp-window window "T" :x 150 :y 75 :color color))
  (if (eq sound nil) () 
        (let ((attend-time))
          (setf attend-time (compute-auditory-encoding-time sound))
          ; 'content' duration delay recode {onset {'location' {'kind' {time-in-ms {'feature'*]}}}}}
          (new-other-sound sound 0.1 0.0 attend-time))))

(defun run-trial (func stimulus1 stimulus2 parms &key (visible t) (seed 1) (track-history nil))
  "         
            (run-trial func stimulus1 stimulus2 parms :visible t :seed 1 :track-history nil)
  
  Simulates a trial of a given condition in a double factorial experiment.

  - func: a function which simulates a specific double factorial experiment
  - stimulus1: a visual or auditory function depending on the experiment
  - stimulus2: a visual or auditory function depending on the experiment
  - parms: a list of keyword parameters and parameter values
  - :visible t: displays experiment in window if true 
  - :seed 1: an RNG seed for a given simulated trial 
  - :track-history nil: tracks module history if true
  "
  (let ((window nil))
      (reset)
      (sgp-fct parms)
      (set-seed seed)
      (add-act-r-command "model-response" 'respond-to-key-press "Double Factorial Experiment")
      (monitor-act-r-command "output-key" "model-response")
      (if (eq track-history t) 
        (record-history "buffer-trace" "visual" "production" "manual" "aural"))
      (setf window (open-exp-window "Double Factorial Experiment" :visible visible))
      (install-device window)
      (clear-exp-window window)
      (funcall func window stimulus1 stimulus2)
      (run 10)
      (remove-act-r-command-monitor "output-key" "model-response")
      (remove-act-r-command "model-response")
      (list seed stimulus1 stimulus2 *response* (/ *response-time* 1000.0))))

(defun run-trials (func stimulus1 stimulus2 parms n-sim &key (visible nil) (seed 1) (track-history nil))
  "         
            (run-trials func stimulus1 stimulus2 parms n-sim :visible t :seed 1 :track-history nil)
  
  Simulates multiple trials of a given condition in a double factorial experiment.

  - func: a function which simulates a specific double factorial experiment
  - stimulus1: a visual or auditory function depending on the experiment
  - stimulus2: a visual or auditory function depending on the experiment
  - parms: a list of keyword parameters and parameter values
  - n-sims: the number of simulations to perform
  - :visible nil: displays experiment in window if true 
  - :seed 1: a starting RNG seed for a set of simulated trials 
  - :track-history nil: tracks module history if true
  "
  (let ((output (list)))
    (dotimes (i n-sim) 
      (push 
        (run-trial func stimulus1 stimulus2 parms :visible visible :seed seed :track-history track-history) output)
        (setf seed (+ seed 1)))
    output))

(defun run-double-factorial-experiment (func stimuli1 stimuli2 parms n-sim &key (visible nil) (seed 1) (track-history nil))
  "           (run-double-factorial-experiment func stimulus1 stimulus2 parms :visible nil :seed 1 :track-history nil)
  
  Simulates a complete double factorial experiment.

  - func: a function which simulates a specific double factorial experiment
  - stimulus1: a visual or auditory function depending on the experiment
  - stimulus2: a visual or auditory function depending on the experiment
  - parms: a list of keyword parameters and parameter values
  - n-sims: the number of simulations to perform per condition
  - :visible nil: displays experiment in window if true 
  - :seed 1: a starting RNG seed for the entire experiment 
  - :track-history nil: tracks module history if true
  "
  (let ((output (list)))
    (loop for s1 in stimuli1 
      do (loop for s2 in stimuli2
        do (setf output 
              (append 
                (run-trials func s1 s2 parms n-sim :visible visible :seed seed :track-history track-history) output))
                (setf seed (+ (nth 0 (first output)) 1))))
    (reverse output)))

(defun encode-visual-stimulus (a b chunk-name d)
  "           (encode-visual-stimulus a b chunk-name d)
  
  Selects a visual encoding latency based on text color. Black text results in
  slower encoding whereas red text results in faster visual encoding.

  - chunk-name: the name of the attended chunk. Used to identify color for salience.

  Other arguments are ignored
  "
  (declare (ignore a b d))
  (let ((attend-time .085) (color nil))
      (setf color (get-slot-value chunk-name))
      (case color ('black (setf attend-time .105))
          ('red (setf attend-time .065)))
      ; (print (list "color" color "attend-time" attend-time))
      attend-time))

(defun compute-auditory-encoding-time (stimulus)
  "           (compute-auditory-encoding-time stimulus)
  
  Selects an auditory encoding latency based sound value. A value of 1 results in
  slow encoding whereas a value of 0 results in fast encoding.

  - stimulus: auditory sound (0,1)
  "
  (let ((attend-time 0.285))
    (case stimulus 
      (0 (setf attend-time 0.265))
      (1 (setf attend-time .305)))
    attend-time))

(defun respond-to-key-press (model key)
  (declare (ignore model))
  (setf *response-time* (get-time))
  (setf *response* key))

(defun get-slot-value (chunk-name)
  (eval
    (read-from-string  
      (concatenate 'string "(chunk-slot-value " (string chunk-name) " color)"))))

(defun set-seed (seed)
  (eval
    (read-from-string  
      (concatenate 'string "(sgp :seed (" (write-to-string seed) " 0))"))))

(defun write-string-to-file (string outfile &key (action-if-exists :error))
   (check-type action-if-exists (member nil :error :new-version :rename :rename-and-delete 
                                        :overwrite :append :supersede))
   (with-open-file (outstream outfile :direction :output :if-exists action-if-exists)
     (write-sequence string outstream)))

(defun write-to-file-as-row (lst FileName)
  "         
          (write-to-file-as-row lst FileName)
  
Writes a list of lists to a CSV file where each sub-list is a row. 

  - lst: a list of lists
  - FileName: a path or file name to which the data will be saved
  "
  (with-open-file (file FileName
                        :direction :output
                        :if-exists :supersede
                        :if-does-not-exist :create)
    (loop for row in lst
      do (loop for n in row
           do (princ n file)
           (princ "," file))
           (fresh-line file))))