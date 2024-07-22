(defun print-suite-summary (model-name num-tests-passed num-tests-failed) 
    (print " ")
    (print (format nil "~A test" model-name))
    (print "------------------------------------")
    (print (list "tests passed " num-tests-passed))
    (print (list "tests failed " num-tests-failed))
    (print "------------------------------------"))

(defun print-test-result (model-name test-num passed)
    (let ((status))
    (if passed
        (setf status "passed")
        (setf status "failed "))
    (print (format nil "~A test ~D ~A" model-name test-num status))))