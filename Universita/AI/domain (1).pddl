(:(define (domain domainName)

    (:requirements
        :strips
    )
    

    (:predicates
        (agent ?x)(adj ?x ?y)(movable ?x)(at ?x ?y)
    )

    #non mettere mai negative precondition!!!! verrai penalizzato
    (:action move
        :parameters (?a ?from ?to)
        :precondition (and (agent ?a)(adj ?from ?to)(movable ?to)(at ?a ?from))
        :effect (and (at ?a ?to)(not(at ?a ?from)))
    )
    (:action divide
        :parameters (?a ?g ?from ?to)
        :precondition (and (agent ?a) (group ?g)(adj ?from ?to)
                        (at ?a ?from) (at ?g ?from) (movable ?to)  )
        :effect (and (not(at ?g ?from)) (safe ?from) ( not(movable ?to)) ( not(movable ?from)))
    
    )
))


( define (problem agent-problem)
         (:domain agent-domain)
         
         (:objects A g1 g2
         A_0_0 A_0_1 A_0_2 A_1_0 A_1_1 A_1_2 A_2_0 A_2_1 A_2_2
         B_0_0 A_0_1 B_0_2 A_1_0 B_1_1 A_1_2 B_2_0 B_2_1 B_2_2
         )
         
         (:init 
            (agent A)(group g1)(group g2)
            (at A A_1_2)(at g2 A_1_1)(at g1 B_0_2)
            (movable A_1_1)(movable A_1_2)
            (movable A_2_0)(movable A_2_1)(movable A_2_2)
            (movable B_0_0)(movable B_0_2)
            (movable B_1_0)(movable B_1_1)(movable B_1_2)
            (movable B_2_0)(movable B_2_1)
            (adj A_0_0 A_0_1)(adj A_0_0 A_1_0)(adj A_0_0 B_0_0)
            (adj A_0_1 A_0_0)(adj A_0_1 A_1_1)(adj A_0_1 A_0_2)
            (adj A_0_2 A_0_1)(adj A_0_2 A_1_2)
            (adj A_1_1 A_1_0)(adj A_1_1 A_0_1)(adj A_1_1 A_1_2)(adj A_1_1 A_1_2)
            (adj A_1_2 A_1_1)(adj A_1_2 A_0_2)(adj A_1_2 A_2_2)
            (adj A_2_0 A_1_0)(adj A_2_0 A_2_1)
            (adj A_2_1 A_2_0)(adj A_2_1 A_1_1)(adj A_2_1 A_2_2)
            (adj A_2_2 A_2_1)(adj A_2_2 A_1_2)
            (adj B_0_0 B_0_1)(adj B_0_0 B_1_0)(adj B_0_0 B_0_0)
            (adj B_0_1 B_0_0)(adj B_0_1 B_1_1)(adj B_0_1 B_0_2)
            (adj B_0_2 B_0_1)(adj B_0_2 B_1_2)
            (adj B_1_1 B_1_0)(adj B_1_1 B_0_1)(adj B_1_1 B_1_2)(adj B_1_1 B_1_2)
            (adj B_1_2 B_1_1)(adj B_1_2 B_0_2)(adj B_1_2 B_2_2)
            (adj B_2_0 B_1_0)(adj B_2_0 B_2_1)
            (adj B_2_1 B_2_0)(adj B_2_1 B_1_1)(adj B_2_1 B_2_2)
            (adj B_2_2 B_2_1)(adj B_2_2 B_1_2)
            (safe A_0_0)(safe A_0_1)(safe A_0_2)
            (safe A_1_0)(safe A_1_2)
            (safe A_2_0)(safe A_2_1)(safe A_2_2)
            (safe B_0_0)(safe B_0_1)(safe B_0_2)
            (safe B_1_0)(safe B_1_1)(safe B_1_2)
            (safe B_2_1)(safe B_2_2)
            
         
         )
         (:goal (and(safe B_2_0)(safe A_1_1)))



)