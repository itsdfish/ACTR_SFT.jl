(define-model cross-modality-serial-or

    (sgp :esc t)

    (chunk-type goal phase)

    (add-dm
        (first-goal ISA goal phase find-stimulus))

    (goal-focus first-goal)

    (p start-no-stimuli-visual
        =goal>
            ISA         goal
            phase       find-stimulus
        ?aural-location>
            buffer      empty 
        ?visual-location>
            buffer      empty 
        ?aural>
            state       free
        ?visual>
            state       free
    ==>
        =goal>
            ISA         goal 
            phase       check-visual
        +visual-location>)

    (p start-no-stimuli-aural
        =goal>
            ISA         goal
            phase       find-stimulus
        ?aural-location>
            buffer      empty 
        ?visual-location>
            buffer      empty 
        ?aural>
            state       free
        ?visual>
            state       free
    ==>
        =goal>
            ISA         goal 
            phase       check-aural
        +aural-location>)

    (p check-visual-continue
        =goal>
            ISA         goal
            phase       check-visual
        ?aural-location>
            - state     error 
        ?visual-location>
            state       error 
    ==>
        =goal>
            ISA         goal 
            phase       respond
        +aural-location>)

    (p check-aural-continue
        =goal>
            ISA         goal
            phase       check-aural
        ?aural-location>
            state       error 
        ?visual-location>
            - state       error 
    ==>
        =goal>
            ISA         goal 
            phase       respond
        +visual-location>)
        
    (p start-visual
        =goal>
            ISA         goal
            phase       find-stimulus
        =visual-location>
        ?aural>
            state       free
        ?visual>
            state       free
    ==>
        =goal>
            ISA         goal 
            phase       respond
        +visual>
            cmd         move-attention
            screen-pos  =visual-location)

    (p start-auditory
        =goal>
            ISA         goal
            phase       find-stimulus
        ?visual>
            state       free
        ?aural>
            state       free
        =aural-location>
    ==>
        =goal>
            ISA         goal 
            phase       respond
        +aural>
            event   =aural-location)

    (p respond-absent
        =goal>
            ISA         goal
            phase       respond
        ?aural-location>
            state       error 
        ?visual-location>
            state       error 
        ?aural> 
            buffer      empty
            state       free
        ?visual>
            buffer      empty
            state       free
    ==>
        =goal>
            ISA         goal 
            phase       stop
        +manual>
            cmd         press-key
            key         "f")

    (p respond-present-visual
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

    (p respond-present-auditory
        =goal>
            ISA         goal
            phase       respond
        =aural>
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
