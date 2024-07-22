(define-model cross-modality-serial-and

    (sgp :esc t)

    (chunk-type goal phase)

    (add-dm
        (first-goal ISA goal phase find-stimulus))

    (goal-focus first-goal)

    (p find-stimulus-no-buffer-stuffing
        =goal>
            ISA         goal
            phase       find-stimulus
        ?visual-location>
            buffer      empty
            state       free
    ==>
        =goal>
            ISA         goal 
            phase       attend-next-stimulus
        +visual-location>
            ISA         visual-location)

     (p start
        =goal>
            ISA         goal
            phase       find-stimulus
        =visual-location>
        ?visual>
            state       free
    ==>
        =goal>
            ISA         goal 
            phase       find-next-stimulus
        +visual>
            cmd         move-attention
            screen-pos  =visual-location)

    (p find-next-stimulus 
        =goal>
            ISA         goal
            phase       find-next-stimulus
        =visual>
            value       =value
    ==>
        =goal>
            ISA         goal 
            phase       attend-next-stimulus
       +visual-location>
            ISA         visual-location
            :attended nil)

    (p attend-next-stimulus 
        =goal>
            ISA         goal
            phase       attend-next-stimulus
        =visual-location>
        ?visual>
            state      free
    ==>
        =goal>
            ISA         goal 
            phase       respond
        +visual>
            cmd         move-attention
            screen-pos  =visual-location)

    (p respond-absent
        =goal>
            ISA         goal
            phase       attend-next-stimulus
        ;; ?visual>
        ;;     buffer       empty 
        ?visual-location>
            state       error
        ?manual>
            state      free
    ==>
        =goal>
            ISA         goal 
            phase       stop
        +manual>
            cmd         press-key
            key         "f")

    (p respond-present
        =goal>
            ISA         goal
            phase       respond
        =visual>
        ?manual>
            state      free
    ==>
        =goal>
            ISA         goal 
            phase       stop
        +manual>
            cmd         press-key
            key         "j")
)
