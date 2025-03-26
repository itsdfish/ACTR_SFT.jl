(define-model cross-modality-serial-and

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
            phase       respond
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
            phase       respond
        +aural-location>)

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
            phase       check-auditory
        +visual>
            cmd         move-attention
            screen-pos  =visual-location)

    (p start-auditory
        =goal>
            ISA         goal
            phase       find-stimulus
        =aural-location>
        ?visual>
            state       free
        ?aural-location>
            state       free
    ==>
        =goal>
            ISA         goal 
            phase       check-visual
        +aural>
            event   =aural-location)

    (p continue-to-aural
        =goal>
            ISA         goal
            phase       check-auditory
        =visual>
        ?aural-location>
            - state     error
        ?aural>
            state       free
            buffer      empty
    ==>
        =goal>
            ISA         goal 
            phase       respond
        =visual>
        +aural-location>)

    (p attend-aural
        =goal>
            ISA         goal
            phase       respond
        =visual>
        =aural-location>
        ?aural>
            state       free
            buffer      empty
    ==>
        =goal>
            ISA         goal 
            phase       respond; check-auditory
        =visual>
        +aural>
            event   =aural-location)

    (p continue-to-visual
        =goal>
            ISA         goal
            phase       check-visual
        =aural>
        ?visual-location>
            - state     error
        ?visual>
            buffer      empty
            state       free
    ==>
        =goal>
            ISA         goal 
            phase       respond
        =aural>
        +visual-location>)

    (p attend-visual
        =goal>
            ISA         goal
            phase       respond
        =aural>
        =visual-location>
        ?visual>
            state       free
            buffer      empty
    ==>
        =goal>
            ISA         goal 
            phase       respond; check-auditory
        =aural>
        +visual>
            cmd         move-attention
            screen-pos  =visual-location)

    (p respond-absent-visual
        =goal>
            ISA         goal
            phase       respond
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

    (p respond-absent-aural
        =goal>
            ISA         goal
            phase       respond
        ?aural-location>
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
