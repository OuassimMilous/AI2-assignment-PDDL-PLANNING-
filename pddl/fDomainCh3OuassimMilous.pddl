(define (domain domain1)

    (:requirements :strips :negative-preconditions :disjunctive-preconditions )

    (:predicates
    
        (AGENT ?a)
        (LOCATION ?l)
        (COFFEE ?cof)
        (SUGAR ?sug)
        (DRAWER ?d)
        (JAR ?j)
        (TAPWATER ?t)
        (GRINDER ?g)
        (MOKA ?m)
        (SPOON ?s)
        (CUP ?cu)
        (STOVE ?st)

        (at-location ?o ?l)  ;; location of objects

        (in-drawer ?i ?d)  ;;wether or not somethin is in a drawer
        (in-jar ?j ?i)  ;;wether or not somethin is in a jar


        (is-open ?o)  ;; is it open or closed (drawers and such)
        (is-full ?o)  ;; is it full?
        (is-grinded ?o)  ;; if the coffee is grinded
        (is-fullcoffee ?o)  ;; if the moka is full of coffee
        (is-on ?o)  ;; if something is on
        (is-leveled ?co)  ;; wether the coffee is well leveled
        (is-screwed ?m)  ;; wether the moka is screwed or split apart
        (is-heat ?st)    ;; is the heat on stove heat is on
        (is-picking ?a ?i)   ;; what is the agent holding
        (is-free ?a )  ;; is the agent free to cary something
        (is-top ?m)  ;; the top of the moka is on it or not
        (is-ready ?m) ;; final coffee is ready
    )

    (:action move
        :parameters (?a ?from ?to)
        :precondition (and (AGENT ?a) (LOCATION ?from) (LOCATION ?to) 
                           (at-location ?a ?from))
        :effect (and (not (at-location ?a ?from)) (at-location ?a ?to))
    )

    (:action pickUp
        :parameters (?a ?i ?d ?l)
        :precondition (and (AGENT ?a) 
                           (in-drawer ?i ?d)
                           (is-open ?d)
                           (at-location ?a ?l) (at-location ?d ?l)
                           (is-free ?a))
        :effect (and (is-picking ?a ?i) 
                     (not (at-location ?i ?l)) 
                     (not (is-free ?a))
                     (not (in-drawer ?i ?d))
                     )
    )
    
    (:action putDown
        :parameters (?a ?i ?l)
        :precondition (and (AGENT ?a) 
                           (at-location ?a ?l) 
                           (is-picking ?a ?i))
        :effect (and (not (is-picking ?a ?i)) 
                     (at-location ?i ?l) 
                     (is-free ?a))
    )
    
    (:action open
        :parameters (?a ?o ?l)
        :precondition (and (AGENT ?a) (or (TAPWATER ?o) (DRAWER ?o) (JAR ?o) (JAR ?o) ) (LOCATION ?l) 
                        (at-location ?a ?l) (at-location ?o ?l))
        :effect (and (is-open ?o))
    )
    

    (:action close
        :parameters (?a ?o ?l)
        :precondition (and (AGENT ?a) (or (TAPWATER ?o) (DRAWER ?o) (JAR ?o) (JAR ?o)) (LOCATION ?l)
                         (at-location ?a ?l) (at-location ?o ?l) (is-open ?o))
        :effect (not (is-open ?o))
    )

    (:action pourIntoGrinder
        :parameters (?a ?cof ?jar ?g ?l)
        :precondition (and (AGENT ?a) (JAR ?jar) (GRINDER ?g) (LOCATION ?l) (COFFEE ?cof)
                             (at-location ?a ?l) (at-location ?g ?l)  (at-location ?jar ?l)
                             (is-open ?jar)
                             (in-jar ?cof ?jar))
        :effect (and (is-full ?g) (not (in-jar ?cof ?jar)))
    )
    
    (:action turnOnGrinder
        :parameters (?a ?g ?l)
        :precondition (and (AGENT ?a)  (GRINDER ?g) (LOCATION ?l) 
                        (at-location ?a ?l) (at-location ?g ?l) (is-full ?g))
        :effect (and (is-on ?g) )
    )

    (:action turnOffGrinder
        :parameters (?a ?g ?l)
        :precondition (and (AGENT ?a) (GRINDER ?g)
                         (LOCATION ?l) (at-location ?a ?l) (at-location ?g ?l) 
                         (is-on ?g) (is-full ?g)) 
        :effect (and  (is-grinded ?g) (not (is-on ?g)) (not (is-full ?g)))
    )

    (:action screwMoka
        :parameters (?a ?m ?l)
        :precondition (and (AGENT ?a) (MOKA ?m) (LOCATION ?l) 
                        (at-location ?a ?l) (at-location ?m ?l) (is-top ?m) )
        :effect (is-screwed ?m)
    )

    (:action unscrewMoka
        :parameters (?a ?m ?l)
        :precondition (and (AGENT ?a) (MOKA ?m) (LOCATION ?l) 
                         (at-location ?a ?l) (at-location ?m ?l) (is-screwed ?m))
        :effect (not (is-screwed ?m))
    )

    (:action fillMoka
        :parameters (?a ?m ?tw ?l)
        :precondition (and (AGENT ?a) (MOKA ?m) (TAPWATER ?tw) (LOCATION ?l) 
                            (is-open ?tw)
                            (at-location ?a ?l) (at-location ?m ?l) (at-location ?tw ?l))
        :effect (is-full ?m)
    )

    (:action extractCoffee
        :parameters (?a ?sp ?g ?l)
        :precondition (and (AGENT ?a) (GRINDER ?g) (LOCATION ?l) (SPOON ?sp)
                         (at-location ?a ?l) (at-location ?g ?l) (at-location ?sp ?l) 
                         (is-grinded ?g) (not (is-full ?sp)))
        :effect (and(is-full ?sp) (not (is-grinded ?g)))
    )

    (:action fillfilter
        :parameters (?a ?sp ?m ?l)
        :precondition (and (AGENT ?a) (MOKA ?m) (SPOON ?sp) (LOCATION ?l) 
                            (at-location ?a ?l) (at-location ?m ?l) (at-location ?sp ?l))
        :effect (is-fullcoffee ?m)
    )
    (:action levelWithFilter
        :parameters (?a ?m ?l)
        :precondition (and (AGENT ?a) (MOKA ?m) (LOCATION ?l) 
                            (at-location ?a ?l) (at-location ?m ?l) (not(is-screwed ?m))
                            (is-full ?m) ( is-fullcoffee ?m) (not (is-leveled ?m)))
        :effect (is-leveled ?m)
    )

    (:action turnOnStove
        :parameters (?a ?st ?m ?l)
        :precondition (and (AGENT ?a) (MOKA ?m) (STOVE ?st) (LOCATION ?l) 
                            (at-location ?a ?l) (at-location ?m ?l) (at-location ?st ?l) (is-screwed ?m)(is-leveled ?m))
        :effect (is-heat ?st) 
    )

    (:action turnOffStove
        :parameters (?a ?st ?m ?l)
        :precondition (and (AGENT ?a) (STOVE ?st) (MOKA ?m) (LOCATION ?l) 
                            (at-location ?a ?l) (at-location ?m ?l) (at-location ?st ?l) (is-heat ?st) )
        :effect (and (not (is-heat ?st)) (is-ready ?m))
    )


    (:action covertopMoka
        :parameters (?a ?m ?l)
        :precondition (and (AGENT ?a) (MOKA ?m) (LOCATION ?l) 
                        (at-location ?a ?l) (at-location ?m ?l))
        :effect (is-top ?m)
    )

    (:action uncovertopMoka
        :parameters (?a ?m ?l)
        :precondition (and (AGENT ?a) (MOKA ?m) (LOCATION ?l) 
                         (at-location ?a ?l) (at-location ?m ?l) (is-top ?m))
        :effect (not (is-top ?m))
    )

    (:action pourCoffeeInCup
        :parameters (?a ?m ?cu ?coffee ?jarsugar ?sug ?l)
        :precondition (and (AGENT ?a) (MOKA ?m) (CUP ?cu) (JAR ?jarsugar) (SUGAR ?sug)  (LOCATION ?l) 
                            (at-location ?a ?l) (at-location ?cu ?l) (at-location ?m ?l) (at-location ?jarsugar ?l)
                            (is-open ?jarsugar) (in-jar ?sug ?jarsugar)
                            (is-ready ?m) (not (is-top ?m)))
        :effect  (and (is-full ?cu) (not (in-jar ?sug ?jarsugar)))
    )
)