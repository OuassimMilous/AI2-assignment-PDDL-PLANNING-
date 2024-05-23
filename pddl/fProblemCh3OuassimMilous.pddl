(define (problem problem1)
  (:domain domain1)
  (:objects 
    agent - AGENT
    storing workTable rest - LOCATION
    drawer1 drawer2 - DRAWER
    spoon1 - SPOON
    coffeeJar sugarJar - JAR
    tapWater1 - TAPWATER
    grinder - GRINDER
    stove - STOVE
    cup - CUP
    moka1 - MOKA
    sugar - SUGAR
    coffee - COFFEE
  )
  (:init 
    (AGENT agent)
    (SUGAR sugar) (COFFEE coffee)
    (LOCATION storing) (LOCATION workTable) (LOCATION rest)
    (DRAWER drawer1) (DRAWER drawer2)
    (JAR coffeeJar) (JAR sugarJar)
    (TAPWATER tapWater1)
    (GRINDER grinder)
    (SPOON spoon1)
    (MOKA moka1)
    (STOVE stove)
    (CUP cup)
    (GRINDER grinder)


    (at-location agent rest)
    (at-location grinder workTable)
    (at-location drawer1 storing)
    (at-location drawer2 storing)
    (at-location tapWater1 workTable)
    (at-location stove workTable)


    (in-drawer spoon1 drawer1)
    (in-drawer cup drawer1)
    (in-drawer sugar drawer1)
    (in-drawer coffee drawer1)

    (in-drawer moka1 drawer2)
    (in-drawer coffeeJar drawer2)
    (in-drawer sugarJar drawer2)

    (in-jar coffee coffeeJar)
    (in-jar sugar sugarJar)
    
    (is-top moka1)
    (is-screwed moka1)
    (is-free agent) 
  )
  (:goal 
    (and 
      (is-full cup)
      (not(is-open drawer1))
      (not(is-open drawer2))
      (not(is-open tapWater1))
      (not(is-open coffeeJar))
      (not(is-open sugarJar))
      (is-top moka1)
    )
  )
)
