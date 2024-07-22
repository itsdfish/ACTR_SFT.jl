(define-model cross-modality-parallel-or

    (sgp :esc t)

    (chunk-type goal phase)

    (add-dm
        (first-goal ISA goal phase find-stimulus))

    (goal-focus first-goal)

    (p start-no-stimuli
        =goal>
            ISA         goal
            phase       find-stimulus
        ?visual-location>
            buffer      empty
        ?aural-location>
            buffer      empty
    ==>
        =goal>
            ISA         goal 
            phase       respond
        ; aural location command does not seem to work
        ; the results are the same without it
        ; +aural-location>
        +visual-location>)

    (p start-visual
        =goal>
            ISA         goal
            phase       find-stimulus
        =visual-location>
        ?visual>
            state       free
        ?aural-location>
            buffer      empty
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
        ?aural>
            state       free
        ?visual-location>
            buffer      empty
        =aural-location>
    ==>
        =goal>
            ISA         goal 
            phase       respond
        +aural>
            event   =aural-location)

    (p start-visual-auditory
        =goal>
            ISA         goal
            phase       find-stimulus
        ?aural>
            state       free
        ?visual>
            state       free
        =visual-location>
        =aural-location>
    ==>
        =goal>
            ISA         goal 
            phase       respond
        +visual>
            cmd         move-attention
            screen-pos  =visual-location
        +aural>
            event   =aural-location)

    (p respond-absent-no-stimuli
        =goal>
            ISA         goal
            phase       respond
        ?visual>
            buffer      empty
            state       free
        ?visual-location>
            state       error
        ?aural>
            buffer      empty
            state       free
        ?manual>
            state      free
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
